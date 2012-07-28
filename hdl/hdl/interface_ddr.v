`include "includes.v"
//`define CHIPSCOPE 1
/***********************************************************************
This file is part of the OpenADC Project. See www.newae.com for more details,
or the codebase at http://www.assembla.com/spaces/openadc .

This file is the main interface.

Copyright (c) 2012, Colin O'Flynn <coflynn@newae.com>. All rights reserved.
This project is released under the Modified FreeBSD License. See LICENSE
file which should have came with this code.
*************************************************************************/

module interface(
    input         reset_i,
    
    input         clk_40mhz,
    input         clk_100mhz,
	 inout			sda,
	 inout			scl,
	 
    input         rxd,
    output        txd,
       
    output        GPIO_LED1,
    output        GPIO_LED2,
    output        GPIO_LED3,
    output        GPIO_LED4,
	 
	 input [9:0]   ADC_Data,
	 input         ADC_OR,
	 output        ADC_clk,
	 input         DUT_CLK_i,
	 input         DUT_trigger_i,
	 output        amp_gain,
	 output        amp_hilo
	 
`ifdef USE_DDR
	 ,output [12:0] LPDDR_A,
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
`endif
    );

	wire        slowclock;
	wire 			clk_100mhz_buf; 	
	
	assign slowclock = clk_40mhz;
	
	 wire       phase_clk;
	 wire       dcm_psen;
	 wire       dcm_psincdec;
	 wire       dcm_psdone;
	 wire [7:0] dcm_status;
	 wire [8:0] phase_requested;
	 wire [8:0] phase_actual;
	 wire 		phase_load;
	 wire 		phase_done;
	 wire       clkfx;
	 wire       locked;
	 wire       dcm_clk;
	
	wire 			adc_capture_go;
	wire			adc_capture_done;
	wire			armed;
	
	//These need pull-ups enabled to avoid screwing up parts on board
	assign scl = 1'bz;
	assign sda = 1'bz;
  
   wire        reset;
                      
   assign GPIO_LED1 = ~reset_i;   
  
   //Global reset
   //assign reset = reset_i;

   //Divide clock by 2^24 for heartbeat LED
	//Divide clock by 2^25 for frequency measurement
   reg [25:0] timer_heartbeat;
   always @(posedge slowclock)
      if (reset) begin
         timer_heartbeat <= 26'b0;
      end else begin
         timer_heartbeat <= timer_heartbeat +  26'd1;
      end	
      
   //Blink heartbeat LED
   assign GPIO_LED2 = timer_heartbeat[24];
	assign GPIO_LED3 = armed;
   assign GPIO_LED4 = adc_capture_go;
 
	//Frequency Measurement
	wire freq_measure;
	assign freq_measure = timer_heartbeat[25];
	reg [31:0] extclk_frequency_int;
	always @(posedge DUT_CLK_i or negedge freq_measure) begin
		if (freq_measure == 1'b0) begin
			extclk_frequency_int <= 32'd0;
		end else if (freq_measure == 1'b1) begin
			extclk_frequency_int <= extclk_frequency_int + 32'd1;
		end
	end
		
	reg [31:0] extclk_frequency;
	always @(negedge freq_measure) begin
		extclk_frequency <= extclk_frequency_int;
	end	
 
   wire ADC_clk_sample; 
    
	wire chipscope_clk;
	
	reg [9:0] ADC_Data_tofifo;
	wire [9:0] trigger_level;
	
	always @(posedge ADC_clk_sample) begin
		//ADC_Data_tofifo <= ADC_Data;
		
		//Input Validation Test #1: Uncomment the following
		//ADC_Data_tofifo <= 10'hAA;
		
		//Input Validation Test #2: uncomment following, which should
		//put a perfect ramp. Tests FIFO & USB interface for proper
		//syncronization
		ADC_Data_tofifo <= ADC_Data_tofifo + 10'd1;
	end
   	
	ODDR2 #(
		// The following parameters specify the behavior
		// of the component.
		.DDR_ALIGNMENT("NONE"), // Sets output alignment
										// to "NONE", "C0" or "C1"
		.INIT(1'b0),    // Sets initial state of the Q 
							 //   output to 1'b0 or 1'b1
		.SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC"
							 //   set/reset
	)
	ODDR2_inst (
		.Q(ADC_clk),   // 1-bit DDR output data
		.C0(ADC_clk_src), // 1-bit clock input
		.C1(~ADC_clk_src), // 1-bit clock input
		.CE(1'b1), // 1-bit clock enable input
		.D0(1'b1), // 1-bit data input (associated with C0)
		.D1(1'b0), // 1-bit data input (associated with C1)
		.R(1'b0),   // 1-bit reset input
		.S(1'b0)    // 1-bit set input
	);

	wire [7:0] 	reg_status;
	
`ifdef CHIPSCOPE
  wire [35:0]                          chipscope_control;
  coregen_icon icon (
    .CONTROL0(chipscope_control) // INOUT BUS [35:0]
   ); 
   wire [127:0] cs_data;
    
   coregen_ila ila (
    .CONTROL(chipscope_control), // INOUT BUS [35:0]
    .CLK(ADC_clk_sample), // IN
    .TRIG0(cs_data) // IN BUS [127:0]
   );
`endif
	
  
/*  
   wire [15:0] cs_data;
	 
   coregen_ila ila (
    .CONTROL(chipscope_control), // INOUT BUS [35:0]
    .CLK(chipscope_clk), // IN
    .TRIG0(cs_data) // IN BUS [255:0]
   );   

  `endif
	*/
	
	//1 = trigger on high, 0 = trigger on low
	wire trigger_mode;
	
	//1 = wait for trigger to be INACTIVE before arming (e.g.: avoid triggering immediatly)
	//0 = arm as soon as cmd_arm goes high (e.g.: if trigger is already in active state, trigger)
	wire trigger_wait;
	wire cmd_arm;
	       
	trigger_unit tu_inst(
	 .reset(reset),
	 .clk(slowclock),				

    .adc_clk(ADC_clk_sample),		
	 .adc_data(ADC_Data_tofifo),

    .ext_trigger_i(DUT_trigger_i),
	 .trigger_level_i(trigger_mode),	 
	 .trigger_wait_i(trigger_wait),	 
	 .trigger_adclevel_i(trigger_level),
	 .trigger_source_i(trigger_source),
	 .trigger_now_i(trigger_now),
	 .arm_i(cmd_arm),
	 .arm_o(armed),
	 .capture_go_o(adc_capture_go),
	 .capture_done_i(adc_capture_done));		 
			 
	assign reg_status[0] = armed;
   assign reg_status[1] = adcfifo_full;
	assign reg_status[2] = DUT_trigger_i;

	wire [7:0] PWM_incr;

	wire ADC_clk_extsrc;
	wire ADC_clk_intsrc;
	wire ADC_clk_selection; //0=internal, 1=external
	
	wire				ddr_read_req;
	wire				ddr_read_done;
	wire [31:0]		ddr_read_address;
	wire [7:0] 		ddrfifo_dout;
	wire				ddrfifo_empty;
	wire				ddrfifo_rd_en;
	wire				ddrfifo_rd_clk;	

`ifdef CHIPSCOPE
	assign cs_data[0] = armed;
	assign cs_data[1] = trigger_source;
	assign cs_data[2] = trigger_mode;
	assign cs_data[3] = DUT_trigger_i;
	assign cs_data[4] = trigger_wait;
	assign cs_data[5] = ddr_read_req;
	assign cs_data[6] = ddr_read_done;
	assign cs_data[7] = ddrfifo_empty;
	assign cs_data[8] = adc_capture_go;
	assign cs_data[9] = adc_capture_done;
	assign cs_data[10] = cmd_arm;
`endif
	 
	 
	wire cmdfifo_rxf;
	wire cmdfifo_txe;
	wire cmdfifo_rd;
	wire cmdfifo_wr;
	wire [7:0] cmdfifo_din;
	wire [7:0] cmdfifo_dout;
	 
	serial_reg_iface cmdfifo_serial(.reset_i(reset),
											  .clk_i(slowclock),
											  .rx_i(rxd),
											  .tx_o(txd),
											  .cmdfifo_rxf(cmdfifo_rxf),
											  .cmdfifo_txe(cmdfifo_txe),
											  .cmdfifo_rd(cmdfifo_rd),
											  .cmdfifo_wr(cmdfifo_wr),
											  .cmdfifo_din(cmdfifo_din),
											  .cmdfifo_dout(cmdfifo_dout));

`undef CHIPSCOPE
   usb_interface usb(.reset(reset),
                     .clk(slowclock),
							.cmdfifo_rxf(cmdfifo_rxf),
							.cmdfifo_txe(cmdfifo_txe),
							.cmdfifo_rd(cmdfifo_rd),
							.cmdfifo_wr(cmdfifo_wr),
							.cmdfifo_din(cmdfifo_din),
							.cmdfifo_dout(cmdfifo_dout),
							.gain(PWM_incr),
                     .hilow(amp_hilo),
							.status(reg_status),
							.fifo_empty(ddrfifo_empty),
							.fifo_data(ddrfifo_dout),
							.fifo_rd_en(ddrfifo_rd_en),
							.fifo_rd_clk(ddrfifo_rd_clk),                     
							.cmd_arm(cmd_arm),
							.trigger_mode(trigger_mode),
							.trigger_wait(trigger_wait),  
							.trigger_source(trigger_source),
							.trigger_level(trigger_level),
							.trigger_now(trigger_now),
							.extclk_frequency(extclk_frequency),							
							.phase_o(phase_requested),
							.phase_ld_o(phase_load),
							.phase_i(phase_actual),
							.phase_done_i(phase_done),
							.phase_clk_o(phase_clk),
							.adc_clk_src_o(ADC_clk_selection),
							.ddr_address(ddr_read_address),
							.ddr_rd_req(ddr_read_req),
							.ddr_rd_done(ddr_read_done)
							
`ifdef CHIPSCOPE                     
                     , .chipscope_control(chipscope_control)
`endif

                     );                      	 
	
	 dcm_phaseshift_interface dcmps(.clk_i(phase_clk),
											  .reset_i(reset),
											  .default_value_i(8'd0),
											  .value_i(phase_requested),
											  .load_i(phase_load),
											  .value_o(phase_actual),
											  .done_o(phase_done),
											  .dcm_psen_o(dcm_psen),
											  .dcm_psincdec_o(dcm_psincdec),
											  .dcm_psdone_i(dcm_psdone),
											  .dcm_status_i(dcm_status));	  
	
	
	assign ADC_clk_intsrc = clk_100mhz_buf;		 
			 
	// BUFGMUX: Global Clock Mux Buffer
	// Spartan-6
	// Xilinx HDL Libraries Guide, version 13.2
	BUFGMUX #(
	.CLK_SEL_TYPE("SYNC") // Glitchles ("SYNC") or fast ("ASYNC") clock switch-over
	)
	BUFGMUX_inst (
	.O(ADC_clk_src), // 1-bit output: Clock buffer output
	.I0(ADC_clk_intsrc), // 1-bit input: Clock buffer input (S=0)
	.I1(ADC_clk_extsrc), // 1-bit input: Clock buffer input (S=1)
	.S(ADC_clk_selection) // 1-bit input: Clock buffer select
	);
	// End of BUFGMUX_inst instantiation
			 
			 
	/*		
	IBUFG IBUFG_inst (
		.O(clk_100mhz_buf),
		.I(clk_100mhz) );
		*/
			 
	// DCM_SP: Digital Clock Manager
	// Spartan-6
	// Xilinx HDL Libraries Guide, version 13.2
	DCM_SP #(
	.CLKFX_DIVIDE(1), // Divide value on CLKFX outputs - D - (1-32)
	.CLKFX_MULTIPLY(4), // Multiply value on CLKFX outputs - M - (2-32)
	.CLKIN_DIVIDE_BY_2("FALSE"), // CLKIN divide by two (TRUE/FALSE)
	.CLKIN_PERIOD(10.0), // Input clock period specified in nS
	.CLKOUT_PHASE_SHIFT("VARIABLE"), // Output phase shift (NONE, FIXED, VARIABLE)
	.CLK_FEEDBACK("2X"), // Feedback source (NONE, 1X, 2X)
	.DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
	.PHASE_SHIFT(0), // Amount of fixed phase shift (-255 to 255)
	.STARTUP_WAIT("FALSE") // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
	)
	DCM_extclock_gen (
	.CLK2X(dcm_clk),
	.CLKFX(ADC_clk_extsrc), // 1-bit output: Digital Frequency Synthesizer output (DFS)
	.LOCKED(locked), // 1-bit output: DCM_SP Lock Output
	.PSDONE(dcm_psdone), // 1-bit output: Phase shift done output
	.STATUS(dcm_status), // 8-bit output: DCM_SP status output
	.CLKFB(dcm_clk), // 1-bit input: Clock feedback input
	.CLKIN(DUT_CLK_i), // 1-bit input: Clock input
	.PSCLK(phase_clk), // 1-bit input: Phase shift clock input
	.PSEN(dcm_psen), // 1-bit input: Phase shift enable
	.PSINCDEC(dcm_psincdec), // 1-bit input: Phase shift increment/decrement input
	.RST(reset) // 1-bit input: Active high reset input
	);
	
	// DCM_SP: Digital Clock Manager
	// Spartan-6
	// Xilinx HDL Libraries Guide, version 13.2
	DCM_SP #(
	.CLKIN_DIVIDE_BY_2("FALSE"), // CLKIN divide by two (TRUE/FALSE)
	.CLKIN_PERIOD(10.0), // Input clock period specified in nS
	.CLKOUT_PHASE_SHIFT("FIXED"), // Output phase shift (NONE, FIXED, VARIABLE)
	.CLK_FEEDBACK("1X"), // Feedback source (NONE, 1X, 2X)
	.DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
	.PHASE_SHIFT(50), // Amount of fixed phase shift (-255 to 255)
	.STARTUP_WAIT("FALSE") // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
	)
	DCM_ADC_Sample_delay (
	.CLK0(ADC_clk_sample), // 1-bit output: 0 degree clock output
	//.LOCKED(locked), // 1-bit output: DCM_SP Lock Output
	.CLKFB(ADC_clk_sample), // 1-bit input: Clock feedback input
	.CLKIN(ADC_clk_src), // 1-bit input: Clock input
	.RST(reset) // 1-bit input: Active high reset input
	);		 
	
	reg [8:0] PWM_accumulator;
	always @(posedge slowclock) PWM_accumulator <= PWM_accumulator[7:0] + PWM_incr;
	
	//assign amp_hilo = 1'b0;
	assign amp_gain = PWM_accumulator[8];
	
	//wire clk_ddrusr;
	
	ddr_top ddr(
    .reset_i(reset_i),
	 .reset_o(reset),
    .clk_100mhz_in(clk_100mhz),
	 .clk_100mhz_out(clk_100mhz_buf),
	 
	 //ADC Sample Input
	 .adc_datain(ADC_Data_tofifo),
	 .adc_sampleclk(ADC_clk_sample),
	 .adc_or(ADC_OR),
	 .adc_trig_status(DUT_trigger_i),
	 .adc_capture_go(adc_capture_go), //Set to '1' to start capture, keep at 1 until adc_capture_stop goes high
	 .adc_capture_stop(adc_capture_done),
	 
	 //DDR to USB Read Interface
	 .ddr_read_req(ddr_read_req),
	 .ddr_read_done(ddr_read_done),
	 .ddr_read_address(ddr_read_address[29:0]),
	 .ddr_read_fifoclk(ddrfifo_rd_clk),
	 .ddr_read_fifoen(ddrfifo_rd_en),
	 .ddr_read_fifoempty(ddrfifo_empty),
	 .ddr_read_data(ddrfifo_dout),
	 .ddr_cal_done(reg_status[5]),
	 .ddr_error(reg_status[4]),
	 
	 //DDR HW Interface
	 .LPDDR_A(LPDDR_A),
	 .LPDDR_BA(LPDDR_BA),
	 .LPDDR_DQ(LPDDR_DQ),
	 .LPDDR_LDM(LPDDR_LDM),
	 .LPDDR_UDM(LPDDR_UDM),
	 .LPDDR_LDQS(LPDDR_LDQS),
	 .LPDDR_UDQS(LPDDR_UDQS),
	 .LPDDR_CK_N(LPDDR_CK_N),
	 .LPDDR_CK_P(LPDDR_CK_P),
	 .LPDDR_CKE(LPDDR_CKE),
	 .LPDDR_CAS_n(LPDDR_CAS_n),
	 .LPDDR_RAS_n(LPDDR_RAS_n),
	 .LPDDR_WE_n(LPDDR_WE_n),
	 .LPDDR_RZQ(LPDDR_RZQ)	 
	 );
	
	
	assign adcfifo_full = ~adc_capture_go;
	
endmodule
