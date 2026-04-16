`timescale 1ns/1ps
module pc_mux_tb();
reg [31:0] pc_next_tb;
reg [31:0] pc_target_tb;
reg pc_src_tb;
wire [31:0] mux_out_tb;

pc_mux UUT (
    .pc_next(pc_next_tb),
    .pc_target(pc_target_tb),
    .pc_src(pc_src_tb),
    .pc_mux_out(mux_out_tb)
);

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,pc_mux_tb);
    $monitor("Time = %t | pc_src = %b | Pc_next = %b | pc_target = %b | Mux_out = %b", $time, pc_src_tb, pc_next_tb, pc_target_tb, mux_out_tb);
    //test 1
    pc_src_tb = 1'b0;
    pc_next_tb = 32'h00000004;
    pc_target_tb = 32'h000000A0;
    #10;
    //test 2
    pc_src_tb = 1'b1;
    #10;
    //test 3
    pc_target_tb = 32'hFFFFFFFC; 
    #10;
    //test 4
    pc_src_tb = 1'b0;
    pc_next_tb = 32'h00000008;
    #10;
    $finish;
end
endmodule