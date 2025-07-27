`timescale 1ns / 1ps

module sign_extend
    (
    input [15:0] instruction,
    output reg [31:0] extended_instruction
    );
    always@(*)
    begin
    if(instruction[15] ==1)
    extended_instruction ={16'hff,instruction};
    else
    extended_instruction ={16'h00,instruction};
    end
endmodule
