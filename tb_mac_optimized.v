`timescale 1ns / 1ps

module tb_mac_optimized;

    reg clk;
    reg rst;
    reg en;
    reg signed [7:0] data_in;
    reg signed [7:0] weight;

    wire signed [23:0] accumulator;

    mac_optimized uut (
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

        // Reset test
        @(negedge clk);
        rst = 0;
        en = 1;

        // Test 1: 2 * 3 = 6
        data_in = 8'sd2;
        weight = 8'sd3;
        @(posedge clk);
        #1;
        if (accumulator !== 24'sd6)
            $fatal("Test 1 FAILED");

        // Test 2: -3 * 4 = -12
        @(negedge clk);
        data_in = -8'sd3;
        weight = 8'sd4;
        @(posedge clk);
        #1;
        if (accumulator !== -24'sd6)
            $fatal("Test 2 FAILED");

        // Test 3: Zero input - skip operation
        @(negedge clk);
        data_in = 0;
        weight = 8'sd5;
        @(posedge clk);
        #1;
        if (accumulator !== -24'sd6)
            $fatal("Test 3 FAILED");

        // Test 4: Zero weight - skip operation
        @(negedge clk);
        data_in = 8'sd5;
        weight = 0;
        @(posedge clk);
        #1;
        if (accumulator !== -24'sd6)
            $fatal("Test 4 FAILED");

        // Test 5: Normal operation
        @(negedge clk);
        data_in = 8'sd5;
        weight = 8'sd2;
        @(posedge clk);
        #1;
        if (accumulator !== 24'sd4)
            $fatal("Test 5 FAILED");

        // Test 6: Enable disabled
        @(negedge clk);
        en = 0;
        data_in = 8'sd7;
        weight = 8'sd3;
        @(posedge clk);
        #1;
        if (accumulator !== 24'sd4)
            $fatal("Test 6 FAILED");

        $display("OPTIMIZED MAC TEST PASSED!");
        $finish;
    end

endmodule
