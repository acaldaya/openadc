`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:09:44 07/19/2013
// Design Name:   varwidth_fifo_withpre
// Module Name:   C:/E/Documents/openadc/openadc_git/hdl/hdl/beta/newfifo/newfifo_sim_test/tb_varwith_fifo_withpre.v
// Project Name:  newfifo_sim_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: varwidth_fifo_withpre
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_varwith_fifo_withpre;

	// Inputs
	reg rst;
	reg [9:0] wr_data;
	reg wr_ce;
	reg wr_clk;
	reg [31:0] wr_circular_depth;
	reg wr_dest;
	reg rd_ce;
	reg rd_clk;
	reg wr_trigger;

	// Outputs
	wire wr_full;
	wire [7:0] rd_data;

	// Instantiate the Unit Under Test (UUT)
	varwidth_fifo_withpre #(.max_samples(100)) uut (
		.rst(rst), 
		.number_samples(100),
		.wr_data(wr_data), 
		.wr_ce(wr_ce), 
		.wr_clk(wr_clk), 
		.wr_circular_depth(wr_circular_depth), 
		.wr_trigger(wr_trigger),
		.wr_done(wr_full), 
		.rd_data(rd_data), 
		.rd_ce(rd_ce), 
		.rd_clk(rd_clk)
	);

	always
		#5  wr_clk = ~wr_clk;

	integer i;

	initial begin
		// Initialize Inputs
		rst = 0;
		wr_data = 0;
		wr_ce = 0;
		wr_clk = 0;
		wr_circular_depth = 17;
		wr_dest = 0;
		rd_ce = 0;
		rd_clk = 0;
		wr_trigger = 0;

		// Wait 100 ns for global reset to finish
		#50;
		rst = 1;
		#50;
		rst = 0;
		#50;
        
		// Add stimulus here
		for (i=0; i < 46; i=i+1) begin: TEST
			fifo_write(i+10'd234);
		end
		
		wr_trigger = 1;
		fifo_write(289);
		wr_trigger = 0;

		for (i=0; i < 100; i=i+1) begin: TEST2
			fifo_write(i+10'd234);
		end
		

	end

task fifo_write;
		input [9:0] data;
		begin			
			@(negedge wr_clk);
			wr_data = data;
			#1;
			wr_ce = 1;
			@(posedge wr_clk);
			#1;
			wr_ce = 0;
		end
endtask 

      
endmodule
