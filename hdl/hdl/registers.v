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
	 */
	 
    `define GAIN_ADDR    	0
	 
    `define SETTINGS_ADDR  1
	 
	 `define STATUS_ADDR    2
	 
	 `define ADCREAD_ADDR   3
	 
    `define ECHO_ADDR      4
	 
	 `define EXTFREQ_ADDR   5	 
	 `define EXTFREQ_LEN    4
	 
	 `define PHASE_ADDR     9 	 
	 `define PHASE_LEN      2
	 
	 `define SAMPLES_ADDR   16
	 `define SAMPLES_LEN    4
	 
	 `define OFFSET_ADDR    26
	 `define OFFSET_LEN		8
	 
	  
	 