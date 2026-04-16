`timescale 1ns/1ps

module cntrl_unit_tb;

reg [31:0] instr;
reg zero;
reg negative;
reg carry;
reg overflow;
reg rst;
reg clk;

wire [3:0] alu_ctrl;
wire reg_write;
wire mem_read;
wire mem_write;
wire alu_src;
wire branch;
wire jump;
wire [1:0] wb_sel;
wire [2:0] imm_sel;

cntrl_unit dut (
    .instr(instr),
    .zero(zero),
    .negative(negative),
    .carry(carry),
    .overflow(overflow),
    .rst(rst),
    .clk(clk),
    .alu_ctrl(alu_ctrl),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .branch(branch),
    .jump(jump),
    .wb_sel(wb_sel),
    .imm_sel(imm_sel)
);

always #5 clk = ~clk;

task apply_instr(input [31:0] inst);
begin
    instr = inst;
    #10;
end
endtask

initial begin
    $dumpfile("cntrl_unit.vcd");
    $dumpvars(0, cntrl_unit_tb);

    clk = 0;
    rst = 1;
    instr = 0;
    zero = 0;
    negative = 0;
    carry = 0;
    overflow = 0;

    #10 rst = 0;

    apply_instr(32'b0000000_00000_00000_000_00000_0110011);
    apply_instr(32'b0100000_00000_00000_000_00000_0110011);
    apply_instr(32'b0000000_00000_00000_111_00000_0110011);

    apply_instr(32'b000000000001_00000_000_00000_0010011);

    apply_instr(32'b000000000001_00000_010_00000_0000011);

    apply_instr(32'b0000000_00000_00000_010_00000_0100011);

    zero = 1;
    apply_instr(32'b0000000_00000_00000_000_00000_1100011);
    zero = 0;

    apply_instr(32'b00000000000000000000_00000_0110111);
    apply_instr(32'b00000000000000000000_00000_0010111);

    apply_instr(32'b00000000000000000000_00000_1101111);

    #20;
    $finish;
end

endmodule