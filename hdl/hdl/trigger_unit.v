`timescale 1ns / 1ps

/***********************************************************************
This file is part of the OpenADC Project. See www.newae.com for more details,
or the codebase at http://www.assembla.com/spaces/openadc .

This file is the trigger unit.

Copyright (c) 2012, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
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
module trigger_unit(
	 input			reset,				//system reset
	 input			clk,					//system clock

    input			adc_clk,				//ADC sample clock
	 input [9:0]   adc_data,			//ADC data
	
    input 			ext_trigger_i,
    input 			trigger_level_i,    //1 = trigger on high or rising edge
	                                   //0 = trigger on low or falling edge											  
    input 			trigger_wait_i,     //1 = wait for trigger to go to 'inactive' state first (e.g.: edge sensitive)
	                                   //0 = don't wait											  
	 input [9:0] 	trigger_adclevel_i, //Internal (e.g.: from ADC) trigger level 
    input 			trigger_source_i,   //0 = External trigger, 1 = internal trigger
    input 			trigger_now_i,      //1 = Trigger immediatly when armed
	 input         arm_i,				  //1 = arm, edge-sensitive so must be reset to 0 before arming again. Wait until the
												  //    arm_o goes high before doing this, otherwise the arm won't take effect.
	 output			arm_o,				  //Status of internal arm logic
	 
	 input [31:0]  trigger_offset_i,   //Delays the capture_go_o by this many ADC clock cycles
	 
	 output        capture_go_o,		  //1 = trigger conditions met, stays high until 'capture_done_i' goes high
	 input         capture_done_i		  //1 = capture done
    );

	//**** Trigger Logic Selection ****
	wire trigger;
	wire adc_trigger;
		
	//Compare incomming data to requested level
	assign adc_trigger = adc_data > trigger_adclevel_i;
	
	assign trigger = (trigger_source_i) ? adc_trigger : ext_trigger_i;

	//**** Trigger Logic *****	
	reg 	armed;
	assign arm_o = armed;
	
	wire 	adc_capture_done;
	reg 	adc_capture_go;
	reg 	adc_capture_go_delayed;
	
	assign adc_capture_done = capture_done_i;
	assign capture_go_o = adc_capture_go_delayed;
	
	reg [31:0] adc_delay_cnt;
	
	always @(posedge adc_clk) begin
		if (adc_capture_go == 1'b0) begin
			adc_delay_cnt <= 0;
		end else begin
			adc_delay_cnt <= adc_delay_cnt + 1;
		end
	end
	
	always @(posedge adc_clk or negedge adc_capture_go) begin		
		if (adc_capture_go == 0)
			adc_capture_go_delayed <= 1'b0;
			
		else
			if (adc_delay_cnt == trigger_offset_i)
				adc_capture_go_delayed <= adc_capture_go;		
	end
		
	//ADC Trigger Stuff
	reg reset_arm;
	always @(posedge adc_clk) begin
		if (reset) begin
			reset_arm <= 0;
		end else begin
			if (((trigger == trigger_level_i) & armed) | (trigger_now_i)) begin				
				reset_arm <= 1;
			end else if ((arm_i == 0) & (adc_capture_go == 0)) begin
				reset_arm <= 0;
			end
		end
	end	
	
	wire int_reset_capture;
	assign int_reset_capture = adc_capture_done | reset;
	
	always @(posedge adc_clk or posedge int_reset_capture) begin
		if (int_reset_capture) begin
			adc_capture_go <= 0;
		end else begin
			if (((trigger == trigger_level_i) & armed) | (trigger_now_i)) begin
				adc_capture_go <= 1;
			end
		end
	end
	
	wire resetarm;
	wire cmd_arm;
	assign resetarm = reset | reset_arm;
		
	//'armed' goes high when arm command present & conditions met during rising clock edge
	always @(posedge clk)
	  if (resetarm) begin
			armed <= 0;
		end else if (arm_i & ((trigger != trigger_level_i) | (trigger_wait_i == 0))) begin
			armed <= 1;
		end
endmodule
