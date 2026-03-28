`timescale 1ns/1ps
module dff_tb();
reg din_tb, clk_tb;
wire q_tb, qbar_tb;

dff uut(
    .din(din_tb),
    .clk(clk_tb),
    .q(q_tb),
    .qbar(qbar_tb)
);

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0, dff_tb);
    $monitor("Time = %t | clk = %b | din = %b | q = %b | qbar = %b", $time, clk_tb, din_tb, q_tb, qbar_tb);
    clk_tb = 0; din_tb = 0; #10;
    clk_tb = 1; din_tb = 1; #10;
    clk_tb = 0; din_tb = 0; #10;
    clk_tb = 1; din_tb = 1; #10;
    clk_tb = 0; din_tb = 1; #10;
    clk_tb = 1; din_tb = 0; #10;
    clk_tb = 0; din_tb = 1; #10;
    clk_tb = 1; din_tb = 1; #10;
    $finish;
end
endmodule