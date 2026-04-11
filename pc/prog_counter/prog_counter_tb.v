`timescale 1ns/1ps
module pc_tb();
reg clk;
reg rst;
reg pc_src;
reg [31:0] imm_ext;
wire [31:0] pc_out;

prog_counter DUT (
    .clk(clk),
    .rst(rst),
    .pc_src(pc_src),
    .imm_ext(imm_ext),
    .pc_out(pc_out)
);

initial clk = 0;
always #5 clk = ~clk;

initial begin

    $dumpfile("sim.vcd");
    $dumpvars(0,pc_tb);
    $monitor("Time = %t | clk = %b | rst = %b | pc_src = %b | imm_ext = %h | pc_out = %b", $time, clk, rst, pc_src, imm_ext, pc_out);

    rst = 1;
    pc_src = 0;
    imm_ext = 0;
    #10 
    rst = 0;
    #10;
    //pc+4
    #20;
    pc_src = 0;
    #50;
    //branching or jump statement
    pc_src = 1;
    imm_ext = 32'h0000_0010; 
    #50;
    //branching with different immediate
    imm_ext = 32'h0000_0020;
    #50;
    pc_src = 0;
    #50;
    $finish;
end

endmodule