`timescale 1ns/1ps
module regfile_tb();

    // Testbench signals
    logic [31:0] wd;
    logic clk, we, rst;
    logic [4:0] rd;
    logic [31:0][31:0] dout;
    logic [31:0] dout_mon;

    // Read monitor: updates after posedge, matches regfile timing
    always @(posedge clk) begin
        dout_mon <= dout[rd];
    end

    // Instantiate regfile
    regfile UUT(
        .wd(wd),
        .clk(clk),
        .we(we),
        .rst(rst),
        .rd(rd),
        .dout(dout)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns period

    initial begin
        // VCD dump for waveform viewing
        $dumpfile("sim.vcd");
        $dumpvars(0, regfile_tb);

        // Initialize signals
        rst = 1;
        we = 0;
        wd = 0;
        rd = 0;
        #10;

        // Release reset
        rst = 0;

        // Random writes to registers
        for (integer i = 0; i < 10; i = i + 1) begin
            wd = $urandom();
            rd = $urandom_range(1,31);  // skip x0, always 0 in RISC-V
            we = 1'b1;

            @(posedge clk);   // WRITE happens here
            we = 1'b0;        // Disable write after one clock

            @(posedge clk);   // READ happens here
            $display("Cycle %0d | Written %d to x%0d | Read back %d", i, wd, rd, dout[rd]);
        end

        // Optional: final dump of all registers
        $display("\nFinal Register Values:");
        for (integer j = 0; j < 32; j = j + 1) begin
            $display("x%0d = %d", j, dout[j]);
        end

        $finish;
    end
endmodule