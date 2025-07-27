`timescale 1ns / 1ps

module control_unit(
    input [5:0] instruction,  // opcode
    output reg regdst,
    output reg branch,
    output reg memread,
    output reg memtoreg,
    output reg memwrite,
    output reg alusrc,
    output reg regwrite,
    output reg jump,
    output reg [1:0] aluop
);

always @(*) begin
    // Default control signals
    regdst   = 0;
    branch   = 0;
    memread  = 0;
    memtoreg = 0;
    memwrite = 0;
    alusrc   = 0;
    regwrite = 0;
    jump     = 0;
    aluop    = 2'b00;

    case (instruction)
        6'b000000: begin  // R-type
            regdst   = 1;
            regwrite = 1;
            aluop    = 2'b10;
        end

        6'b100011: begin  // lw
            regdst   = 0;
            regwrite = 1;
            aluop    = 2'b00;
            memread  = 1;
            memtoreg = 1;
            alusrc   = 1;
        end

        6'b101011: begin  // sw
            regwrite = 0;
            aluop    = 2'b00;
            memwrite = 1;
            alusrc   = 1;
        end

        6'b000100: begin  // beq
            aluop    = 2'b01;
            branch   = 1;
        end

        6'b000101: begin  // bne
            aluop    = 2'b01;
            branch   = 1;
        end

        6'b001000: begin  // addi
            regdst   = 0;
            regwrite = 1;
            aluop    = 2'b00;
            alusrc   = 1;
            memtoreg = 0;
        end

        6'b001100: begin  // andi
            regdst   = 0;
            regwrite = 1;
            aluop    = 2'b11;
            alusrc   = 1;
        end

        6'b001101: begin  // ori
            regdst   = 0;
            regwrite = 1;
            aluop    = 2'b11;
            alusrc   = 1;
        end

        6'b001111: begin  // lui
            regdst   = 0;
            regwrite = 1;
            aluop    = 2'b11;
            alusrc   = 1;
        end

        6'b000010: begin  // j (jump)
            jump = 1;
        end

        6'b000011: begin  // jal (jump and link)
            jump     = 1;
            regwrite = 1;     // Write PC+4 to $ra (register 31)
            regdst   = 0;     // Up to datapath to override with reg 31
            memtoreg = 0;     // Write PC+4, not memory
        end

        default: begin
            // Keep default values
        end
    endcase
end

endmodule
