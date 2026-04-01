`timescale 1ns/1ps
module mux32(
    input [31:0][31:0]mux_in, //our mux needs to take 32 bit inputs from 32 registers
    input [4:0]sel,
    output reg [31:0]mux_out
);
always @(*) begin
    mux_out = mux_in[sel];
end
endmodule
