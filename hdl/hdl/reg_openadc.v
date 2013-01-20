`include "includes.v"
//`define CHIPSCOPE

/***********************************************************************
This file is part of the OpenADC Project. See www.newae.com for more details,
or the codebase at http://www.assembla.com/spaces/openadc .

This file is the OpenADC main registers. Does not include the actual data
transfer register which is in a seperate file.

Copyright (c) 2013, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
This project (and file) is released under the 2-Clause BSD License:

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright notice,
	  this list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above copyright
	  notice, this list of conditions and the following disclaimer in the
	  documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.


*************************************************************************/
module reg_openadc(
	input 			reset_i,
	output			reset_o,
	input 			clk,
	input [5:0]    reg_address,  // Address of register
	input [15:0]   reg_bytecnt,  // Current byte count
	input [7:0]    reg_datai,    // Data to write
	inout  [7:0]   reg_datao,    // Data to read
	input [15:0]   reg_size,     // Total size being read/write
	input          reg_read,     // Read flag
	input  			reg_write,    // Write flag
	input          reg_addrvalid,// Address valid flag
	output			reg_stream,	
	
	input [5:0]    reg_hypaddress,
	output  [15:0] reg_hyplen,
	
			
	/* Interface to gain module */
	output [7:0]	gain,
	output			hilow,
	
	/* General status stuff input */
	input [7:0]		status,
														
	/* Interface to trigger unit */
	output 			cmd_arm,
	output 			trigger_mode,
	output 			trigger_wait,
	output [9:0] 	trigger_level,
	output 			trigger_source,
	output 			trigger_now,
	output [31:0]  trigger_offset,
	
	/* Measurement of external clock frequency */
	input [31:0]	extclk_frequency,
	
	/* Interface to phase shift module */
	output			phase_clk_o,
	output [8:0]	phase_o,
	output			phase_ld_o,
	input  [8:0]	phase_i,
	input				phase_done_i,
	
	/* Additional ADC control lines */
	output			adc_clk_src_o,
	output [31:0]	maxsamples_o,
	input  [31:0]  maxsamples_i										              

    );
	 
	 wire	  reset;
	 reg 	  reset_latched;
	 assign reset = reset_i | reset_latched;
	 assign reset_o = reset;
 	 
	 assign phase_clk_o = clk;
    
