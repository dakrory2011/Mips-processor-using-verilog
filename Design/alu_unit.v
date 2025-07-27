`timescale 1ns / 1ps

module alu_unit (
    input [31:0] input1, input2,
    input [3:0] control_lines,
    output reg [31:0] result,
    output reg zero_flag
);

always @(*) begin
    case (control_lines)
        4'b0000: result = input1 & input2;                    // AND
        4'b0001: result = input1 | input2;                    // OR
        4'b0010: result = input1 + input2;                    // ADD
        4'b0110: result = input1 - input2;                    // SUB
        4'b0111: result = (input1 < input2) ? 32'd1 : 32'd0;  // SLT
        4'b1100: result = ~(input1 | input2);                 // NOR
        4'b1000: result = input2 << input1[4:0];              // SLL
        default: result = 32'd0;
    endcase

    // Update zero_flag for all operations
    zero_flag = (result == 32'd0) ? 1'b1 : 1'b0;
end

endmodule
