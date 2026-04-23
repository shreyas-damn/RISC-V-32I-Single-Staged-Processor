`timescale 1ns/1ps
module reg_file_tb();
logic clk;
logic rst;
logic w_en;
logic [4:0] rs1;
logic [4:0] rs2;
logic [4:0] rd;
logic [31:0] wr_d;
logic [31:0] rd1;
logic [31:0] rd2;

reg_file DUT (
    .clk(clk),
    .rst(rst),
    .w_en(w_en),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .wr_d(wr_d),
    .rd1(rd1),
    .rd2(rd2)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,reg_file_tb);
    clk = 0;
    rst = 1;
    w_en = 0;
    rs1 = 0;
    rs2 = 0;
    rd  = 0;
    wr_d = 0;

    $dumpfile("sim.vcd");
    $dumpvars(0, reg_file_tb);

    #10;
    rst = 0;

    #10;
    w_en = 1;
    rd = 5'd1;
    wr_d = 32'd10;

    #10;
    w_en = 0;

    #10;
    w_en = 1;
    rd = 5'd2;
    wr_d = 32'd20;

    #10;
    w_en = 0;

    #10;
    rs1 = 5'd1;
    rs2 = 5'd2;

    #10;
    $display("x1 = %d | x2 = %d", rd1, rd2);

    #10;
    w_en = 1;
    rd = 5'd0;
    wr_d = 32'd999;

    #10;
    w_en = 0;
    rs1 = 5'd0;

    #10;
    $display("x0 = %d", rd1);

    #20;
    $finish;

end
endmodule