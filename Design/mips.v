`timescale 1ns / 1ps



module mips(
input clk,
input reset

    );
    wire [31:0] pc_to_instruction, pc_after_Add , instruction_out;
    wire regdst,branch,memread,memtoreg,memwrite,alusrc,regwrite,jump;
    wire [1:0] aluop;
    wire[4:0] write_register;
    wire [3:0] alu_control_lines;
    wire [31:0] read_data1 , read_data2;
    wire [31:0] alu_input2;
    wire [31:0] alu_result;
    wire zero_flag;
    wire [31:0] read_data_memory;
    wire [31:0] write_data;
    wire branch_enable= branch & zero_flag;
    wire [31:0] pc_input;
    wire [31:0] sign_extend_out;
    wire [31:0] shifted_signextend;
    wire [31:0] adder_out;
    wire [27:0] shifted_inst;
    wire [31:0] mux4_out;
   
    
    // program counter
 
    prog_counter pc
    (
    .clk(clk),
    .reset(reset),
    .pc_in(pc_input),
    .pc_out(pc_to_instruction)
     );
     // instruction memory
     Instruction_Memory  Instruction_Memory 
     (
     .clk(clk),
     .reset(reset),
     .read_address(pc_to_instruction),
     .instruction_out(instruction_out)
     );
     // pc after add
     pc_adder pc_adder0
     (
     .frompc(pc_to_instruction),
     .topc(pc_after_Add)
     );
     
     // registers
     registers Registers
     (
     .clk(clk),
     .reset(reset),
     .regwrite(regwrite),
     .read_reg1(instruction_out[25:21]),
     .read_reg2(instruction_out[20:16]),
     .write_reg(write_register),
     .read_data1(read_data1),
     .read_data2(read_data2),
     .write_data(write_data)
     );
     
     
     
     sign_extend signextend
     (
     .instruction(instruction_out[15:0]),
     .extended_instruction(sign_extend_out)
     
     );
     
     control_unit Control
     (
     .instruction(instruction_out[31:26]),
     .regdst(regdst),
     .branch(branch),
     .memread(memread),
     .memtoreg(memtoreg),
     .memwrite(memwrite),
     .alusrc(alusrc),
     .regwrite(regwrite),
     .aluop(aluop),
     .jump(jump)
     );
     
     
    mux_2x1 #(.BITS(5)) mux1
     (
     .input1(instruction_out[20:16]),
     .input2(instruction_out[15:11]),
     .sel(regdst),
     .out(write_register)
     );
     
     
     alu_control alu_contr
     (
     .funct(instruction_out[5:0]),
     .aluop(aluop),
     .control_lines(alu_control_lines)
     
     );
     
     alu_unit alu
     (
     .input1(read_data1),
     .input2(alu_input2),
     .control_lines(alu_control_lines),
     .result(alu_result),
     .zero_flag(zero_flag)
     );
     
     Data_Memory datamem
     (
     .clk(clk),
     .reset(reset),
     .mem_write(memwrite),
     .mem_read(memread),
     .address(alu_result),
     .write_data(read_data2),
     .data_read(read_data_memory)
     );
    
    mux_2x1 mux2
    (
    .input1(read_data2),
    .input2(sign_extend_out),
    .sel(alusrc),
    .out(alu_input2)
    );
    
    mux_2x1 mux3
    (
    .input1(alu_result),   
    .input2(read_data_memory),  
    .sel(memtoreg),
    .out(write_data)
    );
     
     
     shifter shift
     (
     .in(sign_extend_out),
     .out(shifted_signextend)
     );
     adder add
     (
     .input1(pc_after_Add),
     .input2(shifted_signextend),
     .out(adder_out)
     );
     
     mux_2x1    mux4
     (
     .input1(pc_after_Add),
     .input2(adder_out),
     .sel(branch_enable),
     .out(mux4_out)
     );
     
     shifter_jump sh_jump
     (
     .inst(instruction_out[25:0]),
     .out(shifted_inst)
     );
     mux_2x1 mux5
     (
     .input1(mux4_out),
     .input2({pc_after_Add[31:28],shifted_inst}),
     .sel(jump),
     .out(pc_input)
     );
     
     
    
endmodule
