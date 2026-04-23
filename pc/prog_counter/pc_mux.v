`timescale 1ns/1ps
module pc_mux(
    input [31:0] pc_next,
    input [31:0] pc_target,
    input [31:0] jalr_target, //rs1+imm
    input [1:0] pc_sel,
    output reg [31:0] pc_mux_out
);
always @(*) begin
    case(pc_sel) 
        2'b00: pc_mux_out = pc_next;
        2'b01: pc_mux_out = pc_target;
        2'b10: pc_mux_out = pc_target;
        2'b11: pc_mux_out = jalr_target;
        default: pc_mux_out = pc_next;
    endcase
end
endmodule