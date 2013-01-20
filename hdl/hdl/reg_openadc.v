`include "includes.v"
`define CHIPSCOPE

/***********************************************************************
This file is part of the OpenADC Project. See www.newae.com for more details,
or the codebase at http://www.assembla.com/spaces/openadc .

This file is the computer interface. It provides a simple interface to the
rest of the board.

Copyright (c) 2012-2013, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
This project is released under the Modified FreeBSD License. See LICENSE
file which should have came with this code.

Notes on interface:

[ 1 RW A5 A4 A3 A2 A1 A0] - Header
[ Write/Read Size LSB   ] - Size, '0' is special case for read which means 'natural size'
[ Write/Read Size MSB   ] 
[ Data Byte 0           ]
[ Data Byte 1           ]
 .......................
[ Data Byte N           ] - Payload size (Variable Length). On WR sent in, on RD sent out
[ Checksum Byte         ] - Checksum, on WR sent in, on RD sent out.


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
	 
	 /* Registers:
	 
	 0x00 - Gain Settings (One Byte)
	 
	   [ G7 G6 G5 G4 G3 G2 G1 G0 ]
		
		  G = 8-bit PWM setting for gain voltage.
		      Voltage = G / 256 * VCCIO
	 
	 0x01 - Settings (One Byte)
	 
	   [  I  C  W  P  A  T  H  R ]
	     
		  R = (bit 0) System Reset, active high
		  H = (bit 1) Hilo output to amplifier
		  T = (bit 2) Trigger Polarity:
		      1 = Trigger when 'trig in' = 1
				0 = Trigger when 'trig in' = 0
		  A = (bit 3) Arm Trigger
		      1 = Arm trigger
				0 = No effect, but you must clear bit to 0
				    before next trigger cycle can be started
		  P = (bit 4) DUT Clkin PLL Reset
		      1 = Reset to PLL active (must do this when ext clock changes)
				0 = Reset to PLL inactive
		  W = (bit 5) Before arming wait for trigger to go inactive (e.g: edge sensitive)
		      1 = Wait for trigger to go inactive before arming
				0 = Arm immediatly, which if trigger line is currently in active state
				    will also immediatly trigger
		  C = (bit 6) Select clock source for ADC
		      1 = External x4
				0 = Internal 100 MHz				
		  I = (bit 7) Select trigger source: int/ext
		      1 = Internal (e.g.: based on ADC reading)
				0 = External (e.g.: based on trigger-in line)
		  
	 0x02 - Status (One Byte)
	 
	    [  X  M  DC DE P  E  F  T ] 
		 T = (bit 0) Triggered status
		      1 = System armed
				0 = System disarmed		
		 F = (bit 1) Capture Status
		      1 = FIFO Full / Capture Done
				0 = FIFO Not Full / Capture Not Done
		 E = (bit 2) External trigger status
		      1 = Trigger line high
				0 = Trigger line low
		 P = (bit 3) DUT Clkin PLL Status
		      1 = Locked / OK
				0 = Unlocked				
		 DE = (bit 4) DDR Error
		      1 = DDR error (FIFO underflow/overflow or DDR Error)
				0 = No error		 
		 DC = (bit 5) DDR Calibration Done
		      1 = Cal done OK
				0 = Cal in progress/failed	
		 M =  (bit 6) Memory Mode
		      1 = DDR
				0 = FIFO
		
	 0x03 - ADC Readings
	 
       Data is read from this register by issuing a READ command.
		 The entire contents of the FIFO will be dumped following
		 that read command (e.g.: number of samples requested), or
		 in DDR mode a different formatting is used (described elsewhere)
	 
	    [  1  X  X  P OR D9 D8 D7 ]
		 
		 [  0 D6 D5 D4 D3 D2 D1 D0 ]
	 
	 0x04 - Echo Register (1 byte)
	 
		 [ E7 E6 E5 E4 E3 E2 E1 E0 ]
		 
		 E = Write data to this register then read back to
		     confirm device connection is OK	

	 0x05 - External Frequency Counter (4 bytes)
	 
	 0x09 - Phase Adjust (2 Bytes)
	 
	    [ P7 P6 P5 P4 P3 P2 P1 P0 ] (Byte 0)	    
		 [                    S P8 ] (Byte 1)
		 
		 S = Start (write), Status (read)
		 
	 0x10 - Number of samples to capture on trigger (4 Bytes)
	    On reset set to maximum number of samples possible.
	    [ LSB ] (Byte 0)
		 [     ] (Byte 1)
		 [     ] (Byte 2)
		 [ MSB ] (Byte 3)
	 
	 0x14 - DDR address to read from (4 Bytes)
	 
	    This must be 32-bit aligned, e.g. lower 2 bits are zero.
		 This register is automatically incremented following a
		 READ command. So to dump entire memory set DDR address to
		 'zero' then issue read commands.
		 
		 [ LSB ] (Byte 0)
		 [     ] (Byte 1)
		 [     ] (Byte 2)
		 [ MSB ] (Byte 3)
		 
	 0x18 - ADC Trigger Level (2 Bytes)
	 
	    [ LSB ] (Byte 0)
		 [ MSB ] (Byte 1)
	 
	 0x1A - Offset of trigger to start of capture, clock cycles (8 Bytes)
	   
		 [ LSB ] (Byte 0)
		 [     ] (Byte 1)
		 [     ] (Byte 2)
		 [     ] (Byte 3)
		 [     ] (Byte 4)
		 [     ] (Byte 5)
		 [     ] (Byte 6)
		 [ MSB ] (Byte 7)


	 0x1E - Smartcard Control/Status Register
	    [ X X X S D PT C R ]	 	 
		
		 S  = (bit 4) ACK Status (R)
		      1 = Last transaction successful
				0 = Last transaction had wrong ack
		
		 B  = (bit 3) Smartcard Core Busy (R)
		      1 = Busy
				0 = Not Busy (done)
		
		 PT = (bit 2) Pass Through( R/W)
		      1 = Pass any received data to bus - done in ASYNC fasion, be careful
				0 = Pass thru disabled
		
		 C = (bit 1) Card Present (R)
		      1 = Card Inserted
				0 = No Card Present
				
		 R = (bit 0) Card Reset (R/W)
				1 = Reset Asserted (low)
				0 = Reset Deasserted (high)
	 	 
	 0x1F - Smartcard Header Register (W)
	     Always write 6 bytes here.
		    
	 
	 0x20 - Smartcard Payload Register (R/W)
	     Always write 16 bytes here. If actual
		  payload is less than 16 bytes, this will
		  be determined by numbers written into
		  the smartcard header register
		 
	*/
	 
    `define GAIN_ADDR    	0
    `define SETTINGS_ADDR  1
	 `define STATUS_ADDR    2
    `define ECHO_ADDR      4
	 `define EXTFREQ_ADDR   5
	 `define EXTFREQ_LEN    4
	 `define PHASE_ADDR     9 
	 `define PHASE_LEN      2
	 `define SAMPLES_ADDR   16
	 `define SAMPLES_LEN    4
	 `define OFFSET_ADDR    26
	 `define OFFSET_LEN		8
	 
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
			registers_samples <= 0;
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
