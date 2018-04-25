`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2018 07:13:08 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input rst_n
    );
    reg [31:0] PC;
    wire [31:0] next_PC;
    wire [31:0]instr;
    /* wire for control */
    /* output from control */
    wire MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite;
    wire [4:0] ALUControl;
    /* input to control */
    wire [31:26] Op;
    wire [5:0] Funct;
    wire [31:0]ALU_result;
    wire [31:0]sig_imm;

    /* input to REG_FILE */
    wire [31:0]read_data1;
    wire [31:0]read_data2;
    wire [31:0]write_reg_addr;
    wire [31:0]write_reg_data;
    
    /* input to data_mem */
    wire [7:0] mem_addr;
    wire [31:0] mem_write_data;
    wire [31:0]alu_b;
    wire [31:0]mem_read_data;
    assign sig_imm = (instr[15])? (16'b1111_1111_1111_1111+ instr[15:0]) : (16'b0000_0000_0000_0000+ instr[15:0]);
    assign next_PC = PC + 1;

    ins_mem u_ins_mem (
      .a(PC[5:0]),      // input wire [5 : 0] a
      //.d(d),      // input wire [31 : 0] d
      //.clk(clk),  // input wire clk
      //.we(),    // input wire we
      .spo(instr)  // output wire [31 : 0] spo
    );

    data_mem u_data_mem (
      .a(ALU_result),        // input wire [7 : 0] a
      .d(mem_write_data),        // input wire [31 : 0] d
      .dpra(ALU_result),  // input wire [7 : 0] dpra
      .clk(clk),    // input wire clk
      .we(MemWrite),      // input wire we
      .dpo(mem_read_data)    // output wire [31 : 0] dpo
    );

    /*  */
    always @(posedge clk or negedge rst_n)
    begin
      //PC <= new_PC;
      if (~ rst_n) begin
        PC <= 32'd0;

      end else begin
        PC <= next_PC;
      end
    end


    assign write_reg_addr = RegDst ? instr[15:11] : instr[20:16];
    
    REG_FILE u_REG_FILE(
      .clk(clk),
      .rst_n(rst_n),
      .rAddr1(1'b0 + instr[25:21]),//[5:0]
      .rAddr2(1'b0 + instr[20:16]),//[5:0]      
      .rDout1(read_data1),//[31:0]
      .rDout2(read_data2),//[31:0]      
      .wAddr(write_reg_addr),//[5:0]
      .wDin(write_reg_data),//[31:0]
      .wEna(RegWrite)
    );
    assign write_reg_data = (MemtoReg) ? mem_read_data : ALU_result;
    assign alu_b = (ALUSrc)? sig_imm : read_data2;
    ALU u_ALU(
      .alu_a(read_data1),
      .alu_b(alu_b),
      .alu_op(6'b000001),
      .alu_out(ALU_result)
    );


    control u_control(
    .Op(instr[31:26]),//input [31:26] Op,
    .Funct(instr[5:0]),//input [5:0] Funct,
    .MemtoReg(MemtoReg),//output reg MemtoReg,// 1 to choose mem, 0 to choose ALUResult
    .MemWrite(MemWrite),//output reg MemWrite,// 1 to enwrite mem, 0 to not enwrite mem
    .Branch(Branch),//output reg Branch,// 
    .ALUControl(ALUControl),//output reg [4:0] ALUControl,
    .ALUSrc(ALUSrc),//output reg ALUSrc, // 1 to immediate, 0 to read_data2
    .RegDst(RegDst),//output reg RegDst,// 1 to 15:11, 0 to 20:16
    .RegWrite(RegWrite)//output reg RegWrite
    );
endmodule
