`timescale 1ns/1ps
module reg_file(
    input logic clk,
    input logic rst,
    input logic w_en,           //write enable
    input logic [4:0] rs1,      //first input register
    input logic [4:0] rs2,      //second input register 
    input logic [4:0] rd,       //destination register
    input logic [31:0] wr_d,     //write date
    output logic [31:0] rd1,    //output 32 bit     (can read upto 2 registers at a time)
    output logic [31:0] rd2     //output 32 bit
);

logic [31:0] regs [31:0];


assign rd1 = (rs1 == 0) ? 32'b0 : regs[rs1];     //if rs1 value is 0 then return 0 else return reg[rs1]
assign rd2 = (rs2 == 0) ? 32'b0 : regs[rs2];     //if rs2 value is 0 then return 0 else return reg[rs2]

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin                                      //if rst is on, every register is made to 32'b0 value
        integer  i;
        for (i = 0 ; i < 32 ; i = i + 1) begin
            regs[i] = 32'b0;
        end
    end
    else if (w_en && (rd != 0)) begin   //else if write enable is on and destination register address is not 0, destination register is written
        regs[rd] <= wr_d;
    end
end
endmodule
