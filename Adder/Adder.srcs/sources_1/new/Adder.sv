`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 12:17:30 AM
// Design Name: 
// Module Name: Adder
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


/* module Adder #(parameter WIDTH = 8)(
    output [(WIDTH - 1): 0] result,
    input [(WIDTH - 1): 0] a,
    input [(WIDTH - 1): 0] b
);
 
assign result = a + b;
 
endmodule */


module Adder #(parameter WIDTH = 4)(
    output [(WIDTH - 1): 0] result,
    output carry_out,
    input [(WIDTH - 1): 0] a,
    input [(WIDTH - 1): 0] b
);
 
assign {carry_out, result} = a + b;
 
endmodule

