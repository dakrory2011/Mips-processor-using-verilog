`timescale 1ns / 1ps

module Instruction_Memory
(
input clk,
input reset,
input [31:0] read_address,
output reg [31:0] instruction_out
);
reg [31:0]instruction_memory [0:1023];




initial begin
        $readmemh("instructions.mem", instruction_memory);
    end
always @(*) begin
     instruction_out = instruction_memory[read_address[11:2]];
    end
endmodule