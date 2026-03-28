`timescale 1ns/1ps
module dff(
    input clk, din,
    output q, q_bar
);
wire nand1_op;
wire nand2_op;
wire w1;

nand m1 (nand1_op, din, clk);
not m2 (w1, din);
nand m3 (nand2_op, w1, clk);
nand m4 (q, nand1_op, q_bar);
nand m5 (q_bar, nand2_op, q);  

endmodule