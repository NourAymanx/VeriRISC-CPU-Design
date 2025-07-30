module controller (
    input wire clk,
    input wire rst,
    input wire [2:0] opcode,
    input wire zero,
    input wire phase,
    output reg rd, wr, ld_ir, ld_ac, ld_pc, inc_pc,
    output reg halt,
    output reg data_e, sel
);

    reg [1:0] halt_state; // 00=not halted, 01=halt requested, 11=halted

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            halt_state <= 2'b00;
        end else begin
            case (halt_state)
                2'b00: if (phase && opcode == 3'b000) halt_state <= 2'b01;
                2'b01: halt_state <= 2'b11;
                default: halt_state <= halt_state;
            endcase
        end
    end

    always @(*) begin
        // Default values
        rd = 0; wr = 0; ld_ir = 0; ld_ac = 0;
        ld_pc = 0; inc_pc = 0; data_e = 0; sel = 0;
        halt = (halt_state == 2'b11);

        if (halt_state != 2'b11) begin
            if (phase == 0) begin
                // FETCH phase
                rd = 1; ld_ir = 1; inc_pc = 1; sel = 0;
            end else begin
                // EXECUTE phase
                case (opcode)
                    3'b000: ; // HLT
                    3'b001: if (zero) inc_pc = 1; // SKZ
                    3'b010: begin data_e = 1; ld_ac = 1; end // ADD
                    3'b011: begin data_e = 1; ld_ac = 1; end // AND
                    3'b100: begin data_e = 1; ld_ac = 1; end // XOR
                    3'b101: begin rd = 1; ld_ac = 1; sel = 1; end // LDA
                    3'b110: begin wr = 1; sel = 1; data_e = 1; end // STO
                    3'b111: ld_pc = 1; // JMP
                    default: ;
                endcase
            end
        end
    end
endmodule
