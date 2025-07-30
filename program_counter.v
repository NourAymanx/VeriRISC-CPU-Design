module program_counter (
    input wire clk,
    input wire rst,
    input wire ld_pc,
    input wire inc_pc,
    input wire [4:0] ir_addr,
    output reg [4:0] pc_addr
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_addr <= 5'b0;
        else if (ld_pc)
            pc_addr <= ir_addr;
        else if (inc_pc)
            pc_addr <= pc_addr + 1;
    end

endmodule
