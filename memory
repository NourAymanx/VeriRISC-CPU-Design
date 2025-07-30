module memory (
    input wire clk,
    input wire [4:0] addr,
    inout wire [7:0] data,
    input wire rd,
    input wire wr
);

    reg [7:0] array [0:31];
    reg [7:0] data_out;

    // Read
    always @(*) begin
        if (rd)
            data_out = array[addr];
        else
            data_out = 8'bz;
    end

    assign data = (rd) ? data_out : 8'bz;

    // Write
    always @(posedge clk) begin
        if (wr)
            array[addr] <= data;
    end

    // Program preloading
    initial begin
        array[0] = 8'b10100000; // LDA
        array[1] = 8'b00000001; // HLT
        array[16] = 8'd42;      // Data to be loaded into AC
    end

endmodule

