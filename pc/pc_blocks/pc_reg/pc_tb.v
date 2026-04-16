`timescale 1ns/1ps

module pc_tb;
reg clk;
reg rst;
reg [31:0] pc_next;
wire [31:0] pc;

    pc dut (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars(0,pc_tb);
        clk = 0;
        rst = 1;
        pc_next = 32'b0;
        $monitor("Time=%0t pc=%h", $time, pc);
        #12;
        rst = 0;
        pc_next = 32'h0000_0004;
        #10;
        pc_next = 32'h0000_0008;
        #10;
        pc_next = 32'h0000_000C;
        #10;
        pc_next = 32'h0000_0100;
        #10;
        $finish;
    end

endmodule