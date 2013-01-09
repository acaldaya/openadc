`include "includes.v"
//`define CHIPSCOPE

/***********************************************************************
This file is part of the OpenADC Project. See www.newae.com for more details,
or the codebase at http://www.assembla.com/spaces/openadc .

This file is the computer interface. It provides a simple interface to the
rest of the board.

Copyright (c) 2012, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
This project is released under the Modified FreeBSD License. See LICENSE
file which should have came with this code.
*************************************************************************/
module usb_interface(
	input 			reset_i,
	output			reset_o,
	input 			clk,
	
	/* Interface to computer (e.g.: serial, FTDI chip, etc) */
	input 			cmdfifo_rxf,
	input				cmdfifo_txe,
	output			cmdfifo_rd,
	output			cmdfifo_wr,	
	input [7:0]	   cmdfifo_din,
	output [7:0]	cmdfifo_dout,
	// Following is provided for units with half-duplex interface such as FTDI
	output			cmdfifo_isout,
	// Following is a hint that complete packet is ready in output FIFO, can be
	// completely ignored. Mostly used in USB mode.
	// *** NOT CURRENTLY IMPLEMENTED ***
	output			cmdfifo_ready,
		
	/* Interface to gain module */
	output [7:0]	gain,
	output			hilow,
	
	/* General status stuff input */
	input [7:0]		status,
								
	/* ADC Fifo Interface */
	input				fifo_empty,
	input [7:0]		fifo_data,
	output			fifo_rd_en,
	output			fifo_rd_clk,
							
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

	/* If using DDR interface additional lines required */
`ifdef USE_DDR
	 ,output [31:0] 				ddr_address,
	 output							ddr_rd_req,
	 input							ddr_rd_done
`endif

`ifdef USE_ETH
	 ,input			eth_clk,
	 input			eth_clken,
	 output			eth_start,
	 input			eth_done,
	 output [15:0] eth_datalen,
	 output [7:0]  eth_data
`endif

`ifdef USE_SCARD
	 ,output [7:0] scard_datao,
	 output        scard_dataovalid,
	 input			scard_dataofull,
	 input  [7:0]  scard_datai,
	 output        scard_dataird,
    input			scard_dataiempty,
	 input			scard_present,
	 output		   scard_reset
`endif

	/* If using chipscope implement ICON in top module, then ILA inside here */
`ifdef CHIPSCOPE
	,inout [35:0]              chipscope_control
`endif  
    );

		 
`ifdef USE_DDR
	 reg								ddr_rd_reg; 
	 assign ddr_rd_req = ddr_rd_reg;
`endif
	
    wire          				ftdi_rxf_n;
    wire          				ftdi_txe_n;	 
    reg           				ftdi_rd_n;
    reg           				ftdi_wr_n;
	 reg								fifo_rd_en_reg;
	 assign fifo_rd_en = fifo_rd_en_reg;
	 
	 wire	  reset;
	 reg 	  reset_latched;
	 assign reset = reset_i | reset_latched;
	 assign reset_o = reset;
    	 
    wire [7:0] ftdi_din;
    reg [7:0]  ftdi_dout;
    reg        ftdi_isOutput;
    wire       ftdi_clk;
    
    assign ftdi_clk = clk;
    assign ftdi_rxf_n = ~cmdfifo_rxf;
	 assign ftdi_txe_n = ~cmdfifo_txe;
	 assign ftdi_din = cmdfifo_din;
	 assign cmdfifo_dout = ftdi_dout;
	 assign cmdfifo_rd = ~ftdi_rd_n;
	 assign cmdfifo_wr = ~ftdi_wr_n;
	 assign cmdfifo_isout = ftdi_isOutput;
	 assign fifo_rd_clk = clk;
	 
	 assign phase_clk_o = clk;
    
    //For FTDI interface you would do e.g.:
    //assign ftdi_d = ftdi_isOutput ? ftdi_dout : 8'bZ;
    //assign ftdi_din = ftdi_d;
    
