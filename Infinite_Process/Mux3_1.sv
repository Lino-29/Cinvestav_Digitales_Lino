module Mux3_1 (
    input wire in0,
    input wire in1,
    input wire in2,
    input wire [1:0] sel,
    output wire out
);
    assign out = (sel == 2'b00) ? in0 :
                 (sel == 2'b01) ? in1 :
                 (sel == 2'b10) ? in2 : 1'bx;
endmodule


