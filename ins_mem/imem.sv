`timescale 1ns/1ps
module imem(
    input logic [31:0] addr,
    output logic [31:0] instr
);
logic [31:0] memo [0:255];    //making it 1kb

initial begin
    $readmemh("inst_mem.hex", memo);
end
/*
INSTRUCTIONS PRESENT IN INST_MEM.HEX FILE
002081B3 // ADD  x3, x1, x2    (R-type: x3 = 10 + 20)
40208233 // SUB  x4, x1, x2    (R-type: x4 = 10 - 20)
00A00093 // ADDI x1, x0, 10    (I-type: Load 10 into x1)
01400113 // ADDI x2, x0, 20    (I-type: Load 20 into x2)
00812203 // LW   x4, 8(x2)     (I-type Load: x4 = Mem[x2+8])
00352623 // SW   x3, 12(x10)   (S-type: Store x3 to Mem[x10+12])
00208863 // BEQ  x1, x2, 16    (B-type: If x1==x2, skip 4 instructions)
123452B7 // LUI  x5, 0x12345   (U-type: Load upper 20 bits)
0000006F // JAL  x0, 0         (J-type: Infinite loop / Jump to self)
*/
assign instr = memo[addr[9:2]]; //since pc increments +4, but memory increment is +1

endmodule