`ifdef CHIPSCOPE
   wire [127:0] cs_data;
    
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
	 reg [31:0] registers_offset;
	 reg [8:0]	phase_out;
	 reg [8:0]  phase_in;
	 reg        phase_loadout;
	 reg			phase_done;		
	
`ifdef USE_DDR
	 assign ddr_address = registers_ddr_address;
`endif

`ifdef USE_SCARD
	reg [7:0]	registers_scardin;
	reg [7:0]	registers_scardout;
	reg [7:0]	registers_scardctrl;
	wire [7:0]  registers_scardctrl_read;
		
	assign scard_reset = registers_scardctrl[0];
	assign scard_datao = registers_scardout;
	assign registers_scardctrl_read[0] = registers_scardctrl[0];
	assign registers_scardctrl_read[1] = scard_present;
	assign registers_scardctrl_read[2] = scard_dataofull;
	assign registers_scardctrl_read[3] = scard_dataiempty;		
`endif

    assign trigger_offset = registers_offset;
	 
	 assign phase_o = phase_out;
	 assign phase_ld_o = phase_loadout;
	 
	 always @(posedge ftdi_clk) begin
		if (reset | phase_loadout) begin
			phase_in <= 0;
			phase_done <= 0;
		end else if (phase_done_i) begin
			phase_in <= phase_i;
			phase_done <= 1;
		end
	end
	 
	 /* Registers:
	 
	 0x00 - GAIN SETTING
	 
	   [ G7 G6 G5 G4 G3 G2 G1 G0 ]
		
		  G = 8-bit PWM setting for gain voltage.
		      Voltage = G / 256 * VCCIO
	 
	 0x01 - SETTINGS
	 
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
		  
	 0x02 - STATUS
	 
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
	 
	 0x04 - Echo Register
	 
		 [ E7 E6 E5 E4 E3 E2 E1 E0 ]
		 
		 E = Write data to this register then read back to
		     confirm device connection is OK	

	 0x05 - 0x08 - External Frequency Counter
	 
	 0x09 - Phase Adjust LSB
	 
	    [ P7 P6 P5 P4 P3 P2 P1 P0 ]
		 
	 0x0A - Phase Adjust MSB
	    
		 [                    S P8 ]
		 
		 S = Start (write), Status (read)
		 
	 0x10 - 0x13 - Number of samples to capture on trigger.
	    On reset set to maximum number of samples possible.
	    0x10 - LSB
		 0x11
		 0x12
		 0x13 - MSB
	 
	 0x14 - 0x17 - DDR address to read from.
	 
	    This must be 32-bit aligned, e.g. lower 2 bits are zero.
		 This register is automatically incremented following a
		 READ command. So to dump entire memory set DDR address to
		 'zero' then issue read commands.
		 
		 0x14 - LSB
		 0x15
		 0x16
		 0x17 - MSB
		 
	 0x18 - ADC Trigger Level Low
	 0x19 - ADC Trigger Level High Bits
	 
	 0x1A - 0x1D - Offset of trigger to start of capture
	   
		 0x1A - LSB
		 0x1B
		 0x1C
		 0x1D - MSB


	 0x1E - Smartcard Control/Status Register
	    [ X X X X ER EW C R ]
		 	 
		 ER = (bit 3) Read Fifo Empty (e.g.: can read more data from 0x1F) (R)
		      1 = Empty, do not read
				0 = Read one byte
		
		 EW = (bit 2) Write Fifo Full (e.g.: can write more data to 0x20) (R)
		      1 = Full, do not write
				0 = Write one byte
		
		 C = (bit 1) Card Present (R)
		      1 = Card Inserted
				0 = No Card Present
				
		 R = (bit 0) Card Reset (R/W)
				1 = Reset Asserted (low)
				0 = Reset Deasserted (high)
	 	 
	 0x1F - Smartcard Read Register
	 
	 0x20 - Smartcard Write Register
	 
		 
	*/
	 
    `define GAIN_ADDR    	0
    `define SETTINGS_ADDR  1
	 `define STATUS_ADDR    2
    `define ADCDATA_ADDR	3
    `define ECHO_ADDR      4
	 `define EXTFREQ_ADDR1  5
	 `define EXTFREQ_ADDR2  6
	 `define EXTFREQ_ADDR3  7
	 `define EXTFREQ_ADDR4  8
	 `define PHASE_ADDR1    9
	 `define PHASE_ADDR2    10	 
	 `define SAMPLES_ADDR1  16
	 `define SAMPLES_ADDR2  17
	 `define SAMPLES_ADDR3  18
	 `define SAMPLES_ADDR4  19
	 `define DDRADDR_ADDR1  20
	 `define DDRADDR_ADDR2  21
	 `define DDRADDR_ADDR3  22
	 `define DDRADDR_ADDR4  23
	 
	 `define OFFSET_ADDR1   26
	 `define OFFSET_ADDR2   27
	 `define OFFSET_ADDR3   28
	 `define OFFSET_ADDR4   29
	 	 
