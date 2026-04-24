`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 13:03:00
// Design Name: 
// Module Name: JKff
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module JKff(
   input J_i, 
   input K_i, 
   input rst_i, 
   input clk_i, 
   output reg Q_o, 
   output Qbar_o
);

wire D;
assign D = (J_i & (~Q_o)) | (Q_o & (~K_i));
assign Qbar_o = ~Q_o;
always@(posedge clk_i) begin
   if(rst_i)
      Q_o <= 1'b0;
   else
      Q_o <= D;
end

endmodule

























































/*
module JKff(
   input J_i, 
   input K_i, 
   input clk_i, 
   input rst_i, 
   output reg Q_o, 
   output Qbar_o
);

wire D_i;

assign D_i = (J_i & (~Q_o)) | (Q_o & (~K_i));
assign Qbar_o = ~Q_o;
always@(posedge clk_i)
if(rst_i)
   Q_o <= 1'b0;
else
   Q_o <= D_i;

endmodule
*/