`include "includes.v"
/***********************************************************************
This file is part of the OpenADC Project. See www.newae.com for more details,
or the codebase at http://www.assembla.com/spaces/openadc .

This file is the FIFO interface. It provides a simple interface to the FIFO
memory in the FPGA.

Copyright (c) 2012, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
This project is released under the Modified FreeBSD License. See LICENSE
file which should have came with this code.
*************************************************************************/
//`define CHIPSCOPE
module fifo_top(
    input         reset_i,
	 output			reset_o,
    input			clk_100mhz_in,
	 output			clk_100mhz_out,
	 
	 //ADC Sample Input
	 input [9:0]   adc_datain,
	 input 			adc_sampleclk,
	 input			adc_or,
	 input			adc_trig_status,
	 input			adc_capture_go, //Set to '1' to start capture, keep at 1 until adc_capture_stop goes high
	 output			adc_capture_stop,
	 
	 //FIFO to USB Read Interface
	 input			fifo_read_fifoclk,
	 input			fifo_read_fifoen,
	 output			fifo_read_fifoempty,
	 output [7:0]	fifo_read_data,
	 
	 input  [31:0]	max_samples_i,
	 output [31:0]	max_samples_o
	 
`ifdef CHIPSCOPE
	 ,inout [35:0]  chipscope_control
`endif
	 );
	

	wire [31:0] 	adcfifo_in;	
	reg [2:0]  		adcfifo_merge_cnt;
	reg        		adcfifo_or;
	reg				adcfifo_trigstat;
	reg [9:0]		adcfifo_adcsample0;
	reg [9:0]		adcfifo_adcsample1;
	reg [9:0]		adcfifo_adcsample2;
	
	wire 				adcfifo_full;
	wire 				adcfifo_empty;
	reg 				adcfifo_wr_en;
	wire 	[31:0] 	adcfifo_dout;
	
	reg [31:0]  	sample_counter; //How many samples gone through fifo
	
	reg 				adc_capture_stop_reg;
	assign			adc_capture_stop = adc_capture_stop_reg;
	
	
	IBUFG IBUFG_inst (
	.O(clk_100mhz_out),
	.I(clk_100mhz_in) );
		
	assign reset_o = reset_i;
	
	//3 samples per 4 bytes
	assign max_samples_o = 32'd`MAX_SAMPLES ;
	
	always@(posedge adc_sampleclk) begin
		if ((sample_counter < max_samples_i) && (adcfifo_full == 0)) begin
				adc_capture_stop_reg <= 0;
		end else begin
				adc_capture_stop_reg <= 1;
		end
	end
		
	always@(posedge adc_sampleclk) begin
		if (~adc_capture_go) begin
			sample_counter <= 0;
			adcfifo_merge_cnt <= 'b001;
			adcfifo_wr_en <= 0;
		end else begin
			sample_counter <= sample_counter + 1;
		
			if (adcfifo_merge_cnt == 'b001)
				adcfifo_adcsample0 <= adc_datain;
			else if (adcfifo_merge_cnt == 'b010)
				adcfifo_adcsample1 <= adc_datain;
			else if (adcfifo_merge_cnt == 'b100)
				adcfifo_adcsample2 <= adc_datain;

			adcfifo_or <= adc_or;
			adcfifo_trigstat <= adc_trig_status;
			
			if (adcfifo_merge_cnt == 'b100) begin
				adcfifo_merge_cnt <= 'b001;
				adcfifo_wr_en <= 1;
			end else begin
				adcfifo_merge_cnt <= adcfifo_merge_cnt << 1;
				adcfifo_wr_en <= 0;
			end
		end
	end
	
	assign adcfifo_in[31] = adcfifo_or;
	assign adcfifo_in[30] = adcfifo_trigstat;
	assign adcfifo_in[29:20] = adcfifo_adcsample2;
	assign adcfifo_in[19:10] = adcfifo_adcsample1;
	assign adcfifo_in[9:0] = adcfifo_adcsample0;
		
	fifoonly_adcfifo fifoonly_adcfifo_inst (
  .rst(reset_i), // input rst
  .wr_clk(adc_sampleclk), // input wr_clk
  .rd_clk(fifo_read_fifoclk), // input rd_clk
  .din(adcfifo_in), // input [31 : 0] din
  .wr_en(adcfifo_wr_en), // input wr_en
  .rd_en(fifo_read_fifoen), // input rd_en
  .dout(fifo_read_data), // output [7 : 0] dout
  .full(adcfifo_full), // output full
  .empty(fifo_read_fifoempty) // output empty
);

`ifdef CHIPSCOPE
	wire [127:0] cs_data;
	
	assign cs_data[31:0] = max_samples_o;
	assign cs_data[63:32] = max_samples_i;
	assign cs_data[95:64] = sample_counter;
	assign cs_data[96] = adcfifo_full;
	assign cs_data[97] = adc_capture_go;
	assign cs_data[98] = fifo_read_fifoempty;
	assign cs_data[99] = fifo_read_fifoen;
	    
   coregen_ila ila (
    .CONTROL(chipscope_control), // INOUT BUS [35:0]
    .CLK(adc_sampleclk), // IN
    .TRIG0(cs_data) // IN BUS [127:0]
   );
	
`endif

	
endmodule
