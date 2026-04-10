`timescale 1ns/1ps

module pc_plus4_tb;

reg [31:0] pc;
wire [31:0] pc_plus4;

pc_plus4 dut (
    .pc(pc),
    .pc_plus4(pc_plus4)
);

initial begin
    $monitor("Time=%0t | PC=%h | PC+4=%h", $time, pc, pc_plus4);
    pc = 32'd0;#5;
    pc = 32'd4;#5;
    pc = 32'd10;#5;
    pc = 32'd100;#5;
    pc = 32'hFFFF_FFFC; #5;
$finish;
end
endmodule