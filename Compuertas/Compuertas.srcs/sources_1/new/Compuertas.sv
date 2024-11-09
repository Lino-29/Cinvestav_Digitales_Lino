`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 01:48:52 AM
// Design Name: 
// Module Name: Compuertas
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


module Compuertas#(parameter WIDTH = 4)(
  input reg [WIDTH-1:0] a, b,
  output reg [WIDTH-1:0] bitwise_and,
  output reg [WIDTH-1:0] bitwise_or,
  output reg [WIDTH-1:0] bitwise_xor
);
    assign  bitwise_and=a&b;
    assign  bitwise_or = a|b;
    assign  bitwise_xor = a^b; 
endmodule
