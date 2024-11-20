`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 02:36:46 PM
// Design Name: 
// Module Name: Semaforo
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

module Semaforo (
    input logic clk,                  
    input logic rst_n,                
    input logic maintenance_button,   // Botón para activar el modo de mantenimiento
    input logic [15:0] red_time,      // Duración del rojo, configurable post-síntesis
    input logic [15:0] yellow_time,   // Duración del amarillo, configurable post-síntesis
    input logic [15:0] green_time,    // Duración del verde, configurable post-síntesis
    output logic red,                 
    output logic yellow,              
    output logic green                
);

    //Configuración modos estado del Semáforo
    typedef enum logic [1:0] {
        RED = 2'b00,
        YELLOW = 2'b01,
        GREEN = 2'b10,
        MAINTENANCE = 2'b11
    } state_t;

    state_t current_state;
    logic in_maintenance;            
    logic [15:0] red_counter, yellow_counter, green_counter; 

    // Señales de habilitación para cada color
    logic red_enable, yellow_enable, green_enable;

    // manejar el estado y modo de mantenimiento
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= RED;
            in_maintenance <= 1'b0;
        end else begin
            if (maintenance_button) begin
                in_maintenance <= ~in_maintenance; 
                current_state <= in_maintenance ? RED : MAINTENANCE;
            end else if (!in_maintenance) begin
                //Sellecionar el estado actual
                case (current_state)
                    RED: if (red_counter == 16'd0) current_state <= GREEN;
                    GREEN: if (green_counter == 16'd0) current_state <= YELLOW;
                    YELLOW: if (yellow_counter == 16'd0) current_state <= RED;
                endcase
            end
        end
    end

    // Proceso para el color rojo
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            red_enable <= 1'b0;
            red_counter <= 16'd0;
        end else if (current_state == RED && !in_maintenance) begin
            red_enable <= 1'b1;
            if (red_counter > 16'd0)
                red_counter <= red_counter - 16'd1;
            else
                red_counter <= red_time; 
        end else begin
            red_enable <= 1'b0;
        end
    end

    // Proceso para el color verde
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            green_enable <= 1'b0;
            green_counter <= 16'd0;
        end else if (current_state == GREEN && !in_maintenance) begin
            green_enable <= 1'b1;
            if (green_counter > 16'd0)
                green_counter <= green_counter - 16'd1;
            else
                green_counter <= green_time; 
        end else begin
            green_enable <= 1'b0;
        end
    end

    // Proceso para el color amarillo
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            yellow_enable <= 1'b0;
            yellow_counter <= 16'd0;
        end else if (current_state == YELLOW && !in_maintenance) begin
            yellow_enable <= 1'b1;
            if (yellow_counter > 16'd0)
                yellow_counter <= yellow_counter - 16'd1;
            else
                yellow_counter <= yellow_time; 
        end else begin
            yellow_enable <= 1'b0;
        end
    end

    // salidas
    always @(*) begin
        if (in_maintenance) begin
            red = 1'b0;
            yellow = 1'b0;
            green = 1'b0;
        end else begin
            red = red_enable;
            yellow = yellow_enable;
            green = green_enable;
        end
    end

endmodule