`ifdef CHIPSCOPE
   wire [127:0] cs_data;   
   wire [35:0]  chipscope_control;
  coregen_icon icon (
    .CONTROL0(chipscope_control) // INOUT BUS [35:0]
   ); 

   coregen_ila ila (
    .CONTROL(chipscope_control), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(cs_data) // IN BUS [127:0]
   );  
`endif
        	  
    //Register definitions
    reg [7:0]  registers_gain;
    reg [7:0]  registers_settings;
	 reg [7:0]  registers_echo;
	 reg [31:0] registers_extclk_frequency;
	 reg [31:0] registers_ddr_address;
	 reg [31:0] registers_samples;
	 reg [127:0] registers_offset;
	 reg [15:0]	phase_out;
	 reg [8:0]  phase_in;
	 reg        phase_loadout;
	 reg			phase_done;		
	
    assign trigger_offset = registers_offset;
	 
	 assign phase_o = phase_out[8:0];
	 assign phase_ld_o = phase_loadout;
	 
	 always @(posedge clk) begin
		if (reset | phase_loadout) begin
			phase_in <= 0;
			phase_done <= 0;
		end else if (phase_done_i) begin
			phase_in <= phase_i;
			phase_done <= 1;
		end
	 end
	 	 
	 reg [15:0] reg_hyplen_reg;
	 assign reg_hyplen = reg_hyplen_reg;
	 
	 always @(reg_hypaddress) begin
		case (reg_hypaddress)
            `GAIN_ADDR: reg_hyplen_reg <= 1;
				`SETTINGS_ADDR: reg_hyplen_reg <= 1;
				`STATUS_ADDR: reg_hyplen_reg <= 1;
				`ECHO_ADDR: reg_hyplen_reg <= 1;
				`EXTFREQ_ADDR: reg_hyplen_reg <= `EXTFREQ_LEN;
				`PHASE_ADDR: reg_hyplen_reg <= `PHASE_LEN;
				`SAMPLES_ADDR: reg_hyplen_reg <= `SAMPLES_LEN;
				`OFFSET_ADDR: reg_hyplen_reg <= `OFFSET_LEN;
				default: reg_hyplen_reg<= 0;
		endcase
	 end
	 	    
	 assign reset_fromreg = registers_settings[0];
	 assign hilow = registers_settings[1];
	 assign trigger_mode = registers_settings[2];
	 assign cmd_arm = registers_settings[3];
	 assign trigger_wait = registers_settings[5];
	 assign adc_clk_src_o = registers_settings[6];
	 
	 assign gain = registers_gain;
	 assign maxsamples_o = registers_samples;
	 
	 reg extclk_locked;
	  
	 always @(posedge clk) begin
		reset_latched <= reset_fromreg;
	 end
	  
	 always @(posedge clk)
	 begin
		if (extclk_locked == 0) begin
			registers_extclk_frequency <= extclk_frequency;
		end
	 end

	 reg [7:0] reg_datao_reg;
	 reg reg_datao_valid_reg;
	 assign reg_datao = (reg_datao_valid_reg & reg_read) ? reg_datao_reg : 8'bZZZZZZZZ;

	 always @(posedge clk) begin	
		if (reg_addrvalid) begin
			if (reg_address == `EXTFREQ_ADDR) begin
				extclk_locked <= 1;
			end else begin
				extclk_locked <= 0;
			end
		end
	 end

	 always @(posedge clk) begin
		if (reg_addrvalid) begin
			case (reg_address)
				`GAIN_ADDR: begin reg_datao_valid_reg <= 1; end
				`SETTINGS_ADDR: begin reg_datao_valid_reg <= 1; end
				`STATUS_ADDR: begin reg_datao_valid_reg <= 1; end
				`ECHO_ADDR: begin reg_datao_valid_reg <= 1; end
				`EXTFREQ_ADDR: begin reg_datao_valid_reg <= 1; end
				`PHASE_ADDR: begin reg_datao_valid_reg <= 1; end
				`SAMPLES_ADDR: begin reg_datao_valid_reg <= 1; end	
				`OFFSET_ADDR: begin reg_datao_valid_reg <= 1; end	
				default: begin reg_datao_valid_reg <= 0; end	
			endcase
		end else begin
			reg_datao_valid_reg <= 0;
		end
	 end
	 
	 always begin
		if (reg_addrvalid) begin
			case (reg_address)
				`GAIN_ADDR: reg_datao_reg <= registers_gain; 
				`SETTINGS_ADDR: reg_datao_reg <= registers_settings;
				`STATUS_ADDR: reg_datao_reg <= status; 
				`ECHO_ADDR: reg_datao_reg <= registers_echo; 
				`EXTFREQ_ADDR: reg_datao_reg <= registers_extclk_frequency[reg_bytecnt*8 +: 8]; 
				`PHASE_ADDR: reg_datao_reg <= phase_in[reg_bytecnt*8 +: 8]; 
				`SAMPLES_ADDR: reg_datao_reg <= registers_samples[reg_bytecnt*8 +: 8];
				`OFFSET_ADDR: reg_datao_reg <= registers_offset[reg_bytecnt*8 +: 8];
				default: reg_datao_reg <= 0;	
			endcase
		end
	 end

	 always @(posedge clk) begin
		if (reset) begin
			registers_gain <= 0;
			registers_settings <= 0;
			registers_echo <= 0;
			registers_samples <= maxsamples_i;
			registers_offset <= 0;
		end else if (reg_write) begin
			case (reg_address)
				`GAIN_ADDR: registers_gain <= reg_datai;
				`SETTINGS_ADDR: registers_settings <= reg_datai;
				`ECHO_ADDR: registers_echo <= reg_datai;
				`SAMPLES_ADDR: registers_samples[reg_bytecnt*8 +: 8] <= reg_datai;	
				`OFFSET_ADDR: registers_offset[reg_bytecnt*8 +: 8] <= reg_datai;
				default: ;
			endcase
		end
	 end	 
	 
	 always @(posedge clk) begin
		if (reset) begin
			phase_out <= 0;
		end else if (phase_out[9] == 1) begin
			phase_loadout <= 1;
			phase_out[9] <= 0;
		end else if (reg_write) begin
			if (reg_address == `PHASE_ADDR) begin
				phase_out[reg_bytecnt*8 +: 8] <= reg_datai;
			end		
		end
	 end	
			
 `ifdef CHIPSCOPE
	 assign cs_data[5:0] = reg_address;
	 assign cs_data[21:6] = reg_bytecnt;
	 assign cs_data[29:22] = reg_datai;
	 assign cs_data[37:30] = reg_datao;
	 assign cs_data[38] = reg_read;
	 assign cs_data[39] = reg_write;
	 assign cs_data[40] = reg_addrvalid;
	 assign cs_data[46:41] = reg_hypaddress;
	 assign cs_data[62:47] = reg_hyplen;
 `endif
 
endmodule

`undef CHIPSCOPE
