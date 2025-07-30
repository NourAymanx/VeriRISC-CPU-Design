module phase_generator (
    input wire clk,
    input wire rst,
    output reg phase
);

    reg first_cycle;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            phase <= 0;
            first_cycle <= 1;  // Use this flag to delay toggle
        end else if (first_cycle) begin
            phase <= 0;        // Hold Fetch phase
            first_cycle <= 0;  // After this, toggle normally
        end else begin
            phase <= ~phase;
        end
    end

endmodule
