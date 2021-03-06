`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 12:22:15 AM
// Design Name: 
// Module Name: test
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


module test();
    reg clk;
    reg rst_n;
    top test(.clk(clk), .rst_n(rst_n));
    always #10
     clk = ~clk;
    
    initial begin
      clk = 0;
      rst_n = 0;
      #100;
      rst_n = 1;
    end

endmodule
