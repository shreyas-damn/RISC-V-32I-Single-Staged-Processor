`timescale 1ns/1ps
module dff(
    input din, clk,
    output reg q, 
    output qbar
);
always @(posedge clk) begin
    if (din == 1) begin
        q <= 1; 
    end
    else begin
        q <= 0;
    end
end
    assign qbar = ~q;
endmodule