`timescale 1ns / 1ps

module CPU_TB;

	// Inputs
	reg clk;
	reg [7:0] switches;

	// Outputs
	wire [7:0] leds;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.switches(switches), 
		.leds(leds)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		switches = 2;

		// Wait 100 ns for global reset to finish
		// #100;
        
		// Add stimulus here

	end

	always #20 clk = ~clk;
	
      
endmodule

