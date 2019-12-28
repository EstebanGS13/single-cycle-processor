`timescale 1ns / 1ps

module DM(
    input [11:0] address,
    input [63:0] data_write,
    input write_enable,
    output [63:0] data_read
    );
	
	// Registers
	reg [63:0] memory [0:511];

	initial begin
		// $readmemb("bin_memory_file.mem", memory_array, [start_address], [end_address])
		$readmemh("data_memory.mem", memory);
	end

	// The DM is always reading memory
	assign data_read = memory[address];

	always @(*) begin
		if (write_enable)
			memory[address] <= data_write;
	end

endmodule
