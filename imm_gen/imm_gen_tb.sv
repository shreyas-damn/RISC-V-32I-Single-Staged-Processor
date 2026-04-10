`timescale 1ns/1ps
module imm_gen_tb();
reg [31:0]inst_tb;
reg [2:0]imm_sel_tb;
wire [31:0]imm_out_tb;

imm_gen UUT (
    .inst(inst_tb),
    .imm_sel(imm_sel_tb),
    .imm_out(imm_out_tb)
);

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,imm_gen_tb);
    $monitor("Time = %t | Instr = %b | Imm_Sel = %b | Imm_out = %d", $time, inst_tb, imm_sel_tb, imm_out_tb);
    inst_tb = 32'b011111010000_00000_000_00000_0000000;     imm_sel_tb = 3'b000;    #10;        //giving 2000 as imm value
    inst_tb = 32'b0111110_00000_00000_000_10000_0000000;    imm_sel_tb = 3'b001;    #10;        //imm_out remains same for 
    inst_tb = 32'b0_111110_00000_00000_000_1000_0_1100011;  imm_sel_tb = 3'b010;    #10;
    inst_tb = 32'b00000000011111010000_00000_0000000;       imm_sel_tb = 3'b100;    #10;
    $finish;
end
endmodule