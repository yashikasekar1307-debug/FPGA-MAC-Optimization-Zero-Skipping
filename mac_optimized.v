module mac_optimized (
    input wire clk,
    input wire rst,
    input wire en,
    input wire signed [7:0] data_in,
    input wire signed [7:0] weight,
    output reg signed [23:0] accumulator
);

    // Zero-skipping control
    wire mac_active;

    assign mac_active = en &&
                        (data_in != 8'sd0) &&
                        (weight != 8'sd0);

    // Operand isolation
    wire signed [7:0] gated_data;
    wire signed [7:0] gated_weight;

    assign gated_data =
        mac_active ? data_in : 8'sd0;

    assign gated_weight =
        mac_active ? weight : 8'sd0;

    // Signed multiplication
    wire signed [15:0] product;

    assign product = gated_data * gated_weight;

    // Accumulation
    always @(posedge clk) begin
        if (rst)
            accumulator <= 24'sd0;
        else if (mac_active)
            accumulator <= accumulator +
                {{8{product[15]}}, product};
    end

endmodule
