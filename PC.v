`timescale 1ns / 1ps

module PC(
	input clk,
    input [63:0] in_pc,
    output reg [63:0] pc
    );
	
	initial
		pc = 64'b0;

	always @ (posedge clk)
		pc <= in_pc;

endmodule
