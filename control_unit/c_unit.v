`timescale 1ns/1ps
module cntrl_unit(
    input [31:0] instr,
    input zero,
    input rst,
    input clk,
    output reg [3:0] alu_ctrl,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg [1:0] pc_sel,
    output reg [1:0] wb_sel,
    output reg [2:0] imm_sel
);

wire [6:0] opcode;
wire [2:0] funct3 = instr[14:12];
wire [6:0] funct7 = instr[31:25];
assign opcode = instr[6:0];

always @(*) begin
    alu_ctrl = 4'b0000;
    reg_write = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    alu_src = 1'b0;
    wb_sel = 2'b00;
    imm_sel = 3'b000;
    pc_sel = 2'b00;
    case(opcode)
        //R-TYPE INSTRUCTIONS
        7'b0110011: begin
            reg_write = 1'b1;   //writing result to register
            alu_src = 1'b0;     //using rs2 value
            wb_sel = 2'b00;     //written back
            case({funct7,funct3})
                10'b0000000_000: alu_ctrl = 4'b0000;    //addition
                10'b0100000_000: alu_ctrl = 4'b0001;    //subtraction
                10'b0000000_001: alu_ctrl = 4'b0101;    //logical left shift
                10'b0000000_010: alu_ctrl = 4'b0110;    //set less than (signed)
                10'b0000000_011: alu_ctrl = 4'b0111;    //set less than (unsigned)
                10'b0000000_100: alu_ctrl = 4'b0100;    //xor
                10'b0000000_101: alu_ctrl = 4'b1000;    //logical right shift
                10'b0100000_101: alu_ctrl = 4'b1001;    //arithmatic right shift
                10'b0000000_110: alu_ctrl = 4'b0011;    //logical or
                10'b0000000_111: alu_ctrl = 4'b0010;    //logical and
                default: alu_ctrl = 4'b0000;            //default case addition
            endcase
        end
        
        //I-TYPE INSTRUCTIONS
        7'b0010011: begin
            reg_write = 1'b1;       //writing result to register
            alu_src = 1'b1;         //using rs1 value
            wb_sel = 2'b00;         //written back
            imm_sel = 3'b000;

            case(funct3)
                3'b000: alu_ctrl = 4'b0000; //addi
                3'b111: alu_ctrl = 4'b0010; //andi
                3'b110: alu_ctrl = 4'b0011; //ori
                3'b100: alu_ctrl = 4'b0100; //xori
                3'b001: alu_ctrl = 4'b0101; //shift left by immediate
                3'b101: alu_ctrl = (instr[30]) ? 4'b1001 : 4'b1000; //shift right arithmetic / logical by immediate
                default: alu_ctrl = 4'b0000;
            endcase
        end

        //S-TYPE INSTRUCTIONS
        //LOAD-WORD (lw)
        7'b0000011: begin
            reg_write = 1'b1;   //saving to register
            mem_read = 1'b1;    //writing to memory
            alu_src = 1'b1;     //alu looks for immediate
            wb_sel = 2'b01;     //writing bag
            imm_sel = 3'b000;   //I type immediate
            alu_ctrl = 4'b0000; //adding operation
        end
        //STORE-WORD (sw)
        7'b0100011: begin
            reg_write = 0;
            mem_read  = 0;
            mem_write = 1;          //writing to memory
            alu_src   = 1;          //using rs2
            imm_sel   = 3'b001;     //S-type instructions
            alu_ctrl  = 4'b0000;    //alu performs addition
        end

        //B-TYPE INSTRUCTIONS   
        7'b1100011: begin
            reg_write = 0;
            mem_read  = 0;
            mem_write = 0;
            alu_src = 1'b0;         //uses imm_value (offset)
            imm_sel = 3'b010;       //B-type instructions
            alu_ctrl = 4'b0001;     //alu performs sub
            case(funct3)
                3'b000: pc_sel = zero ? 2'b01 : 2'b00;     //branch if equal
                3'b001: pc_sel = (!zero) ? 2'b01 : 2'b00;     //branch if not equal
                default: pc_sel = 2'b00;    //default value is set to subraction
            endcase
        end

        //U-TYPE INSTRUCTIONS
        //Load Upper Immediate
        7'b0110111: begin
            reg_write = 1'b1;
            alu_src = 1'b0;
            wb_sel = 2'b11;
            imm_sel = 3'b011;
            alu_ctrl = 4'b0000;
        end
        //Add Upper Immediate to PC
        7'b0010111: begin
            reg_write = 1'b1;  
            alu_src   = 1'b1;  
            wb_sel    = 2'b00; 
            imm_sel   = 3'b011;
            alu_ctrl  = 4'b0000;
        end

        7'b1101111: begin
            mem_read  = 1'b0;
            mem_write = 1'b0; 
            reg_write = 1'b1;  
            pc_sel = 2'b10; 
            wb_sel    = 2'b10;  
            imm_sel   = 3'b100; 
            alu_src   = 1'b0;   
            alu_ctrl = 4'b0000;
        end


        7'b1100111: begin       //JALR
            reg_write = 1'b1;
            wb_sel = 2'b10;
            imm_sel = 3'b000;
            pc_sel = 2'b11;
            alu_src = 1'b1;
            alu_ctrl = 4'b0000;
        end
    endcase
end
endmodule