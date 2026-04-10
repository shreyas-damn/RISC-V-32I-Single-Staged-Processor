`timescale 1ns/1ps
module prog_counter(
    input clk,
    input rst,
    input pc_src,
    input [31:0] imm_ext,
    output [31:0] pc_out
);

wire [31:0] pc_mux_out;
wire [31:0] pc_plus_4;
wire [31:0] pc_target;
wire [31:0] pc_current;

pc_reg DUT1 (
    .clk(clk),
    .rst(rst),
    .pc_next(pc_mux_out),
    .pc_out(pc_current)
);

pc_plus_4 DUT2 (
    .pc(pc_current),
    .pc_plus_4(pc_plus_4)
);

pc_adder DUT3 (
    .pc_current(pc_current),
    .pc_imm(imm_ext),
    .pc_target(pc_target)
);

pc_mux DUT4 (
    .pc_next(pc_plus_4),
    .pc_target(pc_target),
    .pc_src(pc_src),
    .pc_mux_out(pc_mux_out)
);

assign pc_out = pc_current;

endmodule
