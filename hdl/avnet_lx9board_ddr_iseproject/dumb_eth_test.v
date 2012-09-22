`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:45 09/09/2012 
// Design Name: 
// Module Name:    dumb_eth 
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

module dumb_eth_test(
	 input		 reset_i,

    input 		 eth_col,
    input 		 eth_crc,
	 output 		 eth_mdc,
	 inout  		 eth_mdio,
	 
	 output      eth_reset_n,
	 
	 input 		 eth_rx_clk,
	 input [3:0] eth_rx_data,
	 input       eth_rx_dv,
	 input       eth_rx_er,
	 
	 input       eth_tx_clk,
	 output[3:0] eth_tx_data,
	 output      eth_tx_en
    );
	 

	wire [7:0] usr_data;
	wire       usr_datard;
	wire       usr_start;
	wire       usr_clk;

	eth_phydirect phy(
	  .reset_i(1'b0),

     .eth_col(eth_col),
     .eth_crc(eth_crc),
	  .eth_mdc(eth_mdc),
	  .eth_mdio(eth_mdio),
	 
	  .eth_reset_n(eth_reset_n),
	  .eth_rx_clk(eth_rx_clk),
	  .eth_rx_data(eth_rx_data),
	  .eth_rx_dv(eth_rx_dv),
	  .eth_rx_er(eth_rx_er),
	 
	  .eth_tx_clk(eth_tx_clk),
	  .eth_tx_data(eth_tx_data),
	  .eth_tx_en(eth_tx_en),
	  
	  .usr_clk_o(usr_clk),
	  .usr_start_i(reset_i),
	  .usr_ethsrc_i(48'h000102030405),
	  .usr_ethdst_i(48'hD067E5455171),
	  .usr_ipsrc_i(32'hC0A8020A),
	  .usr_ipdst_i(32'hC0A80201),
	  .usr_data_len_i(16'd64),
	  .usr_udpport_i(16'd4000),
	  .usr_datard_o(usr_datard),
	  .usr_data_i(usr_data)
    );

endmodule
