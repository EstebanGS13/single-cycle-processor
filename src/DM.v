`timescale 1ns / 1ps

module DM(
    input [11:0] address,
    input [63:0] data_write,
    input write_enable,
    output [63:0] data_read);
	
	reg [63:0] memory [0:511];

	initial
		$readmemh("src/data_memory.mem", memory);

	// The DM is always reading memory
	assign data_read = memory[address];

	always @(*) begin
		if (write_enable)
			memory[address] <= data_write;
	end

endmodule
