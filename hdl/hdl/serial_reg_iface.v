`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:22 07/28/2012 
// Design Name: 
// Module Name:    serial_reg_iface 
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
module serial_reg_iface(
    input reset_i,
    input clk_i,
	 input rx_i,
	 output tx_o,
	 
	 output 			cmdfifo_rxf,
	 output			cmdfifo_txe,
	 input			cmdfifo_rd,
	 input			cmdfifo_wr,	
	 output [7:0]	cmdfifo_din,
	 input [7:0]	cmdfifo_dout
    );

	wire clk;
	wire reset;
	wire tx_out;
	wire rx_in;
	
	assign clk = clk_i;
	assign rx_in = rx_i;
	assign tx_o = tx_out;
	assign reset = reset_i;

	//Serial
    wire txbusy;
    async_transmitter AT (.clk(clk),
                      .TxD_start(cmdfifo_wr),
                      .TxD_data(cmdfifo_dout),
                      .TxD(tx_out),
                      .TxD_busy(txbusy));   
                
   assign cmdfifo_txe = ~(txbusy | cmdfifo_wr);
                
    async_receiver AR (.clk(clk),
                   .RxD(rx_in),
                   .RxD_data_ready(cmdfifo_rxf),
                   .RxD_data(cmdfifo_din));
endmodule
