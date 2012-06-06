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
    );

	wire        slowclock;
	wire        fastclock;
	
	assign slowclock = clk_40mhz;
	
	/*
	clkgen dcm100mhz
   (// Clock in ports
    .CLK_IN1(clk_100mhz),      // IN
    // Clock out ports
    .CLK_OUT1(fastclock));    // OUT
	*/
	
	//These need pull-ups enabled to avoid screwing up parts on board
	assign scl = 1'bz;
	assign sda = 1'bz;
  
   wire        reset;
                      
   assign GPIO_LED1 = ~reset_i;   
  
   //Global reset
   assign reset = reset_i;

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
   assign GPIO_LED4 = fifo_full;
 
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
 
   wire ADC_clk_int; 
    
	wire chipscope_clk;
	
  adc_internaldelaygen instance_name
   (// Clock in ports
    .CLK_IN1(clk_100mhz),      // IN
    // Clock out ports
    .ADC_CLK(ADC_clk_src),     // OUT
    .SAMPLE_CLK(ADC_clk_int),
	 .RESET(reset));    // OUT

	reg [9:0] ADC_Data_tofifo;
	
	always @(posedge ADC_clk_int) begin
		ADC_Data_tofifo <= ADC_Data;
		
		//Input Validation Test: uncomment following, which should
		//put a perfect ramp. Tests FIFO & USB interface for proper
		//syncronization
		//ADC_Data_tofifo <= ADC_Data_tofifo + 10'd1;
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

  
	//Input to FIFO based on output register format
	wire [15:0] fifo_in;	
	assign fifo_in[15] = 1;
	assign fifo_in[14] = 0;
	assign fifo_in[13] = 0;
	assign fifo_in[12] = 0; //PLL LOCK STATUS
	assign fifo_in[11] = ADC_OR;
	assign fifo_in[10:8] = ADC_Data_tofifo[9:7];
	assign fifo_in[7] = 0;
	assign fifo_in[6:0] = ADC_Data_tofifo[6:0];

	wire fifo_full;
	wire fifo_empty;
	reg fifo_wr_en;
	wire fifo_rd_en;
	wire [7:0] fifo_dout;
	wire [7:0] reg_status;
	reg armed;

  `ifdef CHIPSCOPE
  wire [35:0]                          chipscope_control;
  coregen_icon icon (
    .CONTROL0(chipscope_control) // INOUT BUS [35:0]
   );  
   
   wire [15:0] cs_data;
	 
   coregen_ila ila (
    .CONTROL(chipscope_control), // INOUT BUS [35:0]
    .CLK(fifo_rd_clk), // IN
    .TRIG0(cs_data) // IN BUS [255:0]
   );   

	assign cs_data[9:0] = fifo_dout;
	assign cs_data[10] = fifo_rd_en;
	assign cs_data[11] = fifo_empty;   
  `endif


	//Generate ADC FIFO
	adc_fifo adcfifo (
	  .wr_clk(ADC_clk_int), // input wr_clk
	  .rst(reset), // input rst
	  .rd_clk(fifo_rd_clk), // input rd_clk
	  .din(fifo_in), // input [15 : 0] din
	  .wr_en(fifo_wr_en), // input wr_en
	  .rd_en(fifo_rd_en), // input rd_en
	  .dout(fifo_dout), // output [7 : 0] dout
	  .full(fifo_full), // output full
	  .empty(fifo_empty) // output empty
	);  
	
	wire trigger;	
	assign trigger = DUT_trigger_i;
	
	//1 = trigger on high, 0 = trigger on low
	wire trigger_mode;
	
	//1 = wait for trigger to be INACTIVE before arming (e.g.: avoid triggering immediatly)
	//0 = arm as soon as cmd_arm goes high (e.g.: if trigger is already in active state, trigger)
	wire trigger_wait;
	
	//ADC Trigger Stuff	
	reg reset_arm;
	always @(posedge ADC_clk_int or posedge reset) begin
		if (reset) begin
			fifo_wr_en <= 0;
			reset_arm <= 0;
		end else begin
			if (fifo_full) begin
				fifo_wr_en <= 0;
				reset_arm <= 0;
			end else if ((trigger == trigger_mode) & armed) begin
				fifo_wr_en <= 1;
				reset_arm <= 1;
			end
		end
	end	
	
	wire resetarm;
	wire cmd_arm;
	assign resetarm = reset | reset_arm;
	always @(posedge slowclock or posedge resetarm)
	  if (resetarm) begin
			armed <= 0;
		end else if (cmd_arm & ((trigger != trigger_mode) | (trigger_wait == 0))) begin
			armed <= 1;
		end
        
	assign reg_status[0] = armed;
   assign reg_status[1] = fifo_full;
	assign reg_status[2] = trigger;

	wire [7:0] PWM_incr;

`undef CHIPSCOPE
   usb_interface usb(.reset(reset),
                     .clk(slowclock),
							.rx_in(rxd),
                     .tx_out(txd),
							.gain(PWM_incr),
                     .hilow(amp_hilo),
							.status(reg_status),
							.fifo_empty(fifo_empty),
							.fifo_data(fifo_dout),
							.fifo_rd_en(fifo_rd_en),
							.fifo_rd_clk(fifo_rd_clk),                     
							.cmd_arm(cmd_arm),
							.trigger_mode(trigger_mode),
							.trigger_wait(trigger_wait),                     
							.extclk_frequency(extclk_frequency)
							
							
`ifdef CHIPSCOPE                     
                     , .chipscope_control(chipscope_control)
`endif
                     );  
                    
	
	//0 - 78 covers entire gain range
	//assign PWM_incr = 50;
	
	reg [8:0] PWM_accumulator;
	always @(posedge slowclock) PWM_accumulator <= PWM_accumulator[7:0] + PWM_incr;
	
	//assign amp_hilo = 1'b0;
	assign amp_gain = PWM_accumulator[8];

endmodule
