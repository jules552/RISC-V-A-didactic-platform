module alu_tb;

    `include "../verilog/parameters.vh"

    // Inputs
    reg [31:0] a,b;
    reg [4:0] alu_op;

    // Outputs
    wire [31:0] result;

    // Test Variables
    integer i;
    localparam NB_RANDOM_TESTS = 1000;

    integer num_failures;

    alu alu_inst (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result)
    );

    initial begin
        num_failures = 0; // Reset failure counter

        // Test ALU_ADD
        alu_op = ALU_ADD;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != a + b) begin
                num_failures = num_failures + 1;
                $display("ALU_ADD: %d + %d != %d", a, b, result);
            end
        end 

        a = 1;
        b = -1; // = 0xFFFFFFFF
        #10;
        if (result != 0) begin
            num_failures = num_failures + 1;
            $display("ALU_ADD: 1 + (-1) != 0");
        end 

        // Test ALU_SUB
        alu_op = ALU_SUB;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != a - b) begin
                num_failures = num_failures + 1;
                $display("ALU_SUB: %d - %d != %d", a, b, result);
            end
        end

        a = 0;
        b = 1;
        #10;
        if (result != -1) begin
            num_failures = num_failures + 1;
            $display("ALU_SUB: 0 - 1 != -1");
        end

        // Test ALU_XOR
        alu_op = ALU_XOR;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != (a ^ b)) begin
                num_failures = num_failures + 1;
                $display("ALU_XOR: %d ^ %d != %d", a, b, result);
            end
        end

        // Test ALU_OR
        alu_op = ALU_OR;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != (a | b)) begin
                num_failures = num_failures + 1;
                $display("ALU_OR: %d | %d != %d", a, b, result);
            end
        end

        // Test ALU_AND
        alu_op = ALU_AND;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != (a & b)) begin
                num_failures = num_failures + 1;
                $display("ALU_AND: %d & %d != %d", a, b, result);
            end
        end

        if (num_failures == 0) begin
            $display("ALU: ALL TESTS PASSED");
        end

        $finish;
    end
endmodule
