`timescale 1ns / 1ps

module tb_JKff;
reg J_ti;
reg K_ti;
reg clk_ti;
reg rst_ti;
wire Q_to;
wire Qbar_to;

//net(s)
integer count;
integer pass;
integer fail;
reg exp_Q;
reg exp_Qbar;

//instantiation
JKff UUT(.J_i(J_ti), 
   .K_i(K_ti), 
   .clk_i(clk_ti),
   .rst_i(rst_ti),  
   .Q_o(Q_to), 
   .Qbar_o(Qbar_to));

//feeding 
initial begin
   J_ti = 1'b0; 
   K_ti = 1'b0;

#3 J_ti = 1'b1; 
   K_ti = 1'b0;
#10 J_ti = 1'b0; 
   K_ti = 1'b0;
#10 J_ti = 1'b0; 
   K_ti = 1'b1;
#10 J_ti = 1'b1; 
   K_ti = 1'b1;
#10 J_ti = 1'b0; 
   K_ti = 1'b0;

#1 $display("-----------");
$display("Checks: %d, | Pass: %d, Fail: %d", count, pass, fail);
$display("-----------");
#5 $finish;
end

//initialization
initial begin
exp_Q = 1'b0;
count = 0;
pass = 0;
fail = 0;
end

//capture
initial begin
$dumpfile("JKff.vcd");
$dumpvars(0, tb_JKff);
end

//clock
initial begin
clk_ti = 1'b0;
forever
   #5 clk_ti = ~clk_ti;
end

//Reset
initial begin
rst_ti = 1'b1;
#7 rst_ti = 1'b0;
end

//auto check
task check; begin 
   if(rst_ti)
      exp_Q = 1'b0;
   else 
   case ({J_ti, K_ti})
      2'b00: exp_Q = exp_Q; //hold
      2'b01: exp_Q = 1'b0; //reset
      2'b10: exp_Q = 1'b1; //set
      2'b11: exp_Q = ~exp_Q; //toggle
      default: exp_Q = 1'b0;
   endcase
   exp_Qbar = ~exp_Q;
   if((exp_Q !== Q_to) || (exp_Qbar !== Qbar_to)) begin //result matching (mismatch)
      $display("Error | Time: %0t, Clock: %b, Reset: %b | J: %b, K: %b | Q: %b, Qn: %b | Exp Q: %b, Qn: %b", $time, clk_ti, rst_ti, J_ti, K_ti, Q_to, Qbar_to, exp_Q, exp_Qbar);
      fail = fail + 1;
   end
   else ////result matching (match)
      pass = pass + 1;
   count = count + 1; //number of checks performed
end
endtask

//running auto checker
always@(posedge clk_ti)
   #1 check;

endmodule 
