`timescale 1ns / 1ps

module DMIO(
    input [12:0] address,
    input [63:0] data_write,
    input mem_wr,
    input clk,
    input [7:0] switches,
    output reg [7:0] leds,
    output [63:0] data_read
    );

	// wire to connect dm output to mux
	wire [63:0] data_read_wire;

	wire write_enable;
	wire leds_enable;

	assign write_enable = mem_wr & ~address[12];
	assign leds_enable = mem_wr & address[12];

	DM DM_instance(
	    .address(address[11:0]),
	    .data_write(data_write),
	    .write_enable(write_enable),

	    .data_read(data_read_wire)
    );

	always @(posedge clk) begin
		if (leds_enable)
			leds <= data_write[7:0];
	end

	// mux output
	assign data_read = address[12] ? {56'b0, switches} : data_read_wire;

endmodule
