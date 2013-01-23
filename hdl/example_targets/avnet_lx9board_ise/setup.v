
//Uncomment this to get code for using CHIPSCOPE
//`define CHIPSCOPE

//Define the board in use
`define AVNET

`ifdef AVNET
	`define UART_CLK 40000000
	`define UART_BAUD 512000
	`define MAX_SAMPLES 24573
`endif

//Baud rate of the UART
`ifndef UART_BAUD
`define UART_BAUD 512000
`endif

//`define USE_ETH

//`define USE_DDR

//Uncomment the following if you want the ETH pins in your UCF file
//If your design may use the ETH you should do this, so you can then
//just use the USE_ETH flag to decide if it's compiled in or not
`define OPT_ETH

//Uncomment the following if you want the DDR pins in your UCF file
//If your design may use the DDR you should do this, so you can then
//just use the USE_DDR flag to decide if it's compiled in or not
`define OPT_DDR