module stall_unit_tb;
    `include "../verilog/parameters.vh"
    
    reg [4:0] reg_rs1_addr_i;
    reg [4:0] reg_rs2_addr_i;
    reg [4:0] id_ex_reg_wr_addr_i;
    reg id_ex_reg_wr_sig_i;
    reg [1:0] id_ex_data_dest_i;

    wire stall_o;

    integer num_failures;

    stall_unit uut (
        .reg_rs1_addr_i(reg_rs1_addr_i),
        .reg_rs2_addr_i(reg_rs2_addr_i),
        .id_ex_reg_wr_addr_i(id_ex_reg_wr_addr_i),
        .id_ex_reg_wr_sig_i(id_ex_reg_wr_sig_i),
        .id_ex_data_dest_i(id_ex_data_dest_i),
        .stall_o(stall_o)
    );

    initial begin
        $dumpfile("vcd/stall_unit.vcd");
        $dumpvars(0, stall_unit_tb);
        num_failures = 0;

        // Test 1: No stall expected
        reg_rs1_addr_i = 5'd1;
        reg_rs2_addr_i = 5'd2;
        id_ex_reg_wr_addr_i = 5'd3;
        id_ex_reg_wr_sig_i = 1'b0;
        id_ex_data_dest_i = ALU;

        #10;

        if (stall_o !== 1'b0) begin
            num_failures = num_failures + 1;
            $display("STALL UNIT: TEST 1 FAILED");
            $display("STALL UNIT: stall_o WAS %b, EXPECTED 1'b0", stall_o);
        end

        // Test 2: Stall expected due to data destination and register write address match
        id_ex_reg_wr_sig_i = 1'b1;
        id_ex_data_dest_i = MEM;
        id_ex_reg_wr_addr_i = reg_rs1_addr_i;

        #10;

        if (stall_o !== 1'b1) begin
            num_failures = num_failures + 1;
            $display("STALL UNIT: TEST 2 FAILED");
            $display("STALL UNIT: stall_o WAS %b, EXPECTED 1'b1", stall_o);
        end

        // Test 3: Stall expected due to data destination and register write address match
        id_ex_reg_wr_addr_i = reg_rs2_addr_i;

        #10;

        if (stall_o !== 1'b1) begin
            num_failures = num_failures + 1;
            $display("STALL UNIT: TEST 3 FAILED");
            $display("STALL UNIT: stall_o WAS %b, EXPECTED 1'b1", stall_o);
        end

        // Test 4: No stall expected due to zero write address
        id_ex_reg_wr_addr_i = 5'd0;

        #10;

        if (stall_o !== 1'b0) begin
            num_failures = num_failures + 1;
            $display("STALL UNIT: TEST 4 FAILED");
            $display("STALL UNIT: stall_o WAS %b, EXPECTED 1'b0", stall_o);
        end

        if (num_failures == 0)
            $display("STALL UNIT: ALL TESTS PASSED");
        else
            $display("STALL UNIT: %d TESTS FAILED", num_failures);
    end
endmodule