`ifdef USE_SCARD
	 `define SCARDCTRL_ADDR	30
	 `define SCARDRD_ADDR	31
	 `define SCARDWR_ADDR	32
	 `define SCARDHDR_ADDR  33
`endif

	 `define MULTIECHO_ADDR	34
	 
	 `undef  IDLE
    `define IDLE            'b0000
    `define ADDR            'b0001
    `define DATAWR1         'b0010
    `define DATAWR2         'b0011
    `define DATAWRDONE      'b0100
    `define DATARDSTART     'b1000
    `define DATARD1         'b1001
    `define DATARD2         'b1010
	 `define DATARD_DDRSTART 'b1011         
	 
	 `define SCARDRD1			 'b1100
	 `define SCARDRD2			 'b1101

	 reg [8:0]					write_bytes;
	 reg [8:0]					read_bytes;
    reg [3:0]              state = `IDLE;
    reg [5:0]              address;
	 reg							extclk_locked;
	 reg 							ddr_rd_done_reg;

	 wire 						multiecho_empty;
	 wire [7:0]					multiecho_data;
	 reg [7:0] registers_multiecho;

    
	 assign reset_fromreg = registers_settings[0];
	 assign hilow = registers_settings[1];
	 assign trigger_mode = registers_settings[2];
	 assign cmd_arm = registers_settings[3];
	 assign trigger_wait = registers_settings[5];
	 assign adc_clk_src_o = registers_settings[6];
	 
	 assign gain = registers_gain;
	 assign maxsamples_o = registers_samples;
	  
	 always @(posedge ftdi_clk) begin
		reset_latched <= reset_fromreg;
	 end
	  
	 always @(posedge ftdi_clk)
	 begin
		if (extclk_locked == 0) begin
			registers_extclk_frequency <= extclk_frequency;
		end
	 end
	 
`ifdef USE_SCARD
	 reg scard_dataird_reg;
	 reg scard_dataovalid_reg;
	 	 
	 assign scard_dataird = scard_dataird_reg;
	 assign scard_dataovalid = scard_dataovalid_reg;
	 
	 always @(posedge ftdi_clk) begin
	  if ((state == `DATARDSTART) & (address == `SCARDRD_ADDR)) begin
			scard_dataird_reg <= 1'b1;
	  end else begin
			scard_dataird_reg <= 1'b0;
	  end
	 end
	 
	 always @(posedge ftdi_clk) begin
	  if ((state == `DATAWR2) & ((address == `SCARDWR_ADDR) | (address == `SCARDHDR_ADDR))) begin
			scard_dataovalid_reg <= 1'b1;
	  end else begin
			scard_dataovalid_reg <= 1'b0;
	  end
	 end			 
