`timescale 1ns/1ps

module Mux3_1_tb;

    reg clk;
    reg [1:0] sel;        
    reg in0, in1, in2;    
    reg [3:0] counter;    

    wire mux_out;        

    Mux3_1 uut (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .sel(sel),
        .out(mux_out)
    );

    // Generación de reloj
		initial clk = 0;
		always #5 clk = ~clk; 

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
		repeat (5) begin
			sel = $urandom;
			counter = $urandom;
			in2= $urandom;
			in1 = $urandom;
			in0 = $urandom;
			#10
			$write("C: %b \n", in2);
			$write("B: %b \n", in1);
			$write("A: %b \n", in0);
			$write("Out: %b \n", mux_out);
		end
			
			
    end
	 
	 initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		repeat (10) begin
			clk = ~clk;
			#10;
		end
	end

endmodule




