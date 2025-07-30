module alu (
    input wire [7:0] ac_out,
    input wire [7:0] data,
    input wire [2:0] opcode,
    output reg [7:0] alu_out,
    output wire zero
);

    always @(*) begin
        case (opcode)
            3'b010: alu_out = ac_out + data; // ADD
            3'b011: alu_out = ac_out & data; // AND
            3'b100: alu_out = ac_out ^ data; // XOR
            3'b101: alu_out = data;          // LDA
            default: alu_out = ac_out;       // For HLT, SKZ, STO, JMP: pass AC through
        endcase
    end

    assign zero = (alu_out == 8'b0);

endmodule
