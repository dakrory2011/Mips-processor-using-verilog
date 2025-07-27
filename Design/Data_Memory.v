`timescale 1ns / 1ps


module Data_Memory
    (
    input clk,reset,
    input mem_write,mem_read,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] data_read
    );
    reg [31:0] d_memory [0:1023];
    integer i;
    always@(posedge clk , posedge reset)
    begin
        if(reset)
        for (i=0;i<1024;i=i+1)
        begin
            d_memory[i]<=0;
        end
    else if(mem_write)
    begin
    d_memory[address]<= write_data;
    end
    end
    
    assign data_read = mem_read? d_memory[address] : 32'h00000000;
    
endmodule
