`timescale 1ns / 1ps

module register_file_tb;

    reg clk;
    reg reset_n;
    reg [4:0] rs1_addr_i;
    reg [4:0] rs2_addr_i;
    reg [31:0] wr_data_i;
    reg [4:0] wr_addr_i;
    reg wr_enable_i;

    wire [31:0] rs1_o;
    wire [31:0] rs2_o;

    reg [31:0] expected_values[0:31]; // Store expected values for verification later

    integer i;
    integer num_failures; // To keep track of number of test failures

    // Instantiate the module
    register_file rf (
        .clk(clk),
        .reset_n(reset_n),
        .rs1_addr_i(rs1_addr_i),
        .rs2_addr_i(rs2_addr_i),
        .wr_data_i(wr_data_i),
        .wr_addr_i(wr_addr_i),
        .wr_enable_i(wr_enable_i),
        .rs1_o(rs1_o),
        .rs2_o(rs2_o)
    );

    // Create a clock with period 20ns
    always begin
        #10 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Reset
        clk = 0; reset_n = 0;
        rs1_addr_i = 0; rs2_addr_i = 0;
        wr_data_i = 0; wr_addr_i = 0;
        wr_enable_i = 0;
        num_failures = 0; // Reset failure counter

        #15; // Wait for some time
        reset_n = 1;

        // Write random values to each register
        for (i = 0; i < 32; i = i+1) begin
            #10; // Wait for one clock cycle

            wr_data_i = $random; 
            wr_addr_i = i;
            wr_enable_i = 1;

            if (i == 0) begin
                expected_values[i] = 0; // Register 0 is always 0
            end else begin
                expected_values[i] = wr_data_i;
            end

            #10; // Wait for one clock cycle

            wr_enable_i = 0; 
        end

        // Read back and verify each register
        for (i = 0; i < 32; i = i+1) begin
            #10; // Wait for one clock cycle

            rs1_addr_i = i;

            #10; // Wait for one clock cycle

            if (rs1_o != expected_values[i]) begin
                num_failures = num_failures + 1;
                $display("REGISTER %d: FAILED", i);
                $display("Expected: %h, Got: %h", expected_values[i], rs1_o);
            end
        end

        if (num_failures == 0) begin
            $display("REGISTER FILE: ALL TESTS PASSED");
        end

        // End the test
        $finish;
    end
endmodule