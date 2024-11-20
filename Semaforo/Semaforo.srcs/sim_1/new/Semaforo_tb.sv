`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 02:37:20 PM
// Design Name: 
// Module Name: Semaforo_tb
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


module Semaforo_tb;

    // Señales del DUT
    logic clk;
    logic rst_n;
    logic maintenance_button;
    logic [15:0] red_time;
    logic [15:0] yellow_time;
    logic [15:0] green_time;
    logic red;
    logic yellow;
    logic green;

    // Instancia del DUT
    Semaforo dut (
        .clk(clk),
        .rst_n(rst_n),
        .maintenance_button(maintenance_button),
        .red_time(red_time),
        .yellow_time(yellow_time),
        .green_time(green_time),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Generación del reloj
    always #5 clk = ~clk;

    // Proceso de inicialización y pruebas
    initial begin
        // Inicializar señales
        clk = 0;
        rst_n = 0;
        maintenance_button = 0;
        red_time = 16'd10;   
        yellow_time = 16'd3; 
        green_time = 16'd8;   

        
        #10 rst_n = 1;

        // Probar transiciones normales
        $display("Inicio de prueba: transición de estados normales.");
        wait (red);  
        $display("[%0t] Estado: Rojo", $time);

        wait (green);  
        $display("[%0t] Estado: Verde", $time);

        wait (yellow);  
        $display("[%0t] Estado: Amarillo", $time);

        // Probar modo de mantenimiento
        $display("Inicio de prueba: activación del modo de mantenimiento.");
        maintenance_button = 1;
        #10 maintenance_button = 0;  
        wait (!red && !yellow && !green);
        #10
        $display("[%0t] Estado: Mantenimiento activado", $time);

        // Salir del modo de mantenimiento
        $display("Saliendo del modo de mantenimiento.");
        maintenance_button = 1;
        #10 maintenance_button = 0;  
        wait (red);  
        $display("[%0t] Salió del mantenimiento y regresó a Rojo", $time);

        
        $stop;
    end

endmodule





