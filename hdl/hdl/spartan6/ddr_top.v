`include "includes.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:33 05/24/2010 
// Design Name: 
// Module Name:    interface 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module ddr_top(
    input         reset,
    input			clk_100mhz,
	 
	 //ADC Sample Input
	 input [9:0]   adc_datain,
	 input 			adc_sampleclk,
	 input			adc_or,
	 input			adc_trig_status,
	 input			adc_capture_go, //Set to '1' to start capture, keep at 1 until adc_capture_stop goes high
	 output			adc_capture_stop,
	 
	 //DDR to USB Read Interface
	 input			ddr_read_req,
	 output			ddr_read_done,
	 input [31:0]	ddr_read_address,
	 input			ddr_read_fifoclk,
	 input			ddr_read_fifoen,
	 output			ddr_read_fifoempty,
	 output [7:0]	ddr_read_data,
	 output			ddr_cal_done,
	 
	 //DDR HW Interface
	 output [12:0] LPDDR_A,
	 output [1:0]  LPDDR_BA,
	 inout  [15:0] LPDDR_DQ,
	 output        LPDDR_LDM,
	 output        LPDDR_UDM,
	 inout			LPDDR_LDQS,
	 inout			LPDDR_UDQS,
	 output			LPDDR_CK_N,
	 output			LPDDR_CK_P,
	 output			LPDDR_CKE,
	 output			LPDDR_CAS_n,
	 output			LPDDR_RAS_n,
	 output			LPDDR_WE_n,
	 output			LPDDR_RZQ	 
	 );
	 	 
	wire 				ddrfifo_wr_clk;
	wire [7:0] 		ddrfifo_din;
	wire [7:0] 		ddrfifo_dout;
	reg 				ddrfifo_wr_en;
	wire 				ddrfifo_full;
	wire				ddrfifo_empty;
	wire				ddrfifo_rd_en;
	wire				ddrfifo_rd_clk;	 

	//wire				c3_p2_cmd_clk;
   reg				c3_p2_cmd_en;
   //wire [2:0]		c3_p2_cmd_instr;
   //wire [5:0]		c3_p2_cmd_bl;
   //wire [29:0]		c3_p2_cmd_byte_addr;
   wire				c3_p2_cmd_empty;
   wire				c3_p2_cmd_full;
   //wire				c3_p2_rd_clk,
   wire				c3_p2_rd_en;
   wire [31:0]		c3_p2_rd_data;
   wire				c3_p2_rd_full;
   wire				c3_p2_rd_empty;
   wire [6:0]		c3_p2_rd_count;
   wire				c3_p2_rd_overflow;
   wire				c3_p2_rd_error;
	 
	//wire 				c3_p3_cmd_clk;
	reg 				c3_p3_cmd_en;
	//wire [2:0] 		c3_p3_cmd_instr;
	//wire [5:0] 		c3_p3_cmd_bl;
	wire [29:0] 	c3_p3_cmd_byte_addr;
	wire 				c3_p3_cmd_empty;
	wire 				c3_p3_cmd_full;
	
	//wire 				c3_p3_wr_clk;
	reg 				c3_p3_wr_en;
	wire 	[3:0] 	c3_p3_wr_mask;
	wire [31:0] 	c3_p3_wr_data;
	wire 				c3_p3_wr_full;
	wire 				c3_p3_wr_empty;
	wire [6:0] 		c3_p3_wr_count;
	wire 				c3_p3_wr_underrun;
	wire 				c3_p3_wr_error;
	
	wire				c3_calib_done;

	wire				adcfifo_rd_clk;
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
	reg 				adcfifo_rd_en;
	wire 	[31:0] 	adcfifo_dout;
	wire 				adcfifo_has64;
	
	reg				ddr_read_done_reg;
	assign			ddr_read_done = ddr_read_done_reg;
	
	reg [31:0]  	sample_counter; //How many 3-sample tuples gone through fifo
	
	reg 				adc_capture_stop_reg;
	assign			adc_capture_stop = adc_capture_stop_reg;
	
	always@(posedge adc_sampleclk) begin
		if (sample_counter > 4000) begin
				adc_capture_stop_reg <= 1;
		end else begin
				adc_capture_stop_reg <= 0;
		end
	end
		
	always@(posedge adc_sampleclk) begin
		if (~adc_capture_go) begin
			sample_counter <= 0;
			adcfifo_merge_cnt <= 'b001;
			adcfifo_wr_en <= 0;
		end else begin
			if (adcfifo_merge_cnt == 'b001)
				adcfifo_adcsample0 = adc_datain;
			else if (adcfifo_merge_cnt == 'b010)
				adcfifo_adcsample1 = adc_datain;
			else if (adcfifo_merge_cnt == 'b100)
				adcfifo_adcsample2 = adc_datain;

			adcfifo_or = adc_or;
			adcfifo_trigstat = adc_trig_status;
			if (adcfifo_merge_cnt == 'b100) begin
				adcfifo_merge_cnt <= 'b001;
				adcfifo_wr_en <= 1;
				sample_counter <= sample_counter + 1;
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
	
	assign adcfifo_rd_clk = ddr_usrclk;
	
	

	//Generate ADC FIFO
	//NOTE: Fifo is fall-through-first-word (FTFW)
	adc_fifo adcfifo (
	  .wr_clk(adc_sampleclk), // input wr_clk
	  .rst(reset), // input rst
	  .rd_clk(adcfifo_rd_clk), // input rd_clk
	  .din(adcfifo_in), // input [31 : 0] din
	  .wr_en(adcfifo_wr_en), // input wr_en
	  .rd_en(adcfifo_rd_en), // input rd_en
	  .dout(adcfifo_dout), // output [31 : 0] dout
	  .full(adcfifo_full), // output full
	  .empty(adcfifo_empty), // output empty
	  .prog_full(adcfifo_has64) // has 64 words at least
	);  

	//Connect up DDR with big ol state machine
	`define IDLE           'b0000
   `define DATA_WAIT      'b0001
   `define DATA_WRITE     'b0010
   `define CMD_WAIT       'b0011
   `define CMD_WRITE      'b0100


	assign c3_p3_wr_clk = ddr_usrclk;
	assign c3_p3_cmd_clk =  ddr_usrclk;

	reg [31:0] ddr_write_addr;
	reg [6:0]  ddr_fifo_datawritten;

	reg [3:0] state;

	always @(posedge ddr_usrclk or posedge ddr_usrreset)
    begin
      if (reset == 1) begin
         state <= `IDLE; 
         c3_p3_cmd_en <= 0;
			ddr_write_addr <= 0;	
			ddr_fifo_datawritten <= 0;
			c3_p3_wr_en <= 0;
			adcfifo_rd_en <= 0;	
      end else begin
         case (state)
            `IDLE: begin
					c3_p3_cmd_en <= 0;
					ddr_write_addr <= 0;	
					ddr_fifo_datawritten <= 0;
					c3_p3_wr_en <= 0;
					adcfifo_rd_en <= 0;	
					
					if (adc_capture_go) begin
						state <= `DATA_WAIT;
					end else begin
						state <= `IDLE;
					end
            end
				
				`DATA_WAIT: begin
					c3_p3_cmd_en <= 0;
					//Wait for 64 bytes in ADC fifo
					ddr_fifo_datawritten <= 0;
					c3_p3_wr_en <= 0;
					adcfifo_rd_en <= 0;
					if (adcfifo_has64 & ~c3_p3_wr_full) begin
						state <= `DATA_WRITE;					
					end else begin
						state <= `DATA_WAIT;
					end
				end
				
				`DATA_WRITE: begin
					c3_p3_cmd_en <= 0;
					if (ddr_fifo_datawritten == 7'd64) begin
						state <= `CMD_WAIT;
						c3_p3_wr_en <= 0;
						adcfifo_rd_en <= 0;
					end else	if (~c3_p3_wr_full) begin
						ddr_fifo_datawritten <= ddr_fifo_datawritten + 1;
						c3_p3_wr_en <= 1;
						adcfifo_rd_en <= 1;
						state <= `DATA_WRITE;
					end else begin
						c3_p3_wr_en <= 0;	
						adcfifo_rd_en <= 0;	
						state <= `DATA_WRITE;
					end
				end
				
				`CMD_WAIT: begin
					c3_p3_wr_en <= 0;
					adcfifo_rd_en <= 0;	
					if (~c3_p3_cmd_full) begin
						state <= `DATA_WAIT;
						c3_p3_cmd_en <= 1;
						ddr_write_addr <= ddr_write_addr + 256;
					end else begin
						state <= `CMD_WAIT;
						c3_p3_cmd_en <= 0;
					end
				end				
			endcase
		end
	 end               
	 
	 
   ddr_interface # (
		 .C3_P0_MASK_SIZE(4),
		 .C3_P0_DATA_PORT_SIZE(32),
		 .C3_P1_MASK_SIZE(4),
		 .C3_P1_DATA_PORT_SIZE(32),
		 .DEBUG_EN(0),
		 .C3_MEMCLK_PERIOD(10000),
		 .C3_CALIB_SOFT_IP("TRUE"),
		 .C3_SIMULATION("TRUE"),
		 .C3_RST_ACT_LOW(0),
		 .C3_INPUT_CLK_TYPE("SINGLE_ENDED"),
		 .C3_MEM_ADDR_ORDER("BANK_ROW_COLUMN"),
		 .C3_NUM_DQ_PINS(16),
		 .C3_MEM_ADDR_WIDTH(13),
		 .C3_MEM_BANKADDR_WIDTH(2)
	)
	u_ddr_interface (

	  .c3_sys_clk           (clk_100mhz),
	  .c3_sys_rst_i           (reset),                        

	  .mcb3_dram_dq           (LPDDR_DQ),  
	  .mcb3_dram_a            (LPDDR_A),  
	  .mcb3_dram_ba           (LPDDR_BA),
	  .mcb3_dram_ras_n        (LPDDR_RAS_n),                        
	  .mcb3_dram_cas_n        (LPDDR_CAS_n),                        
	  .mcb3_dram_we_n         (LPDDR_WE_n),                          
	  .mcb3_dram_cke          (LPDDR_CKE),                          
	  .mcb3_dram_ck           (LPDDR_CK_P),                          
	  .mcb3_dram_ck_n         (LPDDR_CK_N),       
	  .mcb3_dram_dqs          (LPDDR_LDQS),
	  .mcb3_dram_udqs         (LPDDR_UDQS),    // for X16 parts
	  .mcb3_dram_udm          (LPDDR_UDM),     // for X16 parts
	  .mcb3_dram_dm           (LPDDR_LDM),

	  .c3_clk0		        (ddr_usrclk),
	  .c3_rst0		        (ddr_usrreset),
			 
	  .c3_calib_done    (ddr_cal_done),
	  
	  .mcb3_rzq               (LPDDR_RZQ),
			  
		.c3_p2_cmd_clk                          (ddr_usrclk),
		.c3_p2_cmd_en                           (c3_p2_cmd_en),
		.c3_p2_cmd_instr                        (3'b001), //READ command
		.c3_p2_cmd_bl                           (6'd63), //64 word burst
		.c3_p2_cmd_byte_addr                    (ddr_read_address[29:0]),
		.c3_p2_cmd_empty                        (c3_p2_cmd_empty),
		.c3_p2_cmd_full                         (c3_p2_cmd_full),
		.c3_p2_rd_clk                           (ddr_usrclk),
		.c3_p2_rd_en                            (c3_p2_rd_en),
		.c3_p2_rd_data                          (c3_p2_rd_data),
		.c3_p2_rd_full                          (c3_p2_rd_full),
		.c3_p2_rd_empty                         (c3_p2_rd_empty),
		.c3_p2_rd_count                         (c3_p2_rd_count),
		.c3_p2_rd_overflow                      (c3_p2_rd_overflow),
		.c3_p2_rd_error                         (c3_p2_rd_error),
		
		.c3_p3_cmd_clk                          (ddr_usrclk),
		.c3_p3_cmd_en                           (c3_p3_cmd_en),
		.c3_p3_cmd_instr                        (3'b000), //WRITE command
		.c3_p3_cmd_bl                           (6'd63), //64 word burst
		.c3_p3_cmd_byte_addr                    (c3_p3_cmd_byte_addr),
		.c3_p3_cmd_empty                        (c3_p3_cmd_empty),
		.c3_p3_cmd_full                         (c3_p3_cmd_full),
		.c3_p3_wr_clk                           (ddr_usrclk),
		.c3_p3_wr_en                            (c3_p3_wr_en),
		.c3_p3_wr_mask                          (0),
		.c3_p3_wr_data                          (c3_p3_wr_data),
		.c3_p3_wr_full                          (c3_p3_wr_full),
		.c3_p3_wr_empty                         (c3_p3_wr_empty),
		.c3_p3_wr_count                         (c3_p3_wr_count),
		.c3_p3_wr_underrun                      (c3_p3_wr_underrun),
		.c3_p3_wr_error                         (c3_p3_wr_error)
	);
	
	/* READ LOGIC */
	`define DDRREAD_READ  	'b0001
	`define DDRREAD_LOAD1   'b0010
	reg [3:0] 		ddrread_state;	
	
	assign c3_p2_rd_en = ~c3_p2_rd_empty;
	always @(posedge ddr_usrclk) begin
		ddrfifo_wr_en <= c3_p2_rd_en;	
	end
	
	ddr_read_fifo ddr_resize_fifo (
		.rst(reset), // input rst
		.wr_clk(ddr_usrclk), // input wr_clk
		.rd_clk(ddrfifo_rd_clk), // input rd_clk
		.din(c3_p2_rd_data), // input [31 : 0] din
		.wr_en(ddrfifo_wr_en), // input wr_en
		.rd_en(ddrfifo_rd_en), // input rd_en
		.dout(ddrfifo_dout), // output [7 : 0] dout
		.full(ddrfifo_full), // output full
		.empty(ddrfifo_empty) // output empty
	);
	
	
	always @(posedge ddr_usrclk or posedge ddr_usrreset)
    begin
      if (reset == 1) begin
         state <= `IDLE; 
      end else begin
		case (ddrread_state)
            `IDLE: begin
					ddr_read_done_reg <= 0;
					if (ddr_read_req) begin
						ddrread_state <= `DDRREAD_READ;
						c3_p2_cmd_en <= 1;
					end else begin
						ddrread_state <= `IDLE;
						c3_p2_cmd_en <= 0;
					end
				end
				
				`DDRREAD_READ: begin
					c3_p2_cmd_en <= 0;
					if (ddrfifo_full) begin
						ddr_read_done_reg <= 1;
						ddrread_state <= `DDRREAD_LOAD1;
					end else begin
						ddr_read_done_reg <= 0;
						ddrread_state <= `DDRREAD_READ;
					end
				end
				
				`DDRREAD_LOAD1: begin
					ddr_read_done_reg <= 1;
					ddrread_state <= `IDLE;
				end
		endcase		
		end
	end
endmodule
