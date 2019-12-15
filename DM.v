`timescale 1ns / 1ps

module DM(
    input [11:0] address,
    input [63:0] data_write,
    input write_enable,
    output [63:0] data_read
    );
	
	reg [63:0] memory [0:511];

	// siempre se lee de memoria
	assign data_read = memory[address];

	initial begin
		// $readmemb("bin_memory_file.mem", memory_array, [start_address], [end_address])
		$readmemb("data_memory.txt", memory);
	end

	always @(*) begin
		if (write_enable)
			memory[address] <= data_write;
	end

endmodule
