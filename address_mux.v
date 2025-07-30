module address_mux (
    input wire sel,
    input wire [4:0] pc_addr,
    input wire [4:0] ir_addr,
    output wire [4:0] addr
);

    assign addr = sel ? ir_addr : pc_addr;

endmodule
