`timescale 1ns/1ps
module mux32(
    input [31:0][31:0]din, //our mux needs to take 32 bit inputs from 32 registers
    input [4:0]sel,
    output reg [31:0]dout
);
always @(*) begin
    dout = din[sel];
end
endmodule
