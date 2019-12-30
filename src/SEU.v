`timescale 1ns / 1ps

module SEU(
	input [25:0] instruction,
	input [1:0] seu_op,
	output reg [63:0] extended_address
	);
	
	wire [11:0] ALU_immediate;
	wire [8:0] DT_address;
	wire [18:0] COND_BR_address;

	assign ALU_immediate = instruction[21:10];
	assign DT_address = instruction[20:12];
	assign COND_BR_address = instruction[23:5];

	always @(*) begin
		case (seu_op)
			// format B: BR_address = instruction
			2'b00: extended_address <= {{36{instruction[25]}}, instruction, 2'b0};

			// format CB
			2'b01: extended_address <= {{43{COND_BR_address[18]}}, COND_BR_address, 2'b0};
			
			// format I
			2'b10: extended_address <= {52'b0, ALU_immediate};

			// format D
			2'b11: extended_address <= {{55{DT_address[8]}}, DT_address};
		endcase
	end
	
endmodule
