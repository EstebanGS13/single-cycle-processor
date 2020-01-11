`timescale 1ns / 1ps

module ALU(
	input [63:0] A,
	input [63:0] B,
	input [5:0] shamt,
	input [2:0] alu_op,
	input set_flags,
	output reg [63:0] result,
	output zero,
	output reg eq,
	output reg ne,
	output reg ge,
	output reg lt,
	output reg gt,
	output reg le
	);
	
	always @(*) begin
		case(alu_op)
			3'b000: result <= A + B;
			3'b001: result <= A - B;
			3'b010: result <= A & B;
			3'b011: result <= A | B;
			3'b100: result <= A ^ B;
			3'b101: result <= A <<< shamt;
			3'b110: result <= A >>> shamt;
			3'b111: result <= B;
		endcase
	end

	assign zero = result == 0; // zero is 1 if the result is 0
	
	always @(result) begin
		if (set_flags) begin
			eq <= A == B;
			ne <= A != B;
			ge <= A >= B;
			lt <= A < B;
			gt <= A > B;
			le <= A <= B;
		end
	end

endmodule
