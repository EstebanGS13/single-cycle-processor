`timescale 1ns / 1ps

module CU(
    input [10:0] op_code,
    input zero,
    output reg reg_to_loc,
    output reg [1:0] seu_op,
    output reg alu_src,
    output reg [2:0] alu_op,
    output reg mem_wr,
    output reg mem_to_reg,
    output reg reg_wr,
    output reg pc_src
    );

    always @(*) begin
        casez (op_code)
            // tipo B -----------------------------------
            // B
            11'b000101zzzzz:
                begin
                    reg_to_loc <= 1'b0; // dc
                    seu_op     <= 2'b10;
                    alu_src    <= 1'b0; // dc
                    alu_op     <= 3'b000; // dc
                    mem_wr     <= 1'b0; // dc
                    mem_to_reg <= 1'b0; // dc
                    reg_wr     <= 1'b0;
                    pc_src     <= 1'b1;
                end

            // tipo CB -----------------------------------
            // CBZ
            11'b10110100zzz:
                begin
                    reg_to_loc <= 1'b1;
                    seu_op     <= 2'b11;
                    alu_src    <= 1'b0;
                    alu_op     <= 3'b100;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0; // dc
                    reg_wr     <= 1'b0;
                    pc_src     <= zero;
                end

            // CBNZ
            11'b10110101zzz:
                begin
                    reg_to_loc <= 1'b1;
                    seu_op     <= 2'b11;
                    alu_src    <= 1'b0;
                    alu_op     <= 3'b100;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0; // dc
                    reg_wr     <= 1'b0;
                    pc_src     <= ~zero;
                end

            // tipo I ------------------------------------
            // ADDI
            11'b1001000100z:
                begin
                    reg_to_loc <= 1'b0; // dc
                    seu_op     <= 2'b00;
                    alu_src    <= 1'b1;
                    alu_op     <= 3'b000;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0;
                    reg_wr     <= 1'b1;
                    pc_src     <= 1'b0;
                end

            // SUBI
            11'b1101000100z:
                begin
                    reg_to_loc <= 1'b0; // dc
                    seu_op     <= 2'b00;
                    alu_src    <= 1'b1;
                    alu_op     <= 3'b001;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0;
                    reg_wr     <= 1'b1;
                    pc_src     <= 1'b0;
                end

            // tipo R  -----------------------------------
            // ADD
            11'b10001011000:
                begin
                    reg_to_loc <= 1'b0;
                    seu_op     <= 2'b00; // dc
                    alu_src    <= 1'b0;
                    alu_op     <= 3'b000;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0;
                    reg_wr     <= 1'b1;
                    pc_src     <= 1'b0;
                end

            // SUB
            11'b11001011000:
                begin
                    reg_to_loc <= 1'b0;
                    seu_op     <= 2'b00; // dc
                    alu_src    <= 1'b0;
                    alu_op     <= 3'b001;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0;
                    reg_wr     <= 1'b1;
                    pc_src     <= 1'b0;
                end

            // AND
            11'b10001010000:
                begin
                    reg_to_loc <= 1'b0;
                    seu_op     <= 2'b00; // dc
                    alu_src    <= 1'b0;
                    alu_op     <= 3'b010;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0;
                    reg_wr     <= 1'b1;
                    pc_src     <= 1'b0;
                end

            // ORR
            11'b10101010000:
                begin
                    reg_to_loc <= 1'b0;
                    seu_op     <= 2'b00; // dc
                    alu_src    <= 1'b0;
                    alu_op     <= 3'b011;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b0;
                    reg_wr     <= 1'b1;
                    pc_src     <= 1'b0; 
                end

            // tipo D -------------------------------
            // STUR
            11'b11111000000:
                begin
                    reg_to_loc <= 1'b1;
                    seu_op     <= 2'b01;
                    alu_src    <= 1'b1;
                    alu_op     <= 3'b000;
                    mem_wr     <= 1'b1;
                    mem_to_reg <= 1'b0; // dc
                    reg_wr     <= 1'b0;
                    pc_src     <= 1'b0;
                end

            // LDUR
            11'b11111000010:
                begin
                    reg_to_loc <= 1'b1;
                    seu_op     <= 2'b01;
                    alu_src    <= 1'b1;
                    alu_op     <= 3'b000;
                    mem_wr     <= 1'b0;
                    mem_to_reg <= 1'b1;
                    reg_wr     <= 1'b1;
                    pc_src     <= 1'b0;
                end

        endcase
    end

endmodule
