`timescale 1ns/1ps
module regfile_tb();
    reg clk_tb;
    reg we_tb;
    reg rst_tb;
    reg [4:0] rs1_tb, rs2_tb, rd_tb;
    reg [31:0] wd_tb;
    wire [31:0] rd1_tb, rd2_tb;
    wire [31:0][31:0] dout_tb;

    regfile uut (
        .wd(wd_tb),
        .clk(clk_tb),
        .we(we_tb),
        .rst(rst_tb),
        .rs1(rs1_tb),
        .rs2(rs2_tb),
        .rd(rd_tb),
        .rd1(rd1_tb),
        .rd2(rd2_tb)
    );

    initial clk_tb = 0;
    always #5 clk_tb = ~clk_tb; // 10ns period

    initial begin
        rst_tb = 1; we_tb = 0; rs1_tb = 0; rs2_tb = 0; rd_tb = 0; wd_tb = 0;
        #10;
        rst_tb = 0;
        #10;
        rd_tb = 5'd1;  // destination register = x1
        wd_tb = 32'hAAAA_AAAA; // data to write
        we_tb = 1;
        #10;
        we_tb = 0;
        #10;

        rd_tb = 5'd2;
        wd_tb = 32'h5555_5555;
        we_tb = 1;
        #10;
        we_tb = 0;
        #10;

        rs1_tb = 5'd1; // read x1
        rs2_tb = 5'd2; // read x2
        #10;

        $display("rd1 (x1) = %h, rd2 (x2) = %h", rd1_tb, rd2_tb);
        rs1_tb = 5'd0;
        #10;
        $display("rd1 (x0) = %h (should be 0)", rd1_tb);
        $finish;
    end
endmodule