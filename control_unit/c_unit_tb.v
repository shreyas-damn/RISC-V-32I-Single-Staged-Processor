`timescale 1ns/1ps

module cntrl_unit_tb;

    reg  [31:0] instr;
    reg         zero;
    reg         rst;
    reg         clk;

    wire [3:0]  alu_ctrl;
    wire        reg_write;
    wire        mem_read;
    wire        mem_write;
    wire        alu_src;
    wire [1:0]  pc_sel;
    wire [1:0]  wb_sel;
    wire [2:0]  imm_sel;

    // DUT
    cntrl_unit DUT (
        .instr(instr),
        .zero(zero),
        .rst(rst),
        .clk(clk),
        .alu_ctrl(alu_ctrl),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .pc_sel(pc_sel),
        .wb_sel(wb_sel),
        .imm_sel(imm_sel)
    );

    // clock (not really needed but kept for structure consistency)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        zero = 0;

        #10 rst = 0;

        $display("\n--- CONTROL UNIT TEST START ---\n");

        // ---------------- R-TYPE ADD ----------------
        instr = 32'b0000000_00010_00001_000_00011_0110011;
        #10;
        $display("R-TYPE ADD: alu_ctrl=%b reg_write=%b", alu_ctrl, reg_write);

        // ---------------- R-TYPE SUB ----------------
        instr = 32'b0100000_00010_00001_000_00011_0110011;
        #10;
        $display("R-TYPE SUB: alu_ctrl=%b", alu_ctrl);

        // ---------------- I-TYPE ADDI ----------------
        instr = 32'b000000000100_00001_000_00010_0010011;
        #10;
        $display("ADDI: alu_ctrl=%b alu_src=%b", alu_ctrl, alu_src);

        // ---------------- LOAD (LW) ----------------
        instr = 32'b000000000100_00001_010_00010_0000011;
        #10;
        $display("LW: mem_read=%b wb_sel=%b", mem_read, wb_sel);

        // ---------------- STORE (SW) ----------------
        instr = 32'b0000000_00010_00001_010_00100_0100011;
        #10;
        $display("SW: mem_write=%b alu_src=%b", mem_write, alu_src);

        // ---------------- BRANCH (BEQ) ----------------
        zero = 1;
        instr = 32'b0000000_00010_00001_000_00000_1100011;
        #10;
        $display("BEQ: pc_sel=%b (zero=%b)", pc_sel, zero);

        // ---------------- JAL ----------------
        instr = 32'b00000000000100000000_00000_1101111;
        #10;
        $display("JAL: wb_sel=%b pc_sel=%b", wb_sel, pc_sel);

        // ---------------- JALR ----------------
        instr = 32'b000000000000_00001_000_00010_1100111;
        #10;
        $display("JALR: pc_sel=%b alu_src=%b", pc_sel, alu_src);

        $display("\n--- TEST COMPLETE ---");
        $finish;
    end

endmodule