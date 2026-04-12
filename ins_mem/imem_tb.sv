`timescale 1ns/1ps 
module imem_tb();
logic [31:0] addr;
logic [31:0] instr;

imem UUT(
    .addr(addr),
    .instr(instr)
);

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,imem_tb);
    $monitor("Time = %t | addr = %h | instr = %h", $time, addr, instr);
    addr = 32'h0;
    #10 addr = 32'h0;   // Should show mem[0]
    #10 addr = 32'h4;   // Should show mem[1]
    #10 addr = 32'h8;   // Should show mem[2]
    #10 addr = 32'hC;   // Should show mem[3]
    #10 addr = 32'h10;  // Should show mem[4]
end
endmodule