`timescale 1ns / 1ps

module IM(
	input [9:0] address,
	output [31:0] instruction
	);

	reg [31:0] memory [0:511];

	initial
		$readmemh("instruction_memory.mem", memory);

	assign instruction = memory[address];

endmodule
