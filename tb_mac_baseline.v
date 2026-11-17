`timescale 1ns / 1ps

module tb_mac_baseline;

    reg clk;
    reg rst;
    reg en;
    reg signed [7:0] data_in;
    reg signed [7:0] weight;

    wire signed [23:0] accumulator;

    mac_baseline uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .data_in(data_in),
        .weight(weight),
        .accumulator(accumulator)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        en = 0;
        data_in = 0;
        weight = 0;

        #10;
        rst = 0;
        en = 1;

        // Test 1: 2 * 3 = 6
        data_in = 8'sd2;
        weight = 8'sd3;
        #10;
        if (accumulator !== 24'sd6)
            $fatal(1, "Test 1 FAILED");

        // Test 2: -3 * 4 = -12; total = -6
        data_in = -8'sd3;
        weight = 8'sd4;
        #10;
        if (accumulator !== -24'sd6)
            $fatal(1, "Test 2 FAILED");

        // Test 3: 5 * 2 = 10; total = 4
        data_in = 8'sd5;
        weight = 8'sd2;
        #10;
        if (accumulator !== 24'sd4)
            $fatal(1, "Test 3 FAILED");

        $display("BASELINE MAC TEST PASSED!");
        $finish;
    end

endmodule
