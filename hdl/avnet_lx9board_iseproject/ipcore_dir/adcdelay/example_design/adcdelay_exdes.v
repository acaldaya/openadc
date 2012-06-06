// file: adcdelay_exdes.v
// (c) Copyright 2009 - 2011 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

//----------------------------------------------------------------------------
// SelectIO wizard example design
//----------------------------------------------------------------------------
// This example design instantiates the IO circuitry
//----------------------------------------------------------------------------

`timescale 1ps/1ps

module adcdelay_exdes
   // Clock -> q modeling delay
 #(
   // width of the data for the system
   parameter sys_w = 10,
   // width of the data for the device
   parameter dev_w = 10)
  (
   output     [1:0]       PATTERN_COMPLETED_OUT,
   // From the system into the device
   input      [sys_w-1:0] DATA_IN_FROM_PINS,
   output [sys_w-1:0] DATA_OUT_TO_PINS,
   output  CLK_TO_PINS,
   output  CLK_TO_PINS_FWD,
  
   input                  CLK_IN,
   input                  CLK_IN_FWD,
   input                  CLK_RESET,
   input                  IO_RESET);


   localparam             num_serial_bits = dev_w/sys_w;
   wire        clkin1;
   reg  [sys_w-1:0]  count_out;
   reg  [sys_w-1:0]  count_out1;
   reg  [sys_w-1:0]  count_out2;
   reg [num_serial_bits-1:0] local_counter;

   wire [dev_w-1:0]       data_in_to_device;
   reg [dev_w-1:0]       data_in_to_device_int2;
   reg [dev_w-1:0]       data_in_to_device_int3;

   wire  [dev_w-1:0]       data_out_from_device;
     wire   [sys_w-1:0] data_out_to_pins_predelay;
   wire        clock_enable = 1'b1;
   wire   [sys_w-1:0] data_in_from_pins_int;
   wire   [sys_w-1:0] data_in_from_pins_delay;
   wire   [sys_w-1:0] tristate_predelay;

   wire                   clk_out;
   wire                   clkfbout;
   wire                   clk_in_pll;
   wire                   clk_in_pll1;
   wire                   clk_out_pll1;
   wire                   clkfbout_buf;
   wire                   locked_in;
   wire                   locked_out;
   wire                    clk_fwd_out;

   reg rst_sync;
   reg rst_sync_int;
   reg rst_sync_int1;
   reg rst_sync_int2;
   reg rst_sync_int3;
   reg rst_sync_int4;
   reg rst_sync_int5;
   reg rst_sync_int6;
   reg [1:0] pattern_completed = 2'b00;
   reg start_check;

  
  IBUFG clkin_in_buf
   (.O (clkin1),
    .I (CLK_IN)
     );



   // set up the fabric PLL_BASE to drive the BUFPLL
   PLL_BASE
   #(.BANDWIDTH             ("OPTIMIZED"),
     .CLK_FEEDBACK          ("CLKFBOUT"),
     .COMPENSATION          ("SYSTEM_SYNCHRONOUS"),
     .DIVCLK_DIVIDE         (1),
     .CLKFBOUT_MULT         (4),
     .CLKFBOUT_PHASE        (0.000),
     .CLKOUT0_DIVIDE        (4),
     .CLKOUT0_PHASE         (0.000),
     .CLKOUT0_DUTY_CYCLE    (0.500),
    .CLKIN_PERIOD          (10.0),
     .REF_JITTER            (0.010))
   pll_base_inst
     // Output clocks
    (.CLKFBOUT              (clkfbout),
     .CLKOUT0               (clk_in_pll1),
     .CLKOUT1               (),
     .CLKOUT2               (),
     .CLKOUT3               (),
     .CLKOUT4               (),
     .CLKOUT5               (),
     // Status and control signals
     .LOCKED                (locked_in),
     .RST                   (CLK_RESET),
      // Input clock control
     .CLKFBIN               (clkfbout_buf),
     .CLKIN                 (clkin1));

    BUFG clkfb_buf
    (.O (clkfbout_buf),
     .I (clkfbout));


    BUFG clko_buf
    (.O (clk_in_pll),
     .I (clk_in_pll1));



   always @(posedge clk_out or posedge IO_RESET) begin
   if (IO_RESET) begin
       rst_sync <= 1'b1;
       rst_sync_int <= 1'b1;
       rst_sync_int1 <= 1'b1;
       rst_sync_int2 <= 1'b1;
       rst_sync_int3 <= 1'b1;
       rst_sync_int4 <= 1'b1;
       rst_sync_int5 <= 1'b1;
       rst_sync_int6 <= 1'b1;
    end
   else begin
       rst_sync <= 1'b0;
       rst_sync_int <= rst_sync;
       rst_sync_int1 <= rst_sync_int;
       rst_sync_int2 <= rst_sync_int1;
       rst_sync_int3 <= rst_sync_int2;
       rst_sync_int4 <= rst_sync_int3;
       rst_sync_int5 <= rst_sync_int4;
       rst_sync_int6 <= rst_sync_int5;
   end
   end





   always @(posedge clk_out) begin
   if (rst_sync_int6) begin
     count_out <= 0;
     end
   else if (locked_in) begin
     count_out <= count_out + 1'b1;
     end
   end




   always @(posedge clk_out) begin
   if (rst_sync_int6) begin
     count_out1 <= 0;
     count_out2 <= 0;
   end
   else  begin
     count_out1 <= count_out;
     count_out2 <= count_out1;
   end
end

       assign data_out_from_device = count_out2;


   always @(posedge clk_out) begin
   if (rst_sync_int6) 
       pattern_completed <= 2'b00;

   else begin
 
     if (&data_in_to_device_int3) begin
       pattern_completed <= 2'b11;
     end
   end
  end

   always @(posedge clk_out) begin
   if (rst_sync_int6) begin
 
     data_in_to_device_int2 <= 0;
     data_in_to_device_int3 <= 0;
   end
   else begin
     data_in_to_device_int2 <= data_in_to_device;
     data_in_to_device_int3 <= data_in_to_device_int2;
   end
   end




  assign PATTERN_COMPLETED_OUT =  pattern_completed;



  assign clk_in_int_inv_c = ~clk_in_pll;
    ODDR2
     #(.DDR_ALIGNMENT  ("C0"),
       .INIT           (1'b0),
       .SRTYPE         ("ASYNC"))
     oddr2_inst
      (.D0             (1'b1),
       .D1             (1'b0),
       .C0             (clk_in_pll),
       .C1             (clk_in_int_inv_c),
       .CE             (locked_in),
       .Q              (clk_fwd_out),
       .R              (CLK_RESET),
       .S              (1'b0));

 // Clock Output Buffer
    OBUF
      #(.IOSTANDARD ("LVCMOS33"))
     obuf_inst
       (.O          (CLK_TO_PINS_FWD),
        .I          (clk_fwd_out));
 
   // Instantiate the IO design
   adcdelay io_inst
    (
     // From the system into the device
     .DATA_IN_FROM_PINS       (DATA_IN_FROM_PINS),
     .DATA_IN_TO_DEVICE       (data_in_to_device),
     // From the drive out to the system
     .DATA_OUT_FROM_DEVICE    (data_out_from_device),
     .DATA_OUT_TO_PINS        (DATA_OUT_TO_PINS),
     .CLK_TO_PINS         (CLK_TO_PINS),
     .CLK_IN                  (CLK_IN_FWD),
     .CLK_OUT                 (clk_out),
     .CLK_RESET               (CLK_RESET),
     .IO_RESET                (rst_sync_int));

endmodule
