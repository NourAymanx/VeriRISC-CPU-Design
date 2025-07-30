module register_ir (
    input wire clk,
    input wire rst,
    input wire ld_ir,
    input wire [7:0] data,
    output reg [2:0] opcode,
    output reg [4:0] ir_addr
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            opcode  <= 3'b000;
            ir_addr <= 5'b00000;
        end else if (ld_ir) begin
            opcode  <= data[7:5];
            ir_addr <= data[4:0];
        end
    end

endmodule
