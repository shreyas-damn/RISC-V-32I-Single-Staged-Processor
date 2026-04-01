`timescale 1ns/1ps
module regfile(
    input logic [31:0] wd,                 
    input clk, we, rst,                     
    input logic[4:0] rs1, rs2, rd,   
    output logic[31:0] rd1, rd2                     
);
logic [31:0][31:0] dout;
logic [31:0] dec_out;            //decoder_output

mux32 mux1(
    .mux_in(dout),
    .sel(rs1),
    .mux_out(rd1)
);

mux32 mux2(
    .mux_in(dout),
    .sel(rs2),
    .mux_out(rd2)
);

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