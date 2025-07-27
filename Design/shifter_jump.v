`timescale 1ns / 1ps

module shifter_jump(
input [25:0] inst,
output [27:0] out

    );
    assign out = {inst,2'b00};
endmodule
