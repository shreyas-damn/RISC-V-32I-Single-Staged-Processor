`timescale 1ns/1ps
module regfile_tb();
logic [31:0] wd;
logic clk, we, rst;
logic[4:0] rd;
logic [31:0][31:0]dout;
logic [31:0] dout_mon;

always@(posedge clk) begin
    dout_mon = dout[rd];
end

regfile UUT(
    .wd(wd),
    .clk(clk),
    .we(we),
    .rst(rst),
    .rd(rd),
    .dout(dout)
);

initial clk = 0;
always #5 clk = ~clk;
initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,regfile_tb);
    $monitor("Time = %t | clk = %b | rst = %b | we = %b | rd = %d | wd = %d | dout = %d ", $time, clk, rst, we, rd, wd, dout_mon);
    rst = 1;
    we = 0;
    wd = 0;
    rd = 0;
    #10;
    rst = 0;
    for (integer i = 0; i < 10; i = i + 1) begin
        we = 1'b1;
        wd = $urandom();
        rd = $urandom_range(0,31);
        @(posedge clk);
        @(posedge clk);
    end
    $finish;
end
endmodule