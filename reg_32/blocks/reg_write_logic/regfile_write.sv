`timescale 1ns/1ps
module regfile(
    input logic [31:0] wd,                  //the write_data accepts 32 bit input
    input clk, we, rst,                     //1 bit clk we and rst
    input [4:0] rd,                         //destination register address
    output logic [31:0][31:0]dout           //output retrieves 32 outputs 32 bit wide
);

logic [31:0] dec_out;            //decoder_output

dec5_31 decoder(                //instantiate decoder
    .dec_in(rd),                //decoder takes destination address
    .addr(dec_out)              //destination address converted to 32 bit
);

genvar i;                                               
generate                                                //generate used for making 32 reg array
    for (i = 0; i < 32; i = i + 1) begin: pipo          //loop begins
        dff dff_inst(                                   //instantiate dff or reg
            .clk(clk),                                  //common clk
            .dff_in(wd),                                //write_data connected to every register
            .rst(rst),                                  //common reset 
            .we((i == 0) ? 1'b0 : (dec_out[i] & we)),     //writes data only if i is not 0, we is [1] and decoder's address is matched
            .q(dout[i])                              //common d_out
        );
    end
endgenerate 
endmodule