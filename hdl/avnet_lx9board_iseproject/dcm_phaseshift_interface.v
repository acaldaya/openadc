`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:56 06/06/2012 
// Design Name: 
// Module Name:    dcm_phaseshift_interface 
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
module dcm_phaseshift_interface(
    input clk_i,             //Clock for inputs & PCLK for DCM
	 input reset_i,           //Reset - must also connect to DCM so this block knows when defaults are loaded
	 input [8:0] default_value_i, //Default PS value in 2's complement format
    input [8:0] value_i,     //Requested PS Value in 2's complement format	 
    input load_i,            //When high starts a new phase shift operation    
	 output [8:0] value_o,    //Actual PS Value in 2's complement format, valid when done_o goes high
    output done_o,           //High for one clock cycle once operation complete
    output dcm_psen_o,       //Connect to DCM
    output dcm_psincdec_o,   //Connect to DCM
    input dcm_psdone_i,      //Connect to DCM
    input [7:0] dcm_status_i //Connect to DCM
    );
	 
	 `define RESET          'b000
    `define IDLE           'b001
    `define START          'b010
    `define PULSE          'b011
    `define WAIT1          'b100
	 `define WAIT2          'b101
    `define DONE           'b110          

    reg [3:0]              state = `RESET;
	 reg [8:0]              dcm_ps_count;
	 reg [8:0]					dcm_ps_target;
	 
	 reg							dcm_psen_o;
	 reg							dcm_psincdec_o;
	 reg							done_o;
	 reg [8:0]					value_o;
	 
	 reg last_psincdec;
	 
	 always @(posedge clk_i or posedge reset_i)
    begin
      if (reset_i == 1) begin
         state <= `RESET;          
      end else begin
         case (state)
            `RESET: begin
					done_o <= 0;
					dcm_psen_o <= 0;
					dcm_psincdec_o <= 0;
					state <= `IDLE;
					dcm_ps_count <= default_value_i;
					value_o <= 0;
					last_psincdec <= 0;
            end
				
				`IDLE: begin
					dcm_psen_o <= 0;
					dcm_psincdec_o <= 0;
					done_o <= 0;
					
					if (load_i) begin
						state <= `START;					
					end else begin
						state <= `IDLE;
					end
            end
			
				`START: begin
					done_o <= 0;
					dcm_psen_o <= 0;
					dcm_psincdec_o <= 0;
					dcm_ps_target <= value_i;
					state <= `PULSE;
				end
				
				`PULSE: begin
					done_o <= 0;
					if (dcm_ps_target < dcm_ps_count) begin
						if ((last_psincdec == 0) && (dcm_status_i[0] == 1)) begin
							//Underflow & attempt to decrement
							value_o <= dcm_ps_count;
							state <= `DONE;
							dcm_psincdec_o <= 0;
							dcm_psen_o <= 0;
						end else begin
							//Decrement
							last_psincdec <= 0;
							dcm_psincdec_o <= 0;
							dcm_psen_o <= 1;
							dcm_ps_count <= dcm_ps_count - 8'd1;
							state <= `WAIT1;
						end				
					end else if (dcm_ps_target > dcm_ps_count) begin
						if ((last_psincdec == 1) && (dcm_status_i[0] == 1)) begin
							//Overflow & attempt to increment
							value_o <= dcm_ps_count;
							state <= `DONE;
							dcm_psincdec_o <= 0;
							dcm_psen_o <= 0;
						end else begin
							//Increment
							last_psincdec <= 1;
							dcm_psincdec_o <= 1;
							dcm_psen_o <= 1;
							dcm_ps_count <= dcm_ps_count + 8'd1;
							state <= `WAIT1;
						end
					end else begin
						//Matched requested
						dcm_psincdec_o <= 0;
						dcm_psen_o <= 0;
						value_o <= dcm_ps_count;
						state <= `DONE;						
					end
				end
				
				`WAIT1: begin
					//Wait for PSDONE to go low from previous operation
					state <= `WAIT2;
					done_o <= 0;
					dcm_psen_o <= 0;
				end					

				`WAIT2: begin
					done_o <= 0;
					dcm_psen_o <= 0;					
					if (dcm_psdone_i == 1'b1) begin
						state <= `PULSE;
					end else begin
						state <= `WAIT2;
					end
				end
					
				`DONE: begin
					done_o <= 1;
					dcm_psen_o <= 0;
					dcm_psincdec_o <= 0;
					state <= `IDLE;
				end
				
				default: begin
					done_o <= 0;
					dcm_psen_o <= 0;
					dcm_psincdec_o <= 0;
					state <= `RESET;
				end
			endcase
		end
	end		


endmodule
