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

  adder_intf #(ADDER_WIDTH) adder_intf_i(); // Creamos la instancia de la interface
  
  logic carry_out;

/*   bit clk;

  assign #5 clk = ~clk; */
 
 
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


/* //Interface 1 
interface div_intf #(parameter WIDTH = 8 ) ();
 
endinterface */

 
//Interface 2 
interface adder_intf #(parameter WIDTH = 8) ();
 
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
 


module Adder_tb;

  parameter ADDER_WIDTH = 8;
  adder_intf #(ADDER_WIDTH) adder_intf_i();

  logic carry_out;
  
  Adder #(ADDER_WIDTH) DUT (
      .result(adder_intf_i.result),
      .carry_out(carry_out),
      .a(adder_intf_i.a),
      .b(adder_intf_i.b)
  );

  // Uncomment the test you want to run
  // `define TEST1
  `define TEST2
  // `define TEST3
  // `define TEST4
  // `define TEST5

  `ifdef TEST1
    initial begin
      adder_intf_i.add_a_b_zero();
      #1;
      assert(adder_intf_i.result == 0 && carry_out == 0) else $error("Test1 failed: Zero sum mismatch");
      repeat(1000) begin
        adder_intf_i.add_a_b_random();
        #1;
        assert(adder_intf_i.result == (adder_intf_i.a + adder_intf_i.b) && carry_out == ((adder_intf_i.a + adder_intf_i.b) >> ADDER_WIDTH)) else
          $fatal("Test1 failed: Random sum mismatch");
      end
      adder_intf_i.add_a_b_zero();
      #1;
      assert(adder_intf_i.result == 0 && carry_out == 0) else $error("Test1 failed: Final zero sum mismatch");
      $finish;
    end
  `endif

  `ifdef TEST2
    initial begin
      repeat(10) begin
        adder_intf_i.add_b_signed_random();
        #1;
        assert (adder_intf_i.result == (adder_intf_i.a + adder_intf_i.b) && carry_out == ((adder_intf_i.a + adder_intf_i.b) >> ADDER_WIDTH)) else
          $error("Test2 failed: Signed sum mismatch");
      end
      $finish;
    end
  `endif

  `ifdef TEST3
    initial begin
      repeat(10) begin
        adder_intf_i.add_a_limit_with_carry();
        #1;
        assert(adder_intf_i.result == (adder_intf_i.a + adder_intf_i.b) && carry_out == ((adder_intf_i.a + adder_intf_i.b) >> ADDER_WIDTH)) else
          $error("Test3 failed: Limit with carry mismatch");
      end
      $finish;
    end
  `endif

  `ifdef TEST4
    initial begin
      repeat(10) begin
        adder_intf_i.add_close_limit();
        #1;
        assert(adder_intf_i.result == (adder_intf_i.a + adder_intf_i.b) && carry_out == ((adder_intf_i.a + adder_intf_i.b) >> ADDER_WIDTH)) else
          $error("Test4 failed: Close limit mismatch");
      end
      $finish;
    end
  `endif

  `ifdef TEST5
    initial begin
      repeat(10) begin
        adder_intf_i.add_one_to_close_max_value();
        #1;
        assert(adder_intf_i.result == (adder_intf_i.a + adder_intf_i.b) && carry_out == ((adder_intf_i.a + adder_intf_i.b) >> ADDER_WIDTH)) else
          $error("Test5 failed: One to close max value mismatch");
      end
      $finish;
    end
  `endif

endmodule: Adder_tb
