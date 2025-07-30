
module driver (
    input wire [7:0] alu_out,
    input wire data_e,
    output wire [7:0] data
);

    assign data = data_e ? alu_out : 8'bz;

endmodule
