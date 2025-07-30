module register_ac (
    input wire clk,
    input wire rst,
    input wire ld_ac,
    input wire [7:0] data,
    output reg [7:0] ac_out
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            ac_out <= 8'b0;
        else if (ld_ac)
            ac_out <= data;
    end

endmodule
