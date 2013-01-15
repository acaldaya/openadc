`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:10:23 01/09/2013
// Design Name:   serial_scard_hls_iface
// Module Name:   C:/E/Documents/openadc/openadc_git/hdl/sasebo-w-unified-iseproject/test_scard.v
// Project Name:  sasebo-w-unified-iseproject
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: serial_scard_hls_iface
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_scard;

	// Inputs
	reg reset_i;
	reg clk_i;
	reg do_cmd;
	reg scardfifo_rd;

	// Outputs
	wire scardfifo_rxe;
	wire scardfifo_txf;
	wire scardfifo_txe;
	wire [7:0] scardfifo_din;

	// Bidirs
	wire scard_io;
	
	assign scard_io = 1'bZ;

	// Instantiate the Unit Under Test (UUT)
	serial_scard_hls_iface uut (
		.reset_i(reset_i), 
		.clk_i(clk_i), 
		.scard_io(scard_io), 
		.do_cmd(do_cmd), 
		.scardfifo_rxe(scardfifo_rxe), 
		.scardfifo_txf(scardfifo_txf), 
		.scardfifo_txe(scardfifo_txe), 
		.scardfifo_rd(scardfifo_rd), 
		.scardfifo_din(scardfifo_din)
	);
	
	always 
		#5  clk_i =  !clk_i;

	initial begin
		// Initialize Inputs		
		reset_i = 1;
		clk_i = 0;
		do_cmd = 0;
		scardfifo_rd = 0;

		// Wait 100 ns for global reset to finish
		#100;		
		reset_i = 0;		
		#100;
		
		do_cmd = 1;        
		#100;
		//do_cmd = 0;
		// Add stimulus here
		
		#1000000;
	end
      
endmodule

