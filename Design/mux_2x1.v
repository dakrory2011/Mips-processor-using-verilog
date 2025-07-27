`timescale 1ns / 1ps



module mux_2x1
    (
input [31:0] input1,input2,
input sel,
output [31:0] out
    );
    assign out = sel ? input2:input1;
endmodule
