`timescale 1ns/1ps
module pc_reg(
    input clk,
    input rst,
    input [31:0] pc_next,
    output reg [31:0] pc_out
);
always @(posedge clk or posedge rst) begin
    if(rst)
        pc_out <= 32'h0000_0000;
    else
        pc_out <= pc_next;
end
endmodule