`timescale 1ns/1ps
module dec5_31(
    input [4:0] din,
    output [31:0] addr
);
/*always @(*) begin
    addr = 32'b0
    addr[din] = 1'b1
end*/

assign addr = (1 << din); // shifts '1' to the left by din positions
endmodule