	 /* Registers:	 
	 0x00 - Gain Settings (One Byte)
	 
	   [ G7 G6 G5 G4 G3 G2 G1 G0 ]
		
		  G = 8-bit PWM setting for gain voltage.
		      Voltage = G / 256 * VCCIO
	 
	 0x01 - Settings (One Byte)
	 
	   [  I  X  W  X  A  T  H  R ]
	     
		  R = (bit 0) System Reset, active high
		  H = (bit 1) Hilo output to amplifier
		  T = (bit 2) Trigger Polarity:
		      1 = Trigger when 'trig in' = 1
				0 = Trigger when 'trig in' = 0
		  A = (bit 3) Arm Trigger
		      1 = Arm trigger
				0 = No effect, but you must clear bit to 0
				    before next trigger cycle can be started
		  W = (bit 5) Before arming wait for trigger to go inactive (e.g: edge sensitive)
		      1 = Wait for trigger to go inactive before arming
				0 = Arm immediatly, which if trigger line is currently in active state
				    will also immediatly trigger
					 
		  F = (bit 6) Trigger Now
		      1 = Trigger Now
				0 = Normal
					 
		  I = (bit 7) Select trigger source: int/ext
		      1 = Internal (e.g.: based on ADC reading)
				0 = External (e.g.: based on trigger-in line)
		  
	 0x02 - Status (One Byte)
	 
	    [  X M  DC DE X  E  F  T ] 
		 T = (bit 0) Triggered status
		      1 = System armed
				0 = System disarmed		
		 F = (bit 1) Capture Status
		      1 = FIFO Full / Capture Done
				0 = FIFO Not Full / Capture Not Done
		 E = (bit 2) External trigger status
		      1 = Trigger line high
				0 = Trigger line low	
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
	 
	 0x06 - Advanced Clock Registers (4 bytes)
	    [  1 SP SG RA G0 C2 C1 C0 ] (Byte 0)
		 
		   1 = Always '1'
		 
		   SP = Status of DCM Block
			     1 = Locked/OK
				  0 = Not Locked
		 
		   SG = Status of CLKGEN Lock
			     1 = Locked/OK
				  0 = Not Locked
		 
			RA = Reset All DCM/PLL Blocks
			     1 = Reset Active
				  0 = No Reset
		 
		   G0 = Select INPUT to CLKGEN Block
			     0 = From system clock
				  1 = From EXTCLK input
		 
		   C2 = Select INPUT to DCM Block.
			     0 = From CLKGEN Block
				  1 = From EXTCLK Input
				  
			C1 = Select DCM Output
			     0 = 4x INPUT TO DCM clock
				  1 = 1x INPUT TO DCM clock				  
				  
		   C0 = Select source for ADC clock
			     0 = From DCM (e.g.: dependant on C1, C2, phase shift)
				  1 = Direct from external input
				  
			[                         ] (Byte 1)
			[                         ] (Byte 2)
			[                         ] (Byte 3)
			
	 0x07 - System Clock (4 Bytes) - Read Only
	    Clock frequency in Hz
		 
	 0x08 - ADC Output Clock (4 Bytes) - Read Only
	 
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
	 
	 0x1A - Offset of trigger to start of capture, ADC clock cycles (4 Bytes)
	   
		 [ LSB ] (Byte 0)
		 [     ] (Byte 1)
		 [     ] (Byte 2)
		 [ MSB ] (Byte 3)
	 */
	 
    `define GAIN_ADDR    	0
	 
    `define SETTINGS_ADDR  1
	 
	 `define STATUS_ADDR    2
	 
	 `define ADCREAD_ADDR   3
	 
    `define ECHO_ADDR      4
	 
	 `define EXTFREQ_ADDR   5	 
	 `define EXTFREQ_LEN    4
	 
	 `define ADVCLOCK_ADDR  6
	 `define ADVCLOCK_LEN   4
	 
	 `define SYSTEMCLK_ADDR 7
	 `define SYSTEMCLK_LEN	4
	 
	 `define ADCFREQ_ADDR   8	 
	 `define ADCFREQ_LEN    4
	 
	 `define PHASE_ADDR     9 	 
	 `define PHASE_LEN      2
	 
	 `define SAMPLES_ADDR   16
	 `define SAMPLES_LEN    4
	 
	 `define OFFSET_ADDR    26
	 `define OFFSET_LEN		4
	 
	  
	 