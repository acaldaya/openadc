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

module dumb_eth(
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
	 
	 wire [3:0] eth_tx_data_reg;
	 
	 reg [1:0] clkdiv_reg;
	 wire tx_clk;
	 
	 assign tx_clk = eth_tx_clk;
	 	 
	 assign eth_reset_n = ~reset_i;	 
	 
	   
	 assign eth_mdc = 1'b0;
	 assign eth_mdio = 1'bZ;
	 
	 reg [7:0] tx_data;
	 reg tx_nibble_cnt;
	 
	 /* Follow EN logic is designed to ensure EN stays high until final
       nibble is transmitted over the wire */
	 reg tx_en;	 
	 reg tx_en_rst;
	 reg eth_tx_en_reg;
	 
	 always @(negedge tx_clk) begin
		if (tx_en) begin
			tx_en_rst <= 1'b1;
			eth_tx_en_reg <= 1'b1;
		end else begin
			tx_en_rst <= 1'b0;
			eth_tx_en_reg <= ~((~tx_en) | tx_en_rst);
		end
	end
	
	assign eth_tx_en = eth_tx_en_reg;
	
	 
	 always @(posedge tx_clk) begin
		tx_nibble_cnt <= ~tx_nibble_cnt;
	 end
	 
	 assign eth_tx_data_reg = tx_nibble_cnt ? tx_data[7:4] : tx_data[3:0];
	 
	 /*
	 always @(negedge tx_clk) begin
		if(tx_nibble_cnt) begin
			eth_tx_data_reg <= tx_data[7:4];
		end else begin
			eth_tx_data_reg <= tx_data[3:0];
		end
	 end
	 */
	 
	 assign eth_tx_data = eth_tx_data_reg;

	 
	 wire [7:0] dest_address [0:5];
	 wire [7:0] src_address [0:5];
	 wire [7:0] fcs;
	 
	 assign dest_address[0] = 8'hD0;
	 assign dest_address[1] = 8'h67;
	 assign dest_address[2] = 8'hE5;
	 assign dest_address[3] = 8'h45;
	 assign dest_address[4] = 8'h51;
	 assign dest_address[5] = 8'h71;
	 
	 assign src_address[0] = 8'h00;
	 assign src_address[1] = 8'h02;
	 assign src_address[2] = 8'h03;
	 assign src_address[3] = 8'h04;
	 assign src_address[4] = 8'h05;
	 assign src_address[5] = 8'h06;	 
	 
	 `define PHY_IDLE            'b0000
	 `define PHY_PREAMBLE		  'b0001
	 `define MAC_DST				  'b0010
	 `define MAC_SRC				  'b0011
	 `define MAC_TYPE				  'b0100
	 `define MAC_PAYLOAD         'b0101
	 `define MAC_FCS             'b0110
	 
	 reg [3:0] state;
	 reg [15:0] stcnt;
	 
	 //State machine
	 always @(negedge tx_clk) begin
		if (reset_i) begin
			state <= `PHY_IDLE;
			stcnt <= 16'd0;
			tx_en <= 1'b0;
		end else if (tx_nibble_cnt) begin
			case (state) 
				`PHY_IDLE: begin
					tx_data <= 8'h55; /* 0x55 Preamble */
					if (stcnt == 16'd30000) begin
						state <= `PHY_PREAMBLE;
						stcnt <= 16'd0;
						tx_en <= 1'b1;
					end else begin
						stcnt <= stcnt + 16'd1;
						tx_en <= 1'b0;
					end		
					crc_calc <= 1'b0;
					crc_init <= 1'b1;
				end
				
				`PHY_PREAMBLE: begin
					if (stcnt == 16'd7) begin
						stcnt <= 16'd0;
						state <= `MAC_DST;
						tx_data <= 8'hD5; /* 0xD5 SFD */
					end else begin
						tx_data <= 8'h55;
						stcnt <= stcnt + 16'd1;
						state <= `PHY_PREAMBLE;
					end
					tx_en <= 1'b1;
					crc_calc <= 1'b0;
					crc_init <= 1'b0;
				end
				
				`MAC_DST: begin
					if (stcnt == 16'd5) begin
						stcnt <= 16'd0;
						state <= `MAC_SRC;
					end else begin					
						stcnt <= stcnt + 16'd1;
						state <= `MAC_DST;
					end
					tx_data <= dest_address[stcnt];
					tx_en <= 1'b1;	
					crc_calc <= 1'b1;
					crc_init <= 1'b0;					
				end
				
				`MAC_SRC: begin
					if (stcnt == 16'd5) begin
						stcnt <= 16'd0;
						state <= `MAC_TYPE;
					end else begin					
						stcnt <= stcnt + 16'd1;
						state <= `MAC_SRC;
					end
					tx_data <= src_address[stcnt];
					tx_en <= 1'b1;	
					crc_calc <= 1'b1;
					crc_init <= 1'b0;					
				end
				
				`MAC_TYPE: begin
					if (stcnt == 16'd1) begin
						stcnt <= 16'd0;
						tx_data <= 8'h00;
						state <= `MAC_PAYLOAD;
					end else begin					
						stcnt <= stcnt + 16'd1;
						tx_data <= 8'h08;
						state <= `MAC_TYPE;
					end					
					tx_en <= 1'b1;
					crc_calc <= 1'b1;
					crc_init <= 1'b0;					
				end
				
				`MAC_PAYLOAD: begin
					if (stcnt == 16'd99) begin
						stcnt <= 16'd0;
						state <= `MAC_FCS;
					end else begin					
						stcnt <= stcnt + 16'd1;
						state <= `MAC_PAYLOAD;
					end
					tx_data <= 8'hCC;
					tx_en <= 1'b1;		
					crc_calc <= 1'b1;
					crc_init <= 1'b0;						
				end
				
				`MAC_FCS: begin
					if (stcnt == 16'd3) begin
						stcnt <= 16'd0;
						state <= `PHY_IDLE;
					end else begin					
						stcnt <= stcnt + 16'd1;
						state <= `MAC_FCS;
					end
					tx_data <= fcs;
					tx_en <= 1'b1;	
					crc_calc <= 1'b0;
					crc_init <= 1'b0;						
				end
				
				default: begin
					state <= `PHY_IDLE;
					tx_data <= 8'd0;
					tx_en <= 1'b0;
					stcnt <= 16'd0;				
				end
			endcase
		end
	 end
	 
	 reg crc_calc;
	 reg crc_init;
	 
	 crc32 crc32_eth (
		.crc(fcs),
		.d(tx_data),
		.calc(crc_calc),
		.init(crc_init),
		.d_valid(tx_nibble_cnt),
		.clk(tx_clk),
		.reset(reset_i)
   );
	 	 
	wire [35:0]                          chipscope_control;
	coregen_icon icon (
    .CONTROL0(chipscope_control) // INOUT BUS [35:0]
   ); 
  
	wire [127:0] cs_data;
    
   coregen_ila ila (
    .CONTROL(chipscope_control), // INOUT BUS [35:0]
    .CLK(tx_clk), // IN
    .TRIG0(cs_data) // IN BUS [127:0]
   );
	
	assign cs_data[3:0] = eth_tx_data_reg;
	assign cs_data[7:4] = state;
	assign cs_data[31:16] = stcnt;
	assign cs_data[32] = reset_i;
	assign cs_data[33] = tx_en;
	assign cs_data[34] = tx_nibble_cnt;

endmodule
