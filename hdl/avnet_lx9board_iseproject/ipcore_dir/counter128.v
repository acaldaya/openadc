////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: O.61xd
//  \   \         Application: netgen
//  /   /         Filename: counter128.v
// /___/   /\     Timestamp: Sat Apr 07 20:04:50 2012
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/E/Documents/academic/sidechannel/hardware_accel/avnet_iseproject/ipcore_dir/tmp/_cg/counter128.ngc C:/E/Documents/academic/sidechannel/hardware_accel/avnet_iseproject/ipcore_dir/tmp/_cg/counter128.v 
// Device	: 6slx9csg324-2
// Input file	: C:/E/Documents/academic/sidechannel/hardware_accel/avnet_iseproject/ipcore_dir/tmp/_cg/counter128.ngc
// Output file	: C:/E/Documents/academic/sidechannel/hardware_accel/avnet_iseproject/ipcore_dir/tmp/_cg/counter128.v
// # of Modules	: 1
// Design Name	: counter128
// Xilinx        : C:\Xilinx\13.2\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module counter128 (
  clk, ce, sclr, q
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input ce;
  input sclr;
  output [63 : 0] q;
  
  // synthesis translate_off
  
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<31> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<30> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<29> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<28> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<27> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<26> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<25> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<24> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<23> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<22> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<21> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<20> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<19> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<18> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<17> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<16> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<15> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<14> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<13> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<12> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<11> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<10> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<9> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<8> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<7> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<6> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<5> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<4> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<3> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<2> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<1> ;
  wire \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<0> ;
  wire N0;
  wire N1;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<32>_69 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<31>_70 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<30>_71 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<29>_72 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<28>_73 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<27>_74 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<26>_75 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<25>_76 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<24>_77 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<23>_78 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<22>_79 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<21>_80 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<20>_81 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<19>_82 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<18>_83 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<17>_84 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<16>_85 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<15>_86 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<14>_87 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<13>_88 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<12>_89 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<11>_90 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<10>_91 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<9>_92 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<8>_93 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<7>_94 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<6>_95 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<5>_96 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<4>_97 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<3>_98 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<2>_99 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<1>_100 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<0>_101 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_lut<0>_102 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_103 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_104 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_105 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_106 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_107 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_108 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_109 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_110 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_111 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_112 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_113 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_114 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_115 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_116 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_117 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_118 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_119 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_120 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_121 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_122 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_123 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_124 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_125 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_126 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_127 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_128 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_129 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_130 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_131 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_132 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_133 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<1>_134 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_lut<1> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<1> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<2> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<3> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<4> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<5> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<6> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<7> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<8> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<9> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<10> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<11> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<12> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<13> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<14> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<15> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<16> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<17> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<18> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<19> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<20> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<21> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<22> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<23> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<24> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<25> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<26> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<27> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<28> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<29> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<30> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<31> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<32> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<1> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<2> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<3> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<4> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<5> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<6> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<7> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<8> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<9> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<10> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<11> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<12> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<13> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<14> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<15> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<16> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<17> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<18> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<19> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<20> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<21> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<22> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<23> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<24> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<25> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<26> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<27> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<28> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<29> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<30> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<31> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<32> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<1> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<2> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<3> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<4> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<5> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<6> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<7> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<8> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<9> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<10> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<11> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<12> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<13> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<14> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<15> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<16> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<17> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<18> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<19> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<20> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<21> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<22> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<23> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<24> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<25> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<26> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<27> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<28> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<29> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<30> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<31> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<32> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<0> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<1> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<2> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<3> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<4> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<5> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<6> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<7> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<8> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<9> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<10> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<11> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<12> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<13> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<14> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<15> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<16> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<17> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<18> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<19> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<20> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<21> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<22> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<23> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<24> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<25> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<26> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<27> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<28> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<29> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<30> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<31> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<32> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<32> ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_rt_267 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_rt_268 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_rt_269 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_rt_270 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_rt_271 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_rt_272 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_rt_273 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_rt_274 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_rt_275 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_rt_276 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_rt_277 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_rt_278 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_rt_279 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_rt_280 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_rt_281 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_rt_282 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_rt_283 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_rt_284 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_rt_285 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_rt_286 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_rt_287 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_rt_288 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_rt_289 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_rt_290 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_rt_291 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_rt_292 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_rt_293 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_rt_294 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_rt_295 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_rt_296 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_rt_297 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ;
  wire \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ;
  assign
    q[63] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<31> ,
    q[62] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<30> ,
    q[61] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<29> ,
    q[60] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<28> ,
    q[59] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<27> ,
    q[58] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<26> ,
    q[57] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<25> ,
    q[56] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<24> ,
    q[55] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<23> ,
    q[54] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<22> ,
    q[53] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<21> ,
    q[52] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<20> ,
    q[51] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<19> ,
    q[50] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<18> ,
    q[49] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<17> ,
    q[48] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<16> ,
    q[47] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<15> ,
    q[46] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<14> ,
    q[45] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<13> ,
    q[44] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<12> ,
    q[43] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<11> ,
    q[42] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<10> ,
    q[41] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<9> ,
    q[40] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<8> ,
    q[39] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<7> ,
    q[38] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<6> ,
    q[37] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<5> ,
    q[36] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<4> ,
    q[35] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<3> ,
    q[34] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<2> ,
    q[33] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<1> ,
    q[32] = \NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<0> ;
  VCC   XST_VCC (
    .P(N0)
  );
  GND   XST_GND (
    .G(N1)
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<32>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<31>_70 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<32> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<32> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<32>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<31>_70 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<32> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<32>_69 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<31>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<30>_71 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<31> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<31> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<31>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<30>_71 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<31> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<31>_70 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<30>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<29>_72 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<30> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<30> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<30>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<29>_72 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<30> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<30>_71 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<29>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<28>_73 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<29> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<29> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<29>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<28>_73 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<29> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<29>_72 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<28>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<27>_74 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<28> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<28> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<28>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<27>_74 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<28> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<28>_73 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<27>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<26>_75 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<27> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<27> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<27>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<26>_75 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<27> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<27>_74 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<26>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<25>_76 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<26> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<26> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<26>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<25>_76 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<26> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<26>_75 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<25>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<24>_77 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<25> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<25> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<25>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<24>_77 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<25> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<25>_76 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<24>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<23>_78 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<24> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<24> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<24>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<23>_78 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<24> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<24>_77 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<23>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<22>_79 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<23> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<23> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<23>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<22>_79 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<23> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<23>_78 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<22>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<21>_80 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<22> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<22> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<22>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<21>_80 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<22> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<22>_79 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<21>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<20>_81 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<21> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<21> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<21>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<20>_81 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<21> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<21>_80 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<20>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<19>_82 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<20> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<20> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<20>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<19>_82 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<20> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<20>_81 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<19>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<18>_83 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<19> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<19> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<19>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<18>_83 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<19> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<19>_82 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<18>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<17>_84 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<18> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<18> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<18>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<17>_84 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<18> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<18>_83 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<17>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<16>_85 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<17> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<17> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<17>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<16>_85 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<17> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<17>_84 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<16>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<15>_86 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<16> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<16> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<16>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<15>_86 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<16> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<16>_85 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<15>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<14>_87 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<15> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<15> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<15>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<14>_87 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<15> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<15>_86 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<14>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<13>_88 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<14> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<14> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<14>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<13>_88 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<14> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<14>_87 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<13>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<12>_89 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<13> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<13> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<13>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<12>_89 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<13> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<13>_88 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<12>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<11>_90 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<12> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<12> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<12>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<11>_90 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<12> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<12>_89 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<11>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<10>_91 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<11> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<11> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<11>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<10>_91 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<11> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<11>_90 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<10>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<9>_92 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<10> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<10> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<10>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<9>_92 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<10> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<10>_91 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<9>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<8>_93 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<9> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<9> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<9>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<8>_93 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<9> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<9>_92 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<8>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<7>_94 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<8> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<8> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<8>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<7>_94 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<8> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<8>_93 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<7>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<6>_95 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<7> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<7> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<7>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<6>_95 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<7> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<7>_94 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<6>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<5>_96 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<6> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<6> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<6>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<5>_96 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<6> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<6>_95 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<5>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<4>_97 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<5> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<5> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<5>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<4>_97 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<5> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<5>_96 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<4>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<3>_98 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<4> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<4> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<4>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<3>_98 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<4> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<4>_97 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<3>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<2>_99 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<3> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<3> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<3>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<2>_99 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<3> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<3>_98 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<2>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<1>_100 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<2> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<2> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<2>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<1>_100 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<2> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<2>_99 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_xor<1>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<0>_101 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<1> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<1> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<1>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<0>_101 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<1> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<1>_100 )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<0>  (
    .CI(N1),
    .DI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_lut<0>_102 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<0>_101 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<32>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_104 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_rt_267 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<32> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_104 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_rt_267 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_103 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<31>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_105 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_rt_268 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<31> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_105 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_rt_268 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_104 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<30>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_106 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_rt_269 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<30> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_106 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_rt_269 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_105 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<29>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_107 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_rt_270 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<29> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_107 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_rt_270 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_106 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<28>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_108 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_rt_271 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<28> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_108 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_rt_271 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_107 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<27>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_109 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_rt_272 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<27> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_109 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_rt_272 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_108 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<26>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_110 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_rt_273 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<26> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_110 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_rt_273 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_109 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<25>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_111 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_rt_274 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<25> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_111 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_rt_274 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_110 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<24>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_112 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_rt_275 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<24> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_112 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_rt_275 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_111 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<23>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_113 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_rt_276 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<23> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_113 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_rt_276 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_112 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<22>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_114 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_rt_277 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<22> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_114 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_rt_277 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_113 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<21>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_115 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_rt_278 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<21> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_115 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_rt_278 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_114 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<20>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_116 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_rt_279 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<20> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_116 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_rt_279 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_115 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<19>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_117 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_rt_280 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<19> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_117 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_rt_280 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_116 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<18>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_118 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_rt_281 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<18> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_118 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_rt_281 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_117 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<17>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_119 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_rt_282 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<17> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_119 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_rt_282 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_118 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<16>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_120 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_rt_283 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<16> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_120 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_rt_283 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_119 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<15>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_121 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_rt_284 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<15> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_121 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_rt_284 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_120 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<14>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_122 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_rt_285 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<14> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_122 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_rt_285 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_121 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<13>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_123 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_rt_286 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<13> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_123 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_rt_286 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_122 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<12>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_124 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_rt_287 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<12> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_124 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_rt_287 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_123 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<11>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_125 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_rt_288 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<11> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_125 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_rt_288 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_124 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<10>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_126 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_rt_289 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<10> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_126 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_rt_289 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_125 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<9>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_127 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_rt_290 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<9> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_127 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_rt_290 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_126 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<8>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_128 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_rt_291 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<8> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_128 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_rt_291 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_127 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<7>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_129 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_rt_292 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<7> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_129 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_rt_292 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_128 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<6>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_130 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_rt_293 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<6> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_130 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_rt_293 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_129 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<5>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_131 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_rt_294 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<5> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_131 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_rt_294 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_130 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<4>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_132 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_rt_295 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<4> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_132 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_rt_295 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_131 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<3>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_133 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_rt_296 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<3> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_133 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_rt_296 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_132 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<2>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<1>_134 ),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_rt_297 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<2> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>  (
    .CI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<1>_134 ),
    .DI(N1),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_rt_297 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_133 )
  );
  XORCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_xor<1>  (
    .CI(N1),
    .LI(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_lut<1> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<1> )
  );
  MUXCY   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<1>  (
    .CI(N1),
    .DI(N0),
    .S(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_lut<1> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<1>_134 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0  (
    .C(clk),
    .CE(ce),
    .D(N0),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_32  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_cy<32>_69 ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<32> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_31  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<32> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<31> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_30  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<31> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<30> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_29  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<30> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<29> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_28  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<29> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<28> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_27  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<28> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<27> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_26  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<27> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<26> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_25  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<26> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<25> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_24  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<25> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<24> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_23  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<24> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<23> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_22  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<23> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<22> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_21  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<22> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<21> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_20  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<21> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<20> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_19  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<20> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<19> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_18  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<19> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<18> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_17  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<18> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<17> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_16  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<17> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<16> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_15  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<16> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<15> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_14  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<15> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<14> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_13  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<14> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<13> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_12  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<13> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<12> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_11  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<12> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<11> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_10  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<11> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<10> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_9  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<10> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<9> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_8  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<9> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<8> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_7  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<8> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<7> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_6  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<7> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<6> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_5  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<6> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<5> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_4  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<5> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<4> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_3  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<4> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<3> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_2  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<3> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<2> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_1  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<2> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<1> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q_0  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].sum_seg<1> ),
    .R(sclr),
    .Q(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<0> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_32  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_103 ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<32> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_31  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<32> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<31> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_30  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<31> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<30> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_29  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<30> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<29> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_28  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<29> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<28> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_27  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<28> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<27> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_26  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<27> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<26> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_25  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<26> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<25> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_24  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<25> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<24> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_23  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<24> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<23> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_22  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<23> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<22> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_21  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<22> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<21> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_20  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<21> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<20> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_19  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<20> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<19> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_18  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<19> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<18> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_17  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<18> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<17> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_16  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<17> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<16> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_15  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<16> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<15> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_14  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<15> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<14> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_13  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<14> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<13> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_12  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<13> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<12> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_11  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<12> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<11> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_10  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<11> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<10> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_9  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<10> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<9> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_8  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<9> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<8> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_7  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<8> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<7> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_6  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<7> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<6> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_5  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<6> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<5> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_4  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<5> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<4> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_3  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<4> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<3> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_2  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<3> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<2> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_1  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<2> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<1> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q_0  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].sum_seg<1> ),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<0> )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_31  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<31> ),
    .R(sclr),
    .Q(q[31])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_30  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<30> ),
    .R(sclr),
    .Q(q[30])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_29  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<29> ),
    .R(sclr),
    .Q(q[29])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_28  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<28> ),
    .R(sclr),
    .Q(q[28])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_27  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<27> ),
    .R(sclr),
    .Q(q[27])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_26  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<26> ),
    .R(sclr),
    .Q(q[26])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_25  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<25> ),
    .R(sclr),
    .Q(q[25])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_24  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<24> ),
    .R(sclr),
    .Q(q[24])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_23  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<23> ),
    .R(sclr),
    .Q(q[23])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_22  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<22> ),
    .R(sclr),
    .Q(q[22])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_21  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<21> ),
    .R(sclr),
    .Q(q[21])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_20  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<20> ),
    .R(sclr),
    .Q(q[20])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_19  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<19> ),
    .R(sclr),
    .Q(q[19])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_18  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<18> ),
    .R(sclr),
    .Q(q[18])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_17  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<17> ),
    .R(sclr),
    .Q(q[17])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_16  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<16> ),
    .R(sclr),
    .Q(q[16])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_15  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<15> ),
    .R(sclr),
    .Q(q[15])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_14  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<14> ),
    .R(sclr),
    .Q(q[14])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_13  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<13> ),
    .R(sclr),
    .Q(q[13])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_12  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<12> ),
    .R(sclr),
    .Q(q[12])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_11  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<11> ),
    .R(sclr),
    .Q(q[11])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_10  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<10> ),
    .R(sclr),
    .Q(q[10])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_9  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<9> ),
    .R(sclr),
    .Q(q[9])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_8  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<8> ),
    .R(sclr),
    .Q(q[8])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_7  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<7> ),
    .R(sclr),
    .Q(q[7])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_6  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<6> ),
    .R(sclr),
    .Q(q[6])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_5  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<5> ),
    .R(sclr),
    .Q(q[5])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_4  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<4> ),
    .R(sclr),
    .Q(q[4])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_3  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<3> ),
    .R(sclr),
    .Q(q[3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_2  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<2> ),
    .R(sclr),
    .Q(q[2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_1  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<1> ),
    .R(sclr),
    .Q(q[1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_pipe/opt_has_pipe.first_q_0  (
    .C(clk),
    .CE(ce),
    .D(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<0> ),
    .R(sclr),
    .Q(q[0])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1210  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<9> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<10> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op134  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<10> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<11> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op141  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<11> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<12> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op151  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<12> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<13> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op161  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<13> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<14> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op171  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<14> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<15> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op181  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<15> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<16> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op191  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<16> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<17> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1101  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<17> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<18> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1111  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<18> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<19> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1121  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<0> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<1> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1131  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<19> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<20> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1141  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<20> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<21> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1151  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<21> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<22> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1161  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<22> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<23> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1171  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<23> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<24> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1181  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<24> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<25> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1191  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<25> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<26> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1201  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<26> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<27> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1211  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<27> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<28> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1221  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<28> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<29> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1231  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<1> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<2> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1241  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<29> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<30> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1251  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<30> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<31> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1261  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<31> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<32> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1271  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<2> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<3> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1281  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<3> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<4> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1291  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<4> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<5> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1301  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<5> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<6> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1311  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<6> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<7> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1321  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<7> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<8> )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Mmux_i_seg[2].i_no_tc.op1331  (
    .I0(\NlwRenamedSig_OI_U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_sum_reg/opt_has_pipe.first_q<8> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[2].i_no_tc.op1<9> )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<31> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<32>_rt_267 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<30> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<31>_rt_268 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<29> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<30>_rt_269 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<28> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<29>_rt_270 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<27> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<28>_rt_271 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<26> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<27>_rt_272 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<25> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<26>_rt_273 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<24> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<25>_rt_274 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<23> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<24>_rt_275 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<22> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<23>_rt_276 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<21> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<22>_rt_277 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<20> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<21>_rt_278 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<19> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<20>_rt_279 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<18> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<19>_rt_280 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<17> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<18>_rt_281 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<16> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<17>_rt_282 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<15> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<16>_rt_283 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<14> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<15>_rt_284 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<13> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<14>_rt_285 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<12> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<13>_rt_286 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<11> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<12>_rt_287 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<10> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<11>_rt_288 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<9> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<10>_rt_289 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<8> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<9>_rt_290 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<7> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<8>_rt_291 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<6> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<7>_rt_292 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<5> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<6>_rt_293 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<4> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<5>_rt_294 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<3> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<4>_rt_295 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<2> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<3>_rt_296 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_rt  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<1> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_cy<2>_rt_297 )
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_lut<0>  (
    .I0(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<32> ),
    .I1(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[2].sum_seg_lut<0>_102 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_1  (
    .C(clk),
    .CE(ce),
    .D(N0),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_298 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_0_2  (
    .C(clk),
    .CE(ce),
    .D(N0),
    .R(sclr),
    .Q(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_piped.i_load_pipe/opt_has_pipe.first_q_1 )
  );
  INV   \U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_lut<1>_INV_0  (
    .I(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/i_seg[1].i_sum_reg/opt_has_pipe.first_q<0> ),
    .O(\U0/i_synth/i_baseip.i_xbip_counter/i_fabric.i_fab/Madd_i_seg[1].sum_seg_lut<1> )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
