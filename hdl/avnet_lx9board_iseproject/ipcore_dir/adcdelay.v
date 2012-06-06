// file: adcdelay.v
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
// User entered comments
//----------------------------------------------------------------------------
// None
//----------------------------------------------------------------------------

`timescale 1ps/1ps

(* CORE_GENERATION_INFO = "adcdelay,selectio_wiz_v3_2,{component_name=adcdelay,bus_dir=SEPARATE,bus_sig_type=SINGLE,bus_io_std=LVCMOS33,use_serialization=false,use_phase_detector=false,serialization_factor=4,enable_bitslip=false,enable_train=false,system_data_width=10,bus_in_delay=FIXED,bus_out_delay=FIXED,clk_sig_type=SINGLE,clk_io_std=LVCMOS33,clk_buf=BUFG,active_edge=RISING,clk_delay=NONE,v6_bus_in_delay=NONE,v6_bus_out_delay=NONE,v6_clk_buf=BUFIO,v6_active_edge=NOT_APP,v6_ddr_alignment=SAME_EDGE_PIPELINED,v6_oddr_alignment=SAME_EDGE,ddr_alignment=C0,v6_interface_type=NETWORKING,interface_type=NETWORKING,v6_bus_in_tap=0,v6_bus_out_tap=0,v6_clk_io_std=LVCMOS18,v6_clk_sig_type=SINGLE}" *)

module adcdelay
   // width of the data for the system
 #(parameter sys_w = 10,
   // width of the data for the device
   parameter dev_w = 10)
 (
  // From the system into the device
  input  [sys_w-1:0] DATA_IN_FROM_PINS,
  output [dev_w-1:0] DATA_IN_TO_DEVICE,
  // From the device out to the system
  input  [dev_w-1:0] DATA_OUT_FROM_DEVICE,
  output [sys_w-1:0] DATA_OUT_TO_PINS,
  output  CLK_TO_PINS,
  input              CLK_IN,        // Single ended clock from IOB
  output             CLK_OUT,
  input              CLK_RESET,
  input              IO_RESET);
  // Signal declarations
  ////------------------------------
  wire               clock_enable = 1'b1;
  wire clk_fwd_out;
  // After the buffer
  wire   [sys_w-1:0] data_in_from_pins_int;
  // Between the delay and serdes
  wire [sys_w-1:0]  data_in_from_pins_delay;
  // Before the buffer
  wire   [sys_w-1:0] data_out_to_pins_int;
  // Between the delay and serdes
  wire   [sys_w-1:0] data_out_to_pins_predelay;
  // Create the clock logic
  IBUFG
    #(.IOSTANDARD ("LVCMOS33"))
   ibufg_clk_inst
     (.I          (CLK_IN),
      .O          (clk_in_int));

   BUFG clkin_buf_inst
    (.O (clk_in_int_buf),
     .I (clk_in_int));


   // Forward the buffered version of the input clock
   assign CLK_OUT = clk_in_int_buf;
  // We have multiple bits- step over every bit, instantiating the required elements
  genvar pin_count;
  generate for (pin_count = 0; pin_count < sys_w; pin_count = pin_count + 1) begin: pins
    // Instantiate the buffers
    ////------------------------------
    // Instantiate a buffer for every bit of the data bus
    OBUF
      #(.IOSTANDARD ("LVCMOS33"))
     obuf_inst
       (.O          (DATA_OUT_TO_PINS    [pin_count]),
        .I          (data_out_to_pins_int[pin_count]));
    IBUF
      #(.IOSTANDARD ("LVCMOS33"))
     ibuf_inst
       (.I          (DATA_IN_FROM_PINS    [pin_count]),
        .O          (data_in_from_pins_int[pin_count]));

    // Instantiate the delay primitive
    ////-------------------------------
 
    IODELAY2
     #(.DATA_RATE                  ("SDR"),
       .IDELAY_VALUE               (0),
       .IDELAY_TYPE                ("FIXED"),
       .COUNTER_WRAPAROUND         ("STAY_AT_LIMIT"),
       .DELAY_SRC                  ("IDATAIN"),
       .SERDES_MODE                ("NONE"),
       .SIM_TAPDELAY_VALUE         (75))
     indelay2_bus
      (
       // required datapath
       .IDATAIN                (data_in_from_pins_int  [pin_count]),
       .DATAOUT                (data_in_from_pins_delay[pin_count]),
       .T                      (1'b1),
       // inactive data connections
       .DATAOUT2               (),
       .DOUT                   (),
       .ODATAIN                (1'b0),
       .TOUT                   (),
       // connect up the clocks
       .IOCLK0                 (1'b0),                 // No calibration needed
       .IOCLK1                 (1'b0),                 // No calibration needed
       // Tie of the variable delay programming
       .CLK                    (1'b0),
       .CAL                    (1'b0),
       .INC                    (1'b0),
       .CE                     (1'b0),
       .BUSY                   (),
       .RST                    (1'b0));


    IODELAY2
     #(.DATA_RATE                  ("SDR"),
       .ODELAY_VALUE               (0),
       .COUNTER_WRAPAROUND         ("STAY_AT_LIMIT"),
       .DELAY_SRC                  ("ODATAIN"),
       .SERDES_MODE                ("NONE"),
       .SIM_TAPDELAY_VALUE         (75))
     outdelay2_bus
      (
       // required datapath
       .T                      (1'b0),
       .DOUT                   (data_out_to_pins_int     [pin_count]),
       .ODATAIN                (data_out_to_pins_predelay[pin_count]),
       // inactive data connections
       .IDATAIN                (1'b0),
       .TOUT                   (),
       .DATAOUT                (),
       .DATAOUT2               (),
       // connect up the clocks
       .IOCLK0                 (1'b0),                 // No calibration needed
       .IOCLK1                 (1'b0),                 // No calibration needed
       // Tie of the variable delay programming
       .CLK                    (1'b0),
       .CAL                    (1'b0),
       .INC                    (1'b0),
       .CE                     (1'b0),
       .BUSY                   (),
       .RST                    (1'b0));

    // Connect the delayed data to the fabric
    ////--------------------------------------

    // Pack the registers into the IOB

    wire data_in_to_device_int;
    (* IOB = "true" *)
    FDRE fdre_in_inst
      (.D              (data_in_from_pins_delay[pin_count]),
       .C              (clk_in_int_buf),
       .CE             (clock_enable),
       .R              (IO_RESET),
       .Q              (data_in_to_device_int)
      );
    assign DATA_IN_TO_DEVICE[pin_count] = data_in_to_device_int;
    wire data_out_from_device_q;
    (* IOB = "true" *)
    FDRE fdre_out_inst
      (.D              (DATA_OUT_FROM_DEVICE[pin_count]),
       .C              (clk_in_int_buf),
       .CE             (clock_enable),
       .R              (IO_RESET),
       .Q              (data_out_from_device_q)
      );
    assign data_out_to_pins_predelay[pin_count] = data_out_from_device_q;
  end
  endgenerate
   // clock forwarding logic

// The following BUFIO2 is needed to forward the incoming clock
    BUFIO2 #(
       .DIVIDE_BYPASS ("FALSE"),
       .I_INVERT      ("TRUE"),
       .USE_DOUBLER   ("FALSE"),
       .DIVIDE        (4))
    bufio2fwd_inst
      (.DIVCLK       (),
       .IOCLK        (clk_fwd_int),
       .SERDESSTROBE (),
       .I            (clk_in_int)
    );


    ODDR2
     #(.DDR_ALIGNMENT  ("C0"),
       .INIT           (1'b0),
       .SRTYPE         ("ASYNC"))
     oddr2_inst
      (.D0             (1'b1),
       .D1             (1'b0),
       .C0             (clk_in_int_buf),
       .C1             (clk_fwd_int),
       .CE             (clock_enable),
       .Q              (clk_fwd_out),
       .R              (CLK_RESET),
       .S              (1'b0));

// Clock Output Buffer
    OBUF
      #(.IOSTANDARD ("LVCMOS33"))
     obuf_inst
       (.O          (CLK_TO_PINS),
        .I          (clk_fwd_out));
endmodule