`endif
	 /*
	 always @(posedge cmdfifo_ready)
	 begin
		if (state == `DATARDSTART) & (addr != `ADCDATA_ADDR) begin
			cmdfifo_ready_int <= 1'b1;
		end else begin
			cmdfifo_ready_int <= 1'b0;
		end
	 end
	 */
	 assign cmdfifo_ready = 1'b0;
	 
    always @(posedge ftdi_clk)
    begin
      if (reset == 1) begin
         state <= `IDLE; 
         ftdi_rd_n <= 1;
         ftdi_wr_n <= 1;
         ftdi_isOutput <= 0;
			extclk_locked <= 0;					
			
			/* Load Default Values */
			registers_samples <= maxsamples_i;
			registers_settings <= 0;
			registers_offset <= 0;
			
      end else begin
         case (state)
            `IDLE: begin
					fifo_rd_en_reg <= 0;
               if (ftdi_rxf_n == 0) begin
                  ftdi_rd_n <= 0;
                  ftdi_wr_n <= 1;
                  ftdi_isOutput <= 0;
                  state <= `ADDR;
               end else begin
                  ftdi_rd_n <= 1;
                  ftdi_wr_n <= 1;
                  ftdi_isOutput <= 0;
                  state <= `IDLE;
               end
            end

            `ADDR: begin					
					read_bytes <= 1;					
					case(ftdi_din[5:0])
						`SCARDHDR_ADDR: write_bytes <= 5;	
						`MULTIECHO_ADDR: write_bytes <= 500;
						default: write_bytes <= 1;						
					endcase				
										
               address <= ftdi_din[5:0];
               ftdi_rd_n <= 1;
               ftdi_wr_n <= 1;
					fifo_rd_en_reg <= 0;
               if (ftdi_din[7] == 1) begin
                  if (ftdi_din[6] == 1) begin
                     //MSB means WRITE
                     ftdi_isOutput <= 0;
                     state <= `DATAWR1;               
                  end else begin
                     //MSB means READ
                     ftdi_isOutput <= 1;
                     state <= `DATARDSTART;               
                  end
               end else begin
                  ftdi_isOutput <= 0;
                  state <= `IDLE;                  
               end
             end
               
            `DATAWR1: begin
               ftdi_isOutput <= 0;
               ftdi_wr_n <= 1;
					fifo_rd_en_reg <= 0;
					write_bytes <= write_bytes - 1;
               if (ftdi_rxf_n == 0) begin
                  ftdi_rd_n <= 0;
                  state <= `DATAWR2;
               end else begin
                  ftdi_rd_n <= 1;
                  state <= `DATAWR1;
               end
             end
               
            `DATAWR2: begin
               ftdi_isOutput <= 0;
               ftdi_wr_n <= 1;
               ftdi_rd_n <= 1;
					fifo_rd_en_reg <= 0;
               			
					if (address == `GAIN_ADDR) begin
                  registers_gain <= ftdi_din;
               end else if (address == `SETTINGS_ADDR) begin
                  registers_settings <= ftdi_din;
               end else if (address == `ECHO_ADDR) begin
                  registers_echo <= ftdi_din;
					end else if (address == `SAMPLES_ADDR1) begin
						registers_samples[7:0] <= ftdi_din;
					end else if (address == `SAMPLES_ADDR2) begin
						registers_samples[15:8] <= ftdi_din;
					end else if (address == `SAMPLES_ADDR3) begin
						registers_samples[23:16] <= ftdi_din;
					end else if (address == `SAMPLES_ADDR4) begin
						registers_samples[31:24] <= ftdi_din;
					end else if (address == `DDRADDR_ADDR1) begin
						registers_ddr_address[7:0] <= ftdi_din;
					end else if (address == `DDRADDR_ADDR2) begin
						registers_ddr_address[15:8] <= ftdi_din;
					end else if (address == `DDRADDR_ADDR3) begin
						registers_ddr_address[23:16] <= ftdi_din;
					end else if (address == `DDRADDR_ADDR4) begin
						registers_ddr_address[31:24] <= ftdi_din;
					end else if (address == `OFFSET_ADDR1) begin
						registers_offset[7:0] <= ftdi_din;
					end else if (address == `OFFSET_ADDR2) begin
						registers_offset[15:8] <= ftdi_din;
					end else if (address == `OFFSET_ADDR3) begin
						registers_offset[23:16] <= ftdi_din;
					end else if (address == `OFFSET_ADDR4) begin
						registers_offset[31:24] <= ftdi_din;
