/*-------------------------------------------------------------------------
 SASEBO-W VCP smartcard controller with FIFO smartcard writer
 
 Copyright (C) 2012 MORITA TECH CO.,LTD. 
 -------------------------------------------------------------------------*/ 

/*-------------------------------------------------------------------------
 SASEBO-W VCP smartcard controller

 File name   : chip_sasebo_w_vcp.v
 Version     : 1.2
 Created     : Jun13,2011
 Last update : Jun27,2011
 Desgined by : Toshihiro Katashita
 
 
 Copyright (C) 2011 AIST
 
 By using this code, you agree to the following terms and conditions.
 
 This code is copyrighted by AIST ("us").
 
 Permission is hereby granted to copy, reproduce, redistribute or
 otherwise use this code as long as: there is no monetary profit gained
 specifically from the use or reproduction of this code, it is not sold,
 rented, traded or otherwise marketed, and this copyright notice is
 included prominently in any copy made.
 
 We shall not be liable for any damages, including without limitation
 direct, indirect, incidental, special or consequential damages arising
 from the use of this code.
 
 When you publish any results arising from the use of this code, we will
 appreciate it if you can cite our webpage
 (http://staff.aist.go.jp/akashi.satoh/SASEBO/en/index.html).
 -------------------------------------------------------------------------*/ 


