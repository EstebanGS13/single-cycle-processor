`timescale 1ns / 1ps

module CPU(
	input clk,
	input [7:0] switches,
	output [7:0] leds
	);
	
	// wires between modules
	wire [63:0] pc_wire;
	wire [31:0] im_wire;
	wire [63:0] rf_alu_wire;
	wire [63:0] rf_alu_dmio_wire;
	wire [63:0] extended_addr_wire;
	wire [63:0] alu_dmio_wire;
	wire [63:0] dmio_wire;

	// CU wires
	wire reg_2_loc_wire;
	wire [1:0] seu_op_wire;
	wire alu_src_wire;
	wire [2:0] alu_op_wire;
	wire mem_wr_wire;
	wire mem_to_reg_wire;
	wire [1:0] reg_wr_wire;
	wire [1:0] pc_src_wire;
	wire set_flags_wire;
	wire zero_wire;
	wire eq_wire;
	wire ne_wire;
	wire ge_wire;
	wire lt_wire;
	wire gt_wire;
	wire le_wire;

	// Adders
	wire [63:0] pc_adder;
	wire [63:0] branch_adder;
	
	assign pc_adder = pc_wire + 4;
	assign branch_adder = pc_wire + extended_addr_wire;

	// Muxes
	reg [63:0] pc_mux;
	wire [4:0] rm_mux;
	wire [63:0] b_mux;
	wire [63:0] data_write_mux;

	// PC mux
	always @(*) begin
		case(pc_src_wire)
			2'b00: pc_mux <= pc_adder;
			2'b01: pc_mux <= branch_adder;
			2'b10: pc_mux <= rf_alu_dmio_wire;
		endcase
	end

	assign rm_mux = reg_2_loc_wire ? im_wire[4:0] : im_wire[20:16];
	assign b_mux = alu_src_wire ? extended_addr_wire : rf_alu_dmio_wire;
	assign data_write_mux = mem_to_reg_wire ? dmio_wire : alu_dmio_wire;

	PC PC_instance(
		.clk(clk),
		.in_pc(pc_mux),

		.pc(pc_wire)
	);
	
	IM IM_instance(
		.address(pc_wire[11:2]),
		
		.instruction(im_wire)
	);

	CU CU_instance(
		.op_code(im_wire[31:21]),
		.cond(im_wire[3:0]),
		.zero(zero_wire),
		.eq(eq_wire),
		.ne(ne_wire),
		.ge(ge_wire),
		.lt(lt_wire),
		.gt(gt_wire),
		.le(le_wire),

		.reg_2_loc(reg_2_loc_wire),
		.seu_op(seu_op_wire),
		.alu_src(alu_src_wire),
		.alu_op(alu_op_wire),
		.mem_wr(mem_wr_wire),
		.mem_to_reg(mem_to_reg_wire),
		.reg_wr(reg_wr_wire),
		.pc_src(pc_src_wire),
		.set_flags(set_flags_wire)
	);

	RF RF_instance(
		.Rn(im_wire[9:5]),
		.Rm(rm_mux),
		.Rd(im_wire[4:0]),
		.data_write(data_write_mux),
		.return_address(pc_adder),
		.reg_wr(reg_wr_wire),
		.clk(clk),

		.Reg_Rn(rf_alu_wire),
		.Reg_Rm(rf_alu_dmio_wire)
	);

	SEU SEU_instance(
		.instruction(im_wire[25:0]),
		.seu_op(seu_op_wire),

		.extended_address(extended_addr_wire)
	);

	ALU ALU_instance(
		.A(rf_alu_wire),
		.B(b_mux),
		.shamt(im_wire[15:10]),
		.alu_op(alu_op_wire),
		.set_flags(set_flags_wire),

		.result(alu_dmio_wire),
		.zero(zero_wire),
		.eq(eq_wire),
		.ne(ne_wire),
		.ge(ge_wire),
		.lt(lt_wire),
		.gt(gt_wire),
		.le(le_wire)
	);

	DMIO DMIO_instance(
		.address(alu_dmio_wire[12:0]),
		.data_write(rf_alu_dmio_wire),
		.mem_wr(mem_wr_wire),
		.clk(clk),
		.switches(switches),

		.leds(leds),
		.data_read(dmio_wire)
	);

endmodule
