///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// All Rights Reserved
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor     : Xilinx
// \   \   \/     Version    : 13.2
//  \   \         Application: Xilinx CORE Generator
//  /   /         Filename   : coregen_vio.v
// /___/   /\     Timestamp  : Sat Feb 11 09:42:25 Atlantic Standard Time 2012
// \   \  /  \
//  \___\/\___\
//
// Design Name: Verilog Synthesis Wrapper
///////////////////////////////////////////////////////////////////////////////
// This wrapper is used to integrate with Project Navigator and PlanAhead

`timescale 1ns/1ps

module coregen_vio(
    CONTROL,
    CLK,
    SYNC_IN,
    SYNC_OUT);


inout [35 : 0] CONTROL;
input CLK;
input [15 : 0] SYNC_IN;
output [15 : 0] SYNC_OUT;

endmodule
