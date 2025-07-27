`timescale 1ns / 1ps

module alu_control(
    input [1:0] aluop,
    input [5:0] funct,
    output reg [3:0] control_lines
);

always @(*) begin
    case (aluop)
        2'b00: control_lines = 4'b0010; // For LW/SW (ADD)
        2'b01: control_lines = 4'b0110; // For BEQ (SUB)
        2'b10: begin // R-type
            case (funct)
                6'b100000: control_lines = 4'b0010; // ADD
                6'b100010: control_lines = 4'b0110; // SUB
                6'b100100: control_lines = 4'b0000; // AND
                6'b100101: control_lines = 4'b0001; // OR
                6'b101010: control_lines = 4'b0111; // SLT
                6'b000000: control_lines = 4'b1000; // SLL (NOP or shift left logical)
                // You can add more funct codes here as needed
                default: control_lines = 4'b1111; // Invalid operation
            endcase
        end
        default: control_lines = 4'b1111; // Invalid ALUOp
    endcase
end

endmodule
