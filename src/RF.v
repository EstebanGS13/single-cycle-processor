`timescale 1ns / 1ps

module RF(
	input [4:0] Rn,
	input [4:0] Rm,
	input [4:0] Rd,
	input [63:0] data_write,
	input reg_wr,
	input clk,
	output [63:0] Reg_Rn,
	output [63:0] Reg_Rm
	);
	
	// register size x registers
	reg [63:0] registers [0:31];

	integer i;
	initial begin
		for (i = 0; i < 32; i = i+1)
			registers[i] <= 64'b0;
	end

	assign Reg_Rn = registers[Rn];
	assign Reg_Rm = registers[Rm];

	always @(posedge clk) begin
		if (reg_wr & Rd != 5'b11111)
			registers[Rd] <= data_write;
	end

endmodule