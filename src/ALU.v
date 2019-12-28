`timescale 1ns / 1ps

module ALU(
	input [63:0] A,
	input [63:0] B,
	input [2:0] alu_op,
	output zero,
	output reg [63:0] address
	);
	
	always @(*) begin
		case(alu_op)
			3'b000: address <= A + B;
			3'b001: address <= A - B;
			3'b010: address <= A & B;
			3'b011: address <= A | B;
			3'b100: address <= B;
		endcase
	end

	assign zero = (address == 0) ? 1 : 0; // zero is 1 if address is 0

endmodule