`timescale 1ns / 1ps

module RF(
	input [4:0] Rn,
	input [4:0] Rm,
	input [4:0] Rd,
	input [63:0] data_write,
	input [63:0] return_address,
	input [1:0] reg_wr,
	input clk,
	output [63:0] Reg_Rn,
	output [63:0] Reg_Rm
	);
	
	// register size x registers
	reg signed [63:0] registers [0:31];

	integer i;
	initial begin
		for (i = 0; i < 32; i = i+1)
			registers[i] <= 64'b0;
	end

	assign Reg_Rn = registers[Rn];
	assign Reg_Rm = registers[Rm];

	always @(posedge clk) begin
		if ((reg_wr == 1) && (Rd != 31))
			registers[Rd] <= data_write;
		else if (reg_wr == 2)
			registers[30] <= return_address;
	end

	always @(*) begin
		for (i = 0; i < 32; i = i+1)
			$display("%d -- %d", i, registers[i]);
	end

endmodule