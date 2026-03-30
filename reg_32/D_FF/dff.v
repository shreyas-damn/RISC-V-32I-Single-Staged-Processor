`timescale 1ns/1ps
module dff(
    input [31:0] din, 
    input clk, we, rst,
    output reg [31:0] q, 
    output [32:0] qbar
);
always @(posedge clk) begin
    if (rst) begin
        q <= 32'b0;
    end
    else if (we) begin
        q <= din; 
    end

end
    assign qbar = ~q;
endmodule   