`timescale 1ns / 1ps

module registers (
    input clk,
    input reset,
    input regwrite,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    reg [31:0] registers [0:31];

    
    assign read_data1 = (read_reg1 != 0) ? registers[read_reg1] : 32'b0;
    assign read_data2 = (read_reg2 != 0) ? registers[read_reg2] : 32'b0;

    integer i;

    always @(posedge clk) begin
        registers[0] = 32'b0; 
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                    registers[i] <= 32'b0;
            end
        end else if (regwrite && (write_reg != 0)) begin
            registers[write_reg] <= write_data;
        end
    end

endmodule
