`timescale 1ns/1ps
module pc_adder(
    input [31:0] pc_current,
    input [31:0] pc_imm,
    output [31:0] pc_target
);

assign pc_target = pc_current + pc_imm;

endmodule