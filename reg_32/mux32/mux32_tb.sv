`timescale 1ns/1ps
module mux32_tb();
reg [31:0][31:0]din_tb;
reg [4:0]sel_tb;
wire [31:0]dout_tb;

mux32 uut(
    .din(din_tb),
    .sel(sel_tb),
    .dout(dout_tb)
);

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,mux32_tb);
    $monitor("Time = %t | reg = %d | value = %d", $time, sel_tb, dout_tb);
    for (integer i = 0; i < 32; i = i + 1) begin
        din_tb[i] = i + 1;
        sel_tb = i;
        #10;
    end
end
endmodule