`timescale 1ns/1ps
module pc_mux(
    input [31:0] pc_next,
    input [31:0] pc_target,
    input pc_src,
    output reg [31:0] pc_mux_out
);
always @(*) begin
    case(pc_src)
        1'b0: pc_mux_out = pc_next;
        1'b1: pc_mux_out = pc_target;
        default: pc_mux_out = pc_next;
    endcase
end
endmodule