`timescale 1ns / 1ps

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

