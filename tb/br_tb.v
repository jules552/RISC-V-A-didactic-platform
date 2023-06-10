module br_tb;
    `include "../verilog/parameters.vh"
    
    reg [31:0] pc;
    reg [31:0] imm;
    reg br_sig;
    reg [31:0] alu_result;
    reg [2:0] br_op;
    wire [31:0] new_pc;
    wire [31:0] pc_plus4;
    wire br_taken;
    
    integer num_failures = 0;

    br br_inst (
        .pc(pc),
        .imm(imm),
        .br_sig(br_sig),
        .alu_result(alu_result),
        .br_op(br_op),
        .new_pc(new_pc),
        .pc_plus4(pc_plus4),
        .br_taken(br_taken)
    );

    initial begin
        pc = 0;
        imm = 0;
        br_sig = 0;
        alu_result = 0;
        br_op = 0;
        
        // Test 1: BR_BEQ branch taken
        pc = 32'h00000000;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 0;
        br_op = BR_BEQ;
        #10;
        if (new_pc !== 32'h00000008) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 1 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h00000008", new_pc);
        end

        // Test 2: BR_BEQ branch not taken
        pc = 32'h00000008;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'h00000001;
        br_op = BR_BEQ;
        #10;
        if (new_pc !== 32'h0000000C) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 2 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h0000000C", new_pc);
        end

        // Test 3: BR_BNE branch taken
        pc = 32'h00000010;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'h00000001;
        br_op = BR_BNE;
        #10;
        if (new_pc !== 32'h00000018) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 3 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h00000018", new_pc);
        end

        // Test 4: BR_BNE branch not taken
        pc = 32'h00000018;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 0;
        br_op = BR_BNE;
        #10;
        if (new_pc !== 32'h0000001C) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 4 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h0000001C", new_pc);
        end

        // Test 5: BR_BLT branch taken
        pc = 32'h00000020;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'hFFFFFFFF;
        br_op = BR_BLT;
        #10;
        if (new_pc !== 32'h00000028) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 5 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h00000028", new_pc);
        end

        // Test 6: BR_BLT branch not taken
        pc = 32'h00000028;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'h00000001;
        br_op = BR_BLT;
        #10;
        if (new_pc !== 32'h0000002C) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 6 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h0000002C", new_pc);
        end

        // Test 7: BR_BGE branch taken
        pc = 32'h00000030;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'h00000001;
        br_op = BR_BGE;
        #10;
        if (new_pc !== 32'h00000038) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 7 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h00000038", new_pc);
        end

        // Test 8: BR_BGE branch not taken
        pc = 32'h00000038;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'hFFFFFFFF;
        br_op = BR_BGE;
        #10;
        if (new_pc !== 32'h0000003C) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 8 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h0000003C", new_pc);
        end

        // Test 9: BR_BLTU branch taken
        pc = 32'h00000040;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'hFFFFFFFE;
        br_op = BR_BLTU;
        #10;
        if (new_pc !== 32'h00000048) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 9 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h00000048", new_pc);
        end

        // Test 10: BR_BLTU branch not taken
        pc = 32'h00000048;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'h00000001;
        br_op = BR_BLTU;
        #10;
        if (new_pc !== 32'h0000004C) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 10 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h0000004C", new_pc);
        end

        // Test 11: BR_BGEU branch taken
        pc = 32'h00000050;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'h00000001;
        br_op = BR_BGEU;
        #10;
        if (new_pc !== 32'h00000058) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 11 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h00000058", new_pc);
        end

        // Test 12: BR_BGEU branch not taken
        pc = 32'h00000058;
        imm = 32'h00000008;
        br_sig = 1;
        alu_result = 32'hFFFFFFFE;
        br_op = BR_BGEU;
        #10;
        if (new_pc !== 32'h0000005C) begin
            num_failures = num_failures + 1;
            $display("BR: TEST 12 FAILED");
            $display("BR: new_pc WAS %h, EXPECTED 32'h0000005C", new_pc);
        end
        
        if (num_failures == 0)
            $display("BR: ALL TESTS PASSED");
        else
            $display("BR: %d TESTS FAILED", num_failures);

        $finish;
    end
endmodule

