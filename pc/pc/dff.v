`timescale 1ns/1ps
module dff(
    input [31:0] dff_in, 
    input clk, we, rst,
    output reg [31:0] q, 
    output [31:0] qbar
);
always @(posedge clk) begin
    if (rst) begin
        q <= 32'b0;
    end
    else if (we) begin
        q <= dff_in; 
    end

end
    assign qbar = ~q;
endmodule   