module VERI_RISC (
    input clk,
    input rst,
    output halt,
    output [7:0] test
);

    // Internal wires
    wire [7:0] data_bus;
    wire [7:0] alu_out, ac_out;
    wire [4:0] pc_addr, ir_addr, addr;
    wire [2:0] opcode;
    wire zero, phase;
    wire rd, wr, ld_ir, ld_ac, ld_pc, inc_pc, data_e, sel;

    assign test = ac_out;  // optional debug output

    // Instantiate modules

    register_ac reg_ac (
        .clk(clk), .rst(rst), .ld_ac(ld_ac),
        .data(data_bus), .ac_out(ac_out)
    );

    register_ir reg_ir (
        .clk(clk), .rst(rst), .ld_ir(ld_ir),
        .data(data_bus), .opcode(opcode), .ir_addr(ir_addr)
    );

    alu alu_unit (
        .ac_out(ac_out), .data(data_bus), .opcode(opcode),
        .alu_out(alu_out), .zero(zero)
    );

    program_counter pc (
        .clk(clk), .rst(rst), .ld_pc(ld_pc),
        .inc_pc(inc_pc), .ir_addr(ir_addr),
        .pc_addr(pc_addr)
    );

    address_mux addr_mux (
        .sel(sel), .pc_addr(pc_addr), .ir_addr(ir_addr),
        .addr(addr)
    );

    memory memory_inst (
        .clk(clk), .addr(addr), .data(data_bus),
        .rd(rd), .wr(wr)
    );

    controller control_unit (
        .clk(clk), .rst(rst), .opcode(opcode), .zero(zero),
        .phase(phase), .rd(rd), .wr(wr), .ld_ir(ld_ir),
        .ld_ac(ld_ac), .ld_pc(ld_pc), .inc_pc(inc_pc),
        .halt(halt), .data_e(data_e), .sel(sel)
    );

    phase_generator phase_gen (
        .clk(clk), .rst(rst), .phase(phase)
    );

    driver tri_driver (
        .alu_out(alu_out), .data_e(data_e),
        .data(data_bus)
    );

endmodule

