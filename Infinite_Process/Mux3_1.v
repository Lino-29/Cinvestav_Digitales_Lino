`timescale 1ns/1ps

module mux_testbench;

    reg clk;
    reg [1:0] sel;        
    reg in0, in1, in2;    
    reg [3:0] counter;    

    wire mux_out;        

    mux3_1 uut (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .sel(sel),
        .out(mux_out)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    // Proceso de estímulo para in0
    always @(posedge clk) begin
        in0 <= $random;  
    end

    // Proceso de estímulo para in1
    always @(posedge clk) begin
        in1 <= $random;  
    end

    // Proceso de estímulo para in2
    always @(posedge clk) begin
        in2 <= $random; 
    end

    // Proceso de selección y conteo de flancos
    always @(posedge clk) begin
        sel <= sel + 1;     
        counter <= counter + 1;
        
        if (counter == 10) begin
            $display("Simulación detenida después de 10 flancos de reloj.");
            $stop;
        end
    end

    initial begin
        // Inicialización de señales
        sel = 0;
        counter = 0;
        in0 = 0;
        in1 = 0;
        in2 = 0;
    end

endmodule

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