//================================================ CHIP_SASEBO_W_VCP
module CHIP_SASEBO_W_VCP 
  (// USB FT2232H
   usb_txd, usb_rxd, usb_ctsn, usb_rtsn, usb_dtrn, usb_nrst,
	
	ADC_Data, ADC_OR, ADC_clk, ADC_clk_feedback, DUT_CLK_i, DUT_trigger_i, amp_gain, amp_hilo,
	adc_txd, adc_rxd,

   // Smart card
   card_io, card_inserted, card_oe, card_power_en,
   card_clk, card_rst, card_aux1, card_aux2,

   // LED, header pin, push switch, dip switch, clock, and reset
   gpio_trig0, gpio_trig1,
   led, pushsw, dipsw, clkin, rstnin);

   //------------------------------------------------
   // OpenADC Connections
	input [9:0]   ADC_Data;
	input         ADC_OR;
	output        ADC_clk;
	input			  ADC_clk_feedback;
	input         DUT_CLK_i;
	input         DUT_trigger_i;
	output        amp_gain;
	output        amp_hilo;
	input         adc_txd; //FTDI TXD
	output        adc_rxd; //FTDI RXD
	
	
	// USB FT2232H
   input        usb_txd;  // TxD
   output       usb_rxd;  // RxD
   input        usb_rtsn; // RTSn
   output       usb_ctsn; // CTSn
   input        usb_dtrn; // DTRn
	output		 usb_nrst; // RESET pin
   
   // Smart card
   inout        card_io;
   input        card_inserted;
   output       card_oe;
   output       card_power_en;
   output       card_clk, card_rst;
   inout        card_aux1, card_aux2;
   
   // LED, header pin, push switch, dip switch, clock, and reset
   output       gpio_trig0, gpio_trig1;
   output [7:0] led;
   input        pushsw;
   input [3:0]  dipsw;
   input        clkin, rstnin;
   
   //------------------------------------------------
   wire         clk, rst, clk4x, clk100mhz;

   // FT2232H
   reg          txd, usb_rxd, usb_ctsn_reg;
   reg [5:0]    mask;

   // Smartard IF
   reg          card_oe, card_power_en;
   wire         rst_async;
   reg          rst_sync;

   // 
   wire         enable_mask; // SW3:bit1 ON:ECHO disable   OFF:ECHO enable
   wire         enable_ctrl; // SW3:bit2 ON:RTS/CTS enable OFF:RTS/CTS disable
   wire         card_writer_mode; // SW3:bit3 ON:Writer OFF:Normal Operation
   
	//------------------------------------------------OpenADC
	
	wire [3:0] gpio_led;
	wire clkin_bufg;
	
	assign led[7] = ~gpio_led[0];
	assign led[6] = ~gpio_led[1];
	assign led[5] = ~gpio_led[2];
	assign led[4] = ~gpio_led[3];
	
	
	 interface openadc_inst(
    .reset_i(rst),   
	 .rxd(adc_txd),
    .txd(adc_rxd),
	 .clk_100mhz(clk100mhz),
	 .clk_24mhz(clkin_bufg),
	 .GPIO_LED1(gpio_led[0]),
	 .GPIO_LED2(gpio_led[1]),
	 .GPIO_LED3(gpio_led[2]),
	 .GPIO_LED4(gpio_led[3]),
	 .ADC_Data(ADC_Data),
	 .ADC_OR(ADC_OR),
	 .ADC_clk(ADC_clk),
	 .ADC_clk_feedback(ADC_clk_feedback),
	 .DUT_CLK_i(clk4x),
	 .DUT_trigger_i(card_aux1),
	 .amp_gain(amp_gain),
	 .amp_hilo(amp_hilo)
    );
	
   //------------------------------------------------
   // FT2232H IF
   always @(posedge clk) txd      <= usb_txd;
   always @(posedge clk) usb_rxd  <= (card_writer_mode | mask[0])? 1'b1 : card_io;
   always @(posedge clk) usb_ctsn_reg  <= ~card_inserted;
   assign usb_ctsn = (card_writer_mode)? card_io: usb_ctsn_reg;

   // Masking rxd ECHO
   always @(posedge clk or posedge rst)
     if (rst)                     mask <= 6'b000000;
     else if (~txd & enable_mask) mask <= 6'b111111;
     else                         mask <= {1'b0, mask[5:1]};

   //------------------------------------------------
   // Smartcard IF
   assign card_io = (card_writer_mode)? 1'bz: (txd==1'b0)? 1'b0 : 1'bz;
   
   always @(posedge clk) card_oe       <= card_inserted;
   always @(posedge clk) card_power_en <= card_inserted;
   always @(posedge clk) rst_sync      <= rst_async;
   assign rst_async = rst | ~pushsw | (~usb_rtsn & enable_ctrl);
   assign card_rst = (card_writer_mode)? usb_rtsn: rst_sync;

	//Reset USB only on switch push
	assign usb_nrst = pushsw;

   //------------------------------------------------
   // DIP switch
   assign enable_mask = ~dipsw[0];
   assign enable_ctrl = ~dipsw[1];
   assign card_writer_mode = ~dipsw[3];

   // LED
   //assign led[7] = ~rst_async;
   //assign led[6] = ~(~rstnin);
   //assign led[5] = ~(~usb_rtsn);
   //assign led[4] = ~(~pushsw);
   assign led[3] = ~card_inserted;
   assign led[2] = ~(~card_io);
   assign led[1] = ~(~usb_rxd);
   assign led[0] = ~(~usb_txd);

   // GPIO
   assign gpio_trig0 = card_aux1;
   assign gpio_trig1 = card_aux2;
   //assign gpio_txd   = txd;
   //assign gpio_rxd   = usb_rxd;

   // Serial   Dir  Contact  Pin
   // RTS      ->   RST      (/RESET)
   // DTR      ->   AUX2     (SCK)
   // TXD      ->   AUX1     (MOSI)
   // CTS      <-   I/O      (MISO)
   // FPGA CLK ->   CLK      (XTAL1)
   assign card_aux1 = (card_writer_mode)? ((usb_txd == 1'b0)? 1'b0: 1'bz): 1'bz;
   assign card_aux2 = (card_writer_mode)? ((usb_dtrn == 1'b0)? 1'b0: 1'bz): 1'bz;
   
   // CLOCK
   MK_CLKRST mk_clkrst // 24 MHz (clkin) -> 3.571 MHz (clk)
     (.clkin(clkin), .clkinbufg(clkin_bufg), .rstnin(rstnin), .clk(clk), .clk4x(clk4x), .clk100mhz(clk100mhz), .rst(rst));
	  
	ODDR2 u0 (.D0(1'b1), .D1(1'b0), .C0(clk), .C1(~clk), .CE(1'b1), .R(1'b0), .S(1'b0), .Q(card_clk));
endmodule // CHIP_SASEBO_W_VCP



//================================================ MK_CLKRST
module MK_CLKRST (clkin, clkinbufg, rstnin, clk, clk4x, clk100mhz, rst); 
   
   //------------------------------------
   input  clkin, rstnin;
   output clk, clk4x, clk100mhz, rst, clkinbufg;
   
   //------------------------------------
   wire   clkin_bufg, clkfb_pll, clkfb_bufg;
   wire   clkout0,        clkout1, clkout2,
          clkout3_unused, clkout4_unused, clkout5_unused;
   wire   locked;
   
   //------------------------------------
   IBUFG u0 (.I(clkin), .O(clkin_bufg));
   
   // input  clock: 24 MHz
   // output clock: 3.571 MHz (24 * 25 / 168)
   PLL_BASE #(.BANDWIDTH          ("OPTIMIZED"),
              .CLK_FEEDBACK       ("CLKFBOUT"),
              .COMPENSATION       ("SYSTEM_SYNCHRONOUS"),
              .DIVCLK_DIVIDE      (1),
              .CLKFBOUT_MULT      (25),
              .CLKFBOUT_PHASE     (0.000),
              .CLKOUT0_DIVIDE     (84),
              .CLKOUT0_PHASE      (0.000),
              .CLKOUT0_DUTY_CYCLE (0.500),
				  
				  //4x sample clock
              .CLKOUT1_DIVIDE     (42),
              .CLKOUT1_PHASE      (0.000),
              .CLKOUT1_DUTY_CYCLE (0.500),
				  
				  //100 MHz sample clock
              .CLKOUT2_DIVIDE     (6),
              .CLKOUT2_PHASE      (0.000),
              .CLKOUT2_DUTY_CYCLE (0.500),
				  
              .CLKIN_PERIOD       (41.666),
              .REF_JITTER         (0.010))
   pll_base
     (.CLKIN(clkin_bufg), .RST(~rstnin), 
      .CLKFBIN(clkfb_bufg), .LOCKED(locked),
      .CLKFBOUT(clkfb_pll),
      //
      .CLKOUT0 (clkout0),        .CLKOUT1 (clkout1),
      .CLKOUT2 (clkout2), .CLKOUT3 (clkout3_unused),
      .CLKOUT4 (clkout4_unused), .CLKOUT5 (clkout5_unused));
   
	reg clkhalf;
	always @(posedge clkout0) begin
		clkhalf <= ~clkhalf;
	end
	
   BUFG u1 (.I(clkfb_pll), .O(clkfb_bufg));
   BUFG u2 (.I(clkhalf),   .O(clk));
	
	BUFG u3 (.I(clkout1),   .O(clk4x));
	BUFG u4 (.I(clkout2),   .O(clk100mhz));
   
   //------------------------------------
   MK_RST mk_rst(.locked(locked), .clk(clk), .rst(rst));
   
	assign clkinbufg = clkin_bufg;
	
endmodule // MK_CLKRST



//================================================ MK_RST
module MK_RST (locked, clk, rst);
   //synthesis attribute keep_hierarchy of MK_RST is no;
   
   //------------------------------------------------
   input  locked, clk;
   output rst;

   //------------------------------------------------
   reg [7:0] cnt;
   
   //------------------------------------------------
   always @(posedge clk or negedge locked) 
     if (~locked)    cnt <= 8'h0;
     else if (~&cnt) cnt <= cnt + 8'h1;

   assign rst = ~&cnt;
endmodule // MK_RST
