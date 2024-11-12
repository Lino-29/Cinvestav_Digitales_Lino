`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 01:31:25 AM
// Design Name: 
// Module Name: Adder_tb
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


module Adder_tb;
 
  parameter ADDER_WIDTH = 8;
 
/*
  logic [(WIDTH - 1): 0] result;
  bit [(WIDTH - 1): 0] a;
  bit [(WIDTH - 1): 0] b;
*/
  adder_intf #(ADDER_WIDTH) adder_intf_i(); // Creamos la instancia de la interface
 
 
  Adder #(ADDER_WIDTH /* Pre-synthesis */) DUT (
      .result(adder_intf_i.result), // conectamos el puerto result del DUT con la variable result de la instancia de la interface
      .a(adder_intf_i.a),
      .b(adder_intf_i.b)
  );

//    `define TEST1
   `define TEST2
//    `define TEST3
  //  `define TEST4
   //`define TEST5
 
  `ifdef TEST1
    // Prueba 1 - 
    //////////////////////////////////////////////
    // 1. Generar una suma de 0                 //
    // 2. Generar 1000 sumas con valores random //
    // 3. Generar una suma de 0                 //
    //////////////////////////////////////////////
    initial begin
      adder_intf_i.add_a_b_zero();
      #1;
      repeat(1000) adder_intf_i.add_a_b_random();
      #1;
      adder_intf_i.add_a_b_zero();
      #1;
      $finish;
    end
  `endif
 
  `ifdef TEST2
    // Prueba 2 - 
    ///////////////////////////////////////////////////////
    // 1. Generar 10 sumas de con b signado y a normal  //
    // 2. b debe tomrar números random                   //
    //////////////////////////////////////////////////////
    initial begin
      repeat(10) 
		adder_intf_i.add_b_signed_random();
      	#1;
      $finish;
    end
  `endif

   `ifdef TEST3
    // Prueba 3 - 
    //////////////////////////////////////////////////////////////////////////
    // 1. Generar 10 sumas con a igual a 255 y b mnúmero random             //
    // 2.                                                                   //
    /////////////////////////////////////////////////////////////////////////
    initial begin
      repeat(10) 
	  	adder_intf_i.add_a_limit_with_carry();
	  	#1;
      $finish;
    end
  `endif

   `ifdef TEST4
    // Prueba 4 - 
    //////////////////////////////////////////////////////////////////////////
    // 1. add one number close to the limit and a random number             //
    // 2.                                                                   //
    /////////////////////////////////////////////////////////////////////////
    initial begin
      repeat(10) adder_intf_i.add_close_limit();
	  #1;
      $finish;
    end
  `endif

  `ifdef TEST 5
    // Prueba 5 - 
    //////////////////////////////////////////////////////////////////////////
    // 1. add one to a number close to the limit					         //
    // 2.                                                                   //
    /////////////////////////////////////////////////////////////////////////
    initial begin
      repeat(10) adder_intf_i.add_one_to_close_max_value();
	  #1;
      $finish;
    end
  `endif
 
endmodule: Adder_tb


//Interface 1 
interface div_intf #(parameter WIDTH = 8 /* Pre-synthesis */) ();
 
endinterface

 
//Interface 2 
interface adder_intf #(parameter WIDTH = 8 /* Pre-synthesis */) ();
 
  logic [WIDTH-1:0] a;
  logic [WIDTH-1:0] b;
  logic [WIDTH-1:0] result;
  // BFM - Bus Functional Model // Conjunto de tasks & functions que permiten generar estimulos
  // validos para el DUT
  function add_a_zero_b_random();
    a = '0;
    std::randomize(b);
  endfunction

  function add_b_zero_a_random();
    b = '0;
    std::randomize(a);
  endfunction

  function add_a_b_random();
    std::randomize(a);
    std::randomize(b);
  endfunction

// a y b son números random pero b es signado
  function add_b_signed_random();
    std::randomize(a);
    std::randomize(b);
    b = (~b + 1);
  endfunction
  
  //add a random number to the max valued number
  function add_a_limit_with_carry();
    a = 8'hFF;
    std::randomize(b);
    b = (~b + 1);
  endfunction

  // This function can be used for adding two numbers a/b with a value of zero
  function add_a_b_zero();
    a = '0;
    b = '0;
  endfunction

	// Function to add one number close to the limit and a random number
   function add_close_limit();
    a = 8'b01111111;
    std::randomize(b);
  endfunction

  function add_one_to_close_max_value();
    a = 8'b01111111;
    b = 8'b00000001;
  endfunction
 
endinterface: adder_intf
 
 
  
  /* Logica que genera estimulos */
 
  /* Logica que checa que el comportamiento del DUT haga match con base en la spec */
  /* Logica que me dice que tanto del DUT se a ejercitado */
/*
  automatic function fnc1();
    bit a;
    bit b;
  endfunction
  fork
    begin
      fnc1(); // variable dinamica a y b se va a generar
    end
    begin
      fnc1(); // variable dinamica a y b se va a generar
    end
  join
*/