`ifdef USE_SCARD 
					end else if (address == `SCARDCTRL_ADDR) begin
						registers_scardctrl <= ftdi_din;
					end else if (address == `SCARDWR_ADDR) begin
						registers_scardout <= ftdi_din;
					end else if (address == `SCARDHDR_ADDR) begin
						registers_scardout <= ftdi_din;
`endif
					end else if (address == `MULTIECHO_ADDR) begin
						registers_multiecho <= ftdi_din;
					end
					
					if (write_bytes == 0) begin
						state <= `IDLE;         
					end else begin
						state <= `DATAWR1;
					end
             end

            
            `DATARDSTART: begin
               ftdi_isOutput <= 1;               
               ftdi_rd_n <= 1;
					fifo_rd_en_reg <= 0;
            					
					if (address == `GAIN_ADDR) begin
                  ftdi_dout <= registers_gain;
						ftdi_wr_n <= 0;
						state <= `IDLE;
						extclk_locked <= 0;
               end else if (address == `SETTINGS_ADDR) begin
                  ftdi_dout <= registers_settings;
						ftdi_wr_n <= 0;
						state <= `IDLE;
						extclk_locked <= 0;
               end else if (address == `ECHO_ADDR) begin
                  ftdi_dout <= registers_echo;
						ftdi_wr_n <= 0;
						state <= `IDLE;
						extclk_locked <= 0;
					end else if (address == `ADCDATA_ADDR) begin						
						ftdi_dout <= 8'hAC; //Sync Byte
						ftdi_wr_n <= 1;					
`ifdef USE_DDR
						state <= `DATARD_DDRSTART;
`else						
						state <= `DATARD1;
