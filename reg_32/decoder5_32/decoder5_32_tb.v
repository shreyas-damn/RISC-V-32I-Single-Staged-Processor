`timescale 1ns/1ps
module dec5_32_tb();
reg [4:0] din_tb;
wire [31:0] addr_tb;
dec5_31 uut (
    .din(din_tb),
    .addr(addr_tb)
);
initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0, dec5_32_tb);
    $monitor("Time = %t | Din = %b | Addr = %b", $time, din_tb, addr_tb);
    for(integer i = 0; i < 32; i = i + 1) begin
        din_tb = i; #10;
    end
#1;
$finish;
end
endmodule