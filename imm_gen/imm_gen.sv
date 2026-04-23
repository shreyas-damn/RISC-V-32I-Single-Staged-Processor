`timescale 1ns/1ps
module imm_gen(
    input [31:0] inst,                   //instruction given
    input [2:0] imm_sel,                 //select which type of instruction
    output reg [31:0] imm_out            //extimm output extended immediate
);

always @(*) begin
    case (imm_sel)
        3'b000 : begin  //I-type instruction
            imm_out = {{20{inst[31]}},{inst[31:20]}};
        end
        3'b001 : begin  //S-type instruction
            imm_out = {{20{inst[31]}}, inst[31:25], inst[11:7]};
        end
        3'b010 : begin  //B-type instruction
            imm_out = {{20{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        end
        3'b011 : begin  //U-type instruction
            imm_out = {inst[31:12], 12'b0};
        end
        3'b100 : begin 
            imm_out = {{12{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
        end
        default : imm_out = 32'b0;
    endcase
end
endmodule