`endif
						extclk_locked <= 0;
					end else if (address == `STATUS_ADDR) begin
						ftdi_dout <= status;
						ftdi_wr_n <= 0;
						state <= `IDLE;
						extclk_locked <= 0;
					end else if (address == `EXTFREQ_ADDR1) begin
						ftdi_dout <= registers_extclk_frequency[7:0];
						extclk_locked <= 1;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `EXTFREQ_ADDR2) begin
						ftdi_dout <= registers_extclk_frequency[15:8];
						extclk_locked <= 1;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `EXTFREQ_ADDR3) begin
						ftdi_dout <= registers_extclk_frequency[23:16];
						extclk_locked <= 1;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `EXTFREQ_ADDR4) begin
						ftdi_dout <= registers_extclk_frequency[31:24];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `PHASE_ADDR1) begin
						ftdi_dout <= phase_in[7:0];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `PHASE_ADDR2) begin
						ftdi_dout[0] <= phase_in[8];
						ftdi_dout[1] <= phase_done;
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;	
					end else if (address == `SAMPLES_ADDR1) begin
						ftdi_dout <= registers_samples[7:0];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `SAMPLES_ADDR2) begin
						ftdi_dout <= registers_samples[15:8];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `SAMPLES_ADDR3) begin
						ftdi_dout <= registers_samples[23:16];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `SAMPLES_ADDR4) begin
						ftdi_dout <= registers_samples[31:24];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;							
					end else if (address == `DDRADDR_ADDR1) begin
						ftdi_dout <= registers_ddr_address[7:0];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `DDRADDR_ADDR2) begin
						ftdi_dout <= registers_ddr_address[15:8];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `DDRADDR_ADDR3) begin
						ftdi_dout <= registers_ddr_address[23:16];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `DDRADDR_ADDR4) begin
						ftdi_dout <= registers_ddr_address[31:24];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;	
					end else if (address == `OFFSET_ADDR1) begin
						ftdi_dout <= registers_offset[7:0];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `OFFSET_ADDR2) begin
						ftdi_dout <= registers_offset[15:8];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `OFFSET_ADDR3) begin
						ftdi_dout <= registers_offset[23:16];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;
					end else if (address == `OFFSET_ADDR4) begin
						ftdi_dout <= registers_offset[31:24];
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;							
`ifdef USE_SCARD
					end else if (address == `SCARDCTRL_ADDR) begin
						ftdi_dout <= registers_scardctrl_read;
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;	
						
					end else if (address == `SCARDWR_ADDR) begin
						ftdi_dout <= registers_scardout;
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;	
						
					end else if (address == `SCARDRD_ADDR) begin
						ftdi_dout <= scard_datai;
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						state <= `IDLE;	
`endif
					end else if (address == `MULTIECHO_ADDR) begin
						ftdi_dout <= multiecho_data;
						extclk_locked <= 0;
						ftdi_wr_n <= 0;
						if (multiecho_empty == 1'b1) begin
							state <= `IDLE;
						end else begin
							state <= `DATARDSTART;
						end
               end else begin
						extclk_locked <= 0;
						ftdi_dout <= 8'bx;						
						ftdi_wr_n <= 1;
						state <= `IDLE;
					end
            end
            
            `DATARD1: begin
               ftdi_isOutput <= 1;
               ftdi_rd_n <= 1;    										
									
					if (ftdi_txe_n == 0) begin
						ftdi_wr_n <= 0;
						if (fifo_empty == 0) begin 
							fifo_rd_en_reg <= 1;
							state <= `DATARD2;
						end else begin
							fifo_rd_en_reg <= 0;
`ifdef USE_DDR
							registers_ddr_address <= registers_ddr_address + 32'h100;
`endif
							state <= `IDLE;
						end
					end else begin
						ftdi_wr_n <= 1;
						fifo_rd_en_reg <= 0;
						state <= `DATARD1;
					end
            end
				
				`DATARD_DDRSTART: begin
					ftdi_isOutput <= 0;
					ftdi_wr_n <= 1;
					ftdi_rd_n <= 1;
					fifo_rd_en_reg <= 0;
					
					if (ddr_rd_done_reg) begin
						state <= `DATARD1;						
					end else begin
						state <= `DATARD_DDRSTART;
					end
					
				end
            
            `DATARD2: begin
               ftdi_isOutput <= 1;
               ftdi_wr_n <= 1;
               ftdi_rd_n <= 1;               
					fifo_rd_en_reg <= 0;
					ftdi_dout <= fifo_data;
               state <= `DATARD1;
               end    
						
				default: begin				
					fifo_rd_en_reg <= 0;
					ftdi_rd_n <= 1;
               ftdi_wr_n <= 1;
               ftdi_isOutput <= 0;
               state <= `IDLE;
				end
             
         endcase
      end                  
    end 
	 
`ifdef USE_DDR
	 always @(posedge reset or posedge ftdi_clk or posedge ddr_rd_done) 
		begin
		if (reset) begin
			ddr_rd_done_reg <= 0;
			ddr_rd_reg <= 0;
		end else if (ddr_rd_done) begin
			ddr_rd_done_reg <= 1;
			ddr_rd_reg <= 0;
		end else begin
			if (state == `IDLE) begin
				ddr_rd_done_reg <= 0;
				ddr_rd_reg <= 0;
			end else if ((state == `DATARD_DDRSTART) && (ddr_rd_done_reg == 0)) begin
				ddr_rd_reg <= 1;
			end
		end
	 end    
`endif


	reg multiecho_wr;
	reg multiecho_rd;
   always @(posedge ftdi_clk) begin
	if ((state == `DATARDSTART) & (address == `MULTIECHO_ADDR) & (multiecho_empty == 1'b0)) begin
			multiecho_rd <= 1'b1;
	  end else begin
			multiecho_rd <= 1'b0;
	  end
	 end
	 
	 always @(posedge ftdi_clk) begin
	  if ((state == `DATAWR2) & (address == `MULTIECHO_ADDR)) begin
			multiecho_wr <= 1'b1;			
	  end else begin
			multiecho_wr <= 1'b0;
	  end
	 end	

	fifo_usb_echo fifo_usb_echo_inst (
	  .clk(ftdi_clk), // input clk
	  .rst(reset), // input rst
	  .din(registers_multiecho), // input [7 : 0] din
	  .wr_en(multiecho_wr), // input wr_en
	  .rd_en(multiecho_rd), // input rd_en
	  .dout(multiecho_data), // output [7 : 0] dout
	  //.full(full), // output full
	  .empty(multiecho_empty) // output empty
	);

`ifdef USE_ETH
	
	reg [31:0] eth_samplecount;
	reg [15:0] eth_udpsize;
	assign eth_datalen = eth_udpsize;
	
	reg eth_start_reg;
	assign eth_start = eth_start_reg;
	
	`define ETH_MAXSAMPLES 32'd1400

	reg [4:0] eth_state;
	`define ETH_IDLE 	4'b0000
	`define ETH_START	4'b0001
	`define ETH_SIZE  4'b0010
	`define ETH_SEND  4'b0011

	always @(posedge eth_clk or posedge reset) begin
		if (reset) begin
			eth_state <= `ETH_IDLE;
		end else begin
			case(eth_state)
				`ETH_IDLE: begin
					eth_samplecount <= registers_samples;
					eth_start_reg <= 1'b0;
					if ((state == `DATARD1) || (state == `DATARD2)) begin
						eth_state <= `ETH_SIZE;
					end
				end
				
				`ETH_SIZE: begin
					eth_start_reg <= 1'b0;
					if (eth_samplecount > `ETH_MAXSAMPLES) begin
						eth_samplecount <= eth_samplecount - `ETH_MAXSAMPLES;
						eth_udpsize <= `ETH_MAXSAMPLES;
						eth_state <= `ETH_START;
					end else if (eth_samplecount > 32'd0) begin
						eth_udpsize <= eth_samplecount;
						eth_samplecount <= 32'd0;		
						eth_state <= `ETH_START;						
					end else begin
						eth_state <= `ETH_IDLE;
					end
				end
				
				`ETH_START: begin
					if (eth_done) begin
						eth_state <= `ETH_IDLE;
						eth_start_reg <= 1'b0;
					end else begin
						eth_start_reg <= 1'b1;
					end
				end

			endcase
		end
	end
`endif

    always @(posedge ftdi_clk or posedge reset)
    begin
      if (reset == 1) begin
         
      end else begin
         case (state)               
            `DATAWR2: begin
               if (address == `PHASE_ADDR1) begin
						phase_out[7:0] <= ftdi_din;
					end else if (address == `PHASE_ADDR2) begin
						phase_out[8] <= ftdi_din[0];	
						phase_loadout <= ftdi_din[1];
					end                     
             end
						
				default: begin
					phase_loadout <= 0;
				end             
         endcase
      end                  
    end 

	  
`ifdef CHIPSCOPE
   assign cs_data[3:0] = state;
   assign cs_data[11:4] = address;
   assign cs_data[12] = ftdi_rxf_n;
   assign cs_data[23:16] = registers_echo[7:0]; 
	assign cs_data[24] = ftdi_wr_n;
	assign cs_data[32:25] = ftdi_dout;
	assign cs_data[34] = fifo_empty;
	assign cs_data[35] = fifo_rd_en;
	assign cs_data[43:36] = fifo_data;
 `endif
 
endmodule
