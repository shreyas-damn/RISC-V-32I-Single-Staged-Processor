`timescale 1ns/1ps
module dec5_31(
    input [4:0] dec_in,
    output [31:0] addr
);
/*always @(*) begin
    addr = 32'b0
    addr[din] = 1'b1
end*/

assign addr = (1 << dec_in); // shifts '1' to the left by din positions
endmodule