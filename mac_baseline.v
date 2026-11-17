module mac_baseline (
    input wire clk,
    input wire rst,
    input wire en,
    input wire signed [7:0] data_in,
    input wire signed [7:0] weight,
    output reg signed [23:0] accumulator
);

    wire signed [15:0] product;

    assign product = data_in * weight;

    always @(posedge clk) begin
        if (rst)
            accumulator <= 24'sd0;
        else if (en)
            accumulator <= accumulator + {{8{product[15]}}, product};
    end

endmodule

