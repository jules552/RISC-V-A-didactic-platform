module lsu_tb;
    `include "../verilog/parameters.vh"
    
    reg [2:0] lsu_op;
    reg [31:0] addr;
    reg [31:0] wr_data;
    wire [31:0] mem_rd_data;
    wire [31:0] rd_data;
    wire [31:0] mem_addr;
    wire [31:0] mem_wr_data;
    reg clk;
    reg reset_n;
    reg wr_sig;
    
    integer num_failures;

    lsu lsu_inst (
        .lsu_op(lsu_op),
        .addr(addr),
        .wr_data(wr_data),
        .mem_rd_data(mem_rd_data),
        .rd_data(rd_data),
        .mem_addr(mem_addr),
        .mem_wr_data(mem_wr_data)
    );

    ram ram_inst (
        .clk(clk),
        .reset_n(reset_n),
        .wr_sig(wr_sig),
        .wr_data(mem_wr_data),
        .addr(mem_addr),
        .rd_data(mem_rd_data)
    );

    always #5 clk = ~clk;

    initial begin
        // Initialize testbench
        clk = 0;
        reset_n = 0;
        lsu_op = 3'b0;
        addr = 0;
        wr_data = 0;
        wr_sig = 0;
        num_failures = 0;

        #5 reset_n = 1;

        // Test 1: LSU_LB
        ram_inst.mem[1] = 32'h12345678;
        lsu_op = LSU_LB;
        addr = 32'h4;
        #10;
        if (rd_data !== 32'h00000078) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 1 FAILED");
            $display("LSU: rd_data WAS %h, EXPECTED 32'h00000078", rd_data);
        end

        // Test 2: LSU_LH
        ram_inst.mem[2] = 32'h9abcdef0;
        lsu_op = LSU_LH;
        addr = 32'h8;
        #10;
        if (rd_data !== 32'hffffdef0) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 2 FAILED");
            $display("LSU: rd_data WAS %h, EXPECTED 32'hffffdef0", rd_data);
        end

        // Test 3: LSU_LW
        ram_inst.mem[3] = 32'h12345678;
        lsu_op = LSU_LW;
        addr = 32'hc;
        #10;
        if (rd_data !== 32'h12345678) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 3 FAILED");
            $display("LSU: rd_data WAS %h, EXPECTED 32'h12345678", rd_data);
        end

        // Test 4: LSU_LBU
        ram_inst.mem[4] = 32'h9abcdef0;
        lsu_op = LSU_LBU;
        addr = 32'h10;
        #10;
        if (rd_data !== 32'h000000F0) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 4 FAILED");
            $display("LSU: rd_data WAS %h, EXPECTED 32'h000000F0", rd_data);
        end

        // Test 5: LSU_LHU
        addr = 32'h14;
        ram_inst.mem[5] = 32'h12345678;
        lsu_op = LSU_LHU;
        #10;
        if (rd_data !== 32'h00005678) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 5 FAILED");
            $display("LSU: rd_data WAS %h, EXPECTED 32'h00005678", rd_data);
        end
        
        // Test 6: LSU_SB
        wr_sig = 1;
        addr = 32'h18;
        wr_data = 32'h9abcdef0;
        lsu_op = LSU_SB;
        #10 wr_sig = 0;
        #10;
        if (mem_addr !== 32'h18) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 6 FAILED");
            $display("LSU: mem_addr WAS %h, EXPECTED 32'h18", mem_addr);
        end

        // Test 7: LSU_SH
        wr_sig = 1;
        addr = 32'h1C;
        wr_data = 32'h12345678;
        lsu_op = LSU_SH;
        #10 wr_sig = 0;
        #10;
        if (mem_addr !== 32'h1C) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 7 FAILED");
            $display("LSU: mem_addr WAS %h, EXPECTED 32'h1C", mem_addr);
        end

        // Test 8: LSU_SW
        wr_sig = 1;
        addr = 32'h20;
        wr_data = 32'h9abcdef0;
        lsu_op = LSU_SW;
        #10 wr_sig = 0;
        #10;
        if (mem_addr !== 32'h20) begin
            num_failures = num_failures + 1;
            $display("LSU: TEST 8 FAILED");
            $display("LSU: mem_addr WAS %h, EXPECTED 32'h20", mem_addr);
        end

        if (num_failures == 0)
            $display("LSU: ALL TESTS PASSED");
        else
            $display("LSU: %d TESTS FAILED", num_failures);

        $finish;
    end
endmodule

