
module forward_controller_tb;
    `include "../verilog/parameters.vh"

    reg [4:0] reg_addr1_i;
    reg [31:0] reg_rs1_i;
    reg [4:0] reg_addr2_i;
    reg [31:0] reg_rs2_i;
    reg [4:0] id_ex_reg_wr_addr_i;
    reg id_ex_reg_wr_sig_i;
    reg [1:0] id_ex_data_dest_i;
    reg [31:0] id_ex_alu_result_i;
    reg [31:0] id_ex_pc_plus4_i;
    reg [4:0] ex_mem_reg_wr_addr_i;
    reg ex_mem_reg_wr_sig_i;
    reg [1:0] ex_mem_data_dest_i;
    reg [31:0] ex_mem_alu_result_i;
    reg [31:0] ex_mem_pc_plus4_i;
    reg [31:0] ex_mem_mem_rd_data_i;
    reg [4:0] mem_wb_reg_wr_addr_i;
    reg mem_wb_reg_wr_sig_i;
    reg [1:0] mem_wb_data_dest_i;
    reg [31:0] mem_wb_mem_rd_data_i;
    reg [31:0] mem_wb_alu_result_i;
    reg [31:0] mem_wb_pc_plus4_i;

    wire [31:0] rs1_o;
    wire [31:0] rs2_o;

    integer num_failures;

    forward_controller uut (
        .reg_addr1_i(reg_addr1_i),
        .reg_rs1_i(reg_rs1_i),
        .reg_addr2_i(reg_addr2_i),
        .reg_rs2_i(reg_rs2_i),
        .id_ex_reg_wr_addr_i(id_ex_reg_wr_addr_i),
        .id_ex_reg_wr_sig_i(id_ex_reg_wr_sig_i),
        .id_ex_data_dest_i(id_ex_data_dest_i),
        .id_ex_alu_result_i(id_ex_alu_result_i),
        .id_ex_pc_plus4_i(id_ex_pc_plus4_i),
        .ex_mem_reg_wr_addr_i(ex_mem_reg_wr_addr_i),
        .ex_mem_reg_wr_sig_i(ex_mem_reg_wr_sig_i),
        .ex_mem_data_dest_i(ex_mem_data_dest_i),
        .ex_mem_alu_result_i(ex_mem_alu_result_i),
        .ex_mem_pc_plus4_i(ex_mem_pc_plus4_i),
        .ex_mem_mem_rd_data_i(ex_mem_mem_rd_data_i),
        .mem_wb_reg_wr_addr_i(mem_wb_reg_wr_addr_i),
        .mem_wb_reg_wr_sig_i(mem_wb_reg_wr_sig_i),
        .mem_wb_data_dest_i(mem_wb_data_dest_i),
        .mem_wb_mem_rd_data_i(mem_wb_mem_rd_data_i),
        .mem_wb_alu_result_i(mem_wb_alu_result_i),
        .mem_wb_pc_plus4_i(mem_wb_pc_plus4_i),
        .rs1_o(rs1_o),
        .rs2_o(rs2_o)
    );

    initial begin
        $dumpfile("vcd/forward_controller.vcd");
        $dumpvars(0, forward_controller_tb);
        num_failures = 0;

        // Initialize inputs
        reg_addr1_i = 5'd1;
        reg_rs1_i = 32'h1;
        reg_addr2_i = 5'd2;
        reg_rs2_i = 32'h2;

        // Test 1: id_ex stage forwards to rs1
        id_ex_reg_wr_addr_i = 5'd1;
        id_ex_reg_wr_sig_i = 1'b1;
        id_ex_data_dest_i = ALU;
        id_ex_alu_result_i = 32'h1111_1111;
        id_ex_pc_plus4_i = 32'h0;

        #10;

        if (rs1_o !== 32'h1111_1111) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 1 FAILED");
            $display("FORWARD CONTROLLER: rs1_o WAS %h, EXPECTED 32'h1111_1111", rs1_o);
        end

        // Test 2: ex_mem stage forwards to rs1
        id_ex_reg_wr_sig_i = 1'b0;
        ex_mem_reg_wr_addr_i = 5'd1;
        ex_mem_reg_wr_sig_i = 1'b1;
        ex_mem_data_dest_i = MEM;
        ex_mem_mem_rd_data_i = 32'h2222_2222;
        ex_mem_alu_result_i = 32'h0;
        ex_mem_pc_plus4_i = 32'h0;

        #10;

        if (rs1_o !== 32'h2222_2222) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 2 FAILED");
            $display("FORWARD CONTROLLER: rs1_o WAS %h, EXPECTED 32'h2222_2222", rs1_o);
        end

        // Test 3: mem_wb stage forwards to rs1
        ex_mem_reg_wr_sig_i = 1'b0;
        mem_wb_reg_wr_addr_i = 5'd1;
        mem_wb_reg_wr_sig_i = 1'b1;
        mem_wb_data_dest_i = PC;
        mem_wb_mem_rd_data_i = 32'h0;
        mem_wb_alu_result_i = 32'h0;
        mem_wb_pc_plus4_i = 32'h3333_3333;

        #10;

        if (rs1_o !== 32'h3333_3333) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 3 FAILED");
            $display("FORWARD CONTROLLER: rs1_o WAS %h, EXPECTED 32'h3333_3333", rs1_o);
        end

        // Test 4: id_ex stage forwards to rs2
        mem_wb_reg_wr_sig_i = 1'b0;
        id_ex_reg_wr_addr_i = 5'd2;
        id_ex_reg_wr_sig_i = 1'b1;
        id_ex_data_dest_i = ALU;
        id_ex_alu_result_i = 32'h4444_4444;
        id_ex_pc_plus4_i = 32'h0;

        #10;

        if (rs2_o !== 32'h4444_4444) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 4 FAILED");
            $display("FORWARD CONTROLLER: rs2_o WAS %h, EXPECTED 32'h4444_4444", rs2_o);
        end

        // Test 5: ex_mem stage forwards to rs2
        id_ex_reg_wr_sig_i = 1'b0;
        ex_mem_reg_wr_addr_i = 5'd2;
        ex_mem_reg_wr_sig_i = 1'b1;
        ex_mem_data_dest_i = MEM;
        ex_mem_mem_rd_data_i = 32'h5555_5555;
        ex_mem_alu_result_i = 32'h0;
        ex_mem_pc_plus4_i = 32'h0;

        #10;

        if (rs2_o !== 32'h5555_5555) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 5 FAILED");
            $display("FORWARD CONTROLLER: rs2_o WAS %h, EXPECTED 32'h5555_5555", rs2_o);
        end

        // Test 6: mem_wb stage forwards to rs2
        ex_mem_reg_wr_sig_i = 1'b0;
        mem_wb_reg_wr_addr_i = 5'd2;
        mem_wb_reg_wr_sig_i = 1'b1;
        mem_wb_data_dest_i = PC;
        mem_wb_mem_rd_data_i = 32'h0;
        mem_wb_alu_result_i = 32'h0;
        mem_wb_pc_plus4_i = 32'h6666_6666;

        #10;

        if (rs2_o !== 32'h6666_6666) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 6 FAILED");
            $display("FORWARD CONTROLLER: rs2_o WAS %h, EXPECTED 32'h6666_6666", rs2_o);
        end

        // Test 7: No forwarding to rs1 as reg_wr_sig_i is 0 for all stages
        reg_addr1_i = 5'd1;
        reg_rs1_i = 32'h7777_7777;
        id_ex_reg_wr_sig_i = 1'b0;
        ex_mem_reg_wr_sig_i = 1'b0;
        mem_wb_reg_wr_sig_i = 1'b0;

        #10;

        if (rs1_o !== 32'h7777_7777) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 7 FAILED");
            $display("FORWARD CONTROLLER: rs1_o WAS %h, EXPECTED 32'h7777_7777", rs1_o);
        end

        // Test 8: No forwarding to rs2 as reg_wr_addr_i from all stages does not match with reg_addr2_i
        reg_addr2_i = 5'd2;
        reg_rs2_i = 32'h8888_8888;
        id_ex_reg_wr_addr_i = 5'd3;
        ex_mem_reg_wr_addr_i = 5'd4;
        mem_wb_reg_wr_addr_i = 5'd5;

        #10;

        if (rs2_o !== 32'h8888_8888) begin
            num_failures = num_failures + 1;
            $display("FORWARD CONTROLLER: TEST 8 FAILED");
            $display("FORWARD CONTROLLER: rs2_o WAS %h, EXPECTED 32'h8888_8888", rs2_o);
        end

        if (num_failures === 0) begin
            $display("FORWARD CONTROLLER: TESTS PASSED");
        end else begin
            $display("FORWARD CONTROLLER: %d TESTS FAILED", num_failures);
        end

        $finish;
    end
endmodule
