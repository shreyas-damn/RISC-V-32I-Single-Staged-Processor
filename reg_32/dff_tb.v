`timescale 1ns/1ps
module dff_tb();
reg din_tb;
reg clk_tb;
wire q_tb;
wire q_bar_tb;

dff uut(
    .din(din_tb),
    .clk(clk_tb),
    .q(q_tb),
    .q_bar(q_bar_tb)
);
initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,dff_tb);
    $monitor("Time = %t | clk = %b | din = %b | q = %b | q_bar = %b", $time, clk_tb, din_tb, q_tb, q_bar_tb);
    clk_tb = 0; din_tb = 0; #10;
    clk_tb = 1; din_tb = 1; #10;
    clk_tb = 0; din_tb = 0; #10;
    clk_tb = 1; din_tb = 1; #10;
    $finish;    
end
endmodule