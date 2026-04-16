`timescale 1ns/1ps
module pc_adder_tb();
reg [31:0] pc_current;
reg [31:0] pc_imm;
wire [31:0] pc_target;

pc_adder UUT (
    .pc_current(pc_current),
    .pc_imm(pc_imm),
    .pc_target(pc_target)
);

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,pc_adder_tb);
    $monitor("Time = %t | pc_current = %b | pc_imm = %b | pc_target = %b", $time, pc_current, pc_imm, pc_target);
    //jump 8 bits
    pc_current = 32'h0000_1000;
    pc_imm     = 32'h0000_0008;
    #10;
    //jump 240 bits
    pc_current = 32'h0000_1000;
    pc_imm     = 32'h0000_00F0;
    #10;
    //65,535 bit jump
    pc_current = 32'h0000_1020;
    pc_imm     = 32'hFFFFFFE0; 
    #10;
    //0 bit jump
    pc_current = 32'h0000_0000;
    pc_imm     = 32'h0000_0000;
    #10;
    $finish;
end
endmodule