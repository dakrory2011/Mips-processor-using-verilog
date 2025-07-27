`timescale 1ns / 1ps


module prog_counter
    (
    input clk,
    input reset,
    input [31:0] pc_in,
    output reg [31:0] pc_out
    );
     always@(posedge clk )
     begin
     if(reset)
     pc_out<=32'h00000000;
     else
     pc_out<=pc_in;
     end
    
endmodule

