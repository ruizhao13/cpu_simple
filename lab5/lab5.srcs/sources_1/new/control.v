`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2018 07:28:55 PM
// Design Name: 
// Module Name: control
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


module control(
    input [31:26] Op,
    input [5:0] Funct,
    output reg MemtoReg,// 1 to choose mem, 0 to choose ALUResult
    output reg MemWrite,// 1 to enwrite mem, 0 to not enwrite mem
    output reg Branch,// 
    output reg [4:0] ALUControl,
    output reg ALUSrc, // 1 to immediate, 0 to read_data2
    output reg RegDst,// 1 to 15:11, 0 to 20:16
    output reg RegWrite
    );
    parameter	A_NOP	= 5'h00;	 	
    parameter    A_ADD    = 5'h01;    
    parameter    A_SUB    = 5'h02;    
    parameter    A_AND     = 5'h03;
    parameter    A_OR      = 5'h04;
    parameter    A_XOR     = 5'h05;
    parameter    A_NOR   = 5'h06;
    parameter	LW	= 35;
    parameter	SW	= 43;	
    //parameter	LW	= 35;	
    //parameter	LW	= 35;	
    	
    always @ (*)
    begin
      case (Op)
        LW: 
            begin
              MemtoReg <= 1'b1;
              MemWrite <= 1'b0;
              Branch <= 0;
              ALUControl <= A_ADD;
              ALUSrc <= 1;
              RegDst <= 0;
              RegWrite <= 1;
            end
    
        default: ;
      endcase
    end



endmodule
