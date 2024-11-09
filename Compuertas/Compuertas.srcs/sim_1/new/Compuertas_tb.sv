`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 01:49:26 AM
// Design Name: 
// Module Name: Compuertas_tb
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


// Code your design here
// 2 procesos que randomizen (std::randomize) las a y b respectivamente ( 5 ciclos )
// imprimiendo con otros procesos concurrentes a, b, (and) cada flanco de reloj en el siguiente orden (1- and, 2- b, 3- a) ( 5 ciclos )
 
module Compuertas_tb#(parameter WIDTH = 4);
 
	// Declaracion de variables //
  bit clk; 
  reg [WIDTH-1:0] a = 4'b0000;
  reg [WIDTH-1:0] b = 4'b0000;
  reg [WIDTH-1:0] bitwise_and;
  reg [WIDTH-1:0] bitwise_or;
  reg [WIDTH-1:0] bitwise_xor;
  integer i=0;
	event a_ev;
	event b_ev;
	event and_ev;
 
	initial begin 				 // Proceso 1
		forever begin 			 // Debe llevar el forever si no, solo se ejecuta una vez
			@(posedge clk); 	 // El @ es un operador para esperar un evento
			std::randomize(a); // Randomizamos a utilizando la libreria standard
			->a_ev; 					 // Triggers el evento por 1 timestep
		end
	end
 
	always begin 					 // Proceso 2
			@(posedge clk); 	 // El @ es un operador para esperar un evento
			std::randomize(b); // Randomizamos a utilizando la libreria standard
			->b_ev; 					 // Triggers el evento por 1 timestep
	end

  always begin 					               // Proceso 2
			@(posedge clk); 	               // El @ es un operador para esperar un evento
			std::randomize(bitwise_and);    // Randomizamos a utilizando la libreria standard
			->and_ev; 				              // Triggers el evento por 1 timestep
	end
 
	initial begin // Se ejecuta en t=0
 
		fork
 
			begin // Proceso 3
				repeat(5) begin
					@(posedge clk); 	 // El @ es un operador para esperar un evento
					wait(and_ev.triggered);
					// wait(b_ev.triggered);
					// wait(and_ev.triggered);
					$display("a: %b", a); // Tercero a ser visto
				end
			end
 
			begin // Proceso 4
				repeat(5) begin
					@(posedge clk); 	 // El @ es un operador para esperar un evento
					wait(b_ev.triggered);
					// wait(and_ev.triggered);
					$display("b: %b", b); // Segundo a ser visto
				end
			end
 
			begin // Proceso 5
				repeat(5) begin
					@(posedge clk); 	 // El @ es un operador para esperar un evento
					wait(a_ev.triggered);
					// wait(a_ev.triggered);
					// wait(b_ev.triggered);
					$display("and: %b", bitwise_and); // Primero a ser visto
				end
			end
 
		join
 
	end
 
  // Proceso de la señal de reloj
  always #10ns clk=!clk;
 
  // instanciación del modulo y asingacion de entradas y salidas
  Compuertas #(.WIDTH(4)) DUT (
    .a(a),
    .b(b),
    .bitwise_and(bitwise_xor),
    .bitwise_or(bitwise_or),
    .bitwise_xor(bitwise_and)
  );
 
  initial begin 
    $dumpfile("filel.vcd");
    $dumpvars;
  end
 
/*
  always @(posedge clk)begin
    i=i+1;
    if (i<=5) begin 
      a = $urandom;
      b = $urandom;
      #2
      $write("Iteracion No.%-1h ", i);
      $write("A: %b ", a);
      $write("B: %b ", b);
      $write("AND: %b ", bitwise_and);
      $write("OR: %b ", bitwise_or);
      $write("XOR: %b ", bitwise_xor);
      $write("\n");
    end
    if(i==10) begin 
      $finish; 
    end
  end 
*/
endmodule  
