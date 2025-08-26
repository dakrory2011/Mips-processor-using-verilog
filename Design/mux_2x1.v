`timescale 1ns / 1ps



module mux_2x1 #(parameter BITS =32)
    (
        input [BITS-1:0] input1,input2,
input sel,
        output [BITS-1:0] out
    );
    assign out = sel ? input2:input1;
endmodule
