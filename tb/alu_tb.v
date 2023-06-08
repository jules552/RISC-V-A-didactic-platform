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
        for (i = 0; i < NB_RANDOM_TESTS; i = i + 1) begin
            a = $random;
            b = $random;
            #10;
            if ($signed(result) != $signed(a) + $signed(b)) begin
                num_failures = num_failures + 1;
                $display("ALU_ADD: %d + %d != %d", $signed(a), $signed(b), $signed(result));
            end
        end

        // Test ALU_SUB
        alu_op = ALU_SUB;
        for (i = 0; i < NB_RANDOM_TESTS; i = i + 1) begin
            a = $random;
            b = $random;
            #10;
            if ($signed(result) != $signed(a) - $signed(b)) begin
                num_failures = num_failures + 1;
                $display("ALU_SUB: %d - %d != %d", $signed(a), $signed(b), $signed(result));
            end
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

        // Test ALU_SSL
        alu_op = ALU_SSL;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random % 32;
            #10;
            if (result != (a << b)) begin
                num_failures = num_failures + 1;
                $display("ALU_SSL: %d << %d != %d", a, b, result);
            end
        end

        // Test ALU_SRL
        alu_op = ALU_SRL;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random % 32;
            #10;
            if (result != (a >> b)) begin
                num_failures = num_failures + 1;
                $display("ALU_SRL: %d >> %d != %d", a, b, result);
            end
        end

        // Test ALU_SRA
        alu_op = ALU_SRA;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random % 32;
            #10;
            if ($signed(result) != ($signed(a) >>> b)) begin
                num_failures = num_failures + 1;
                $display("ALU_SRA: %d >>> %d != %d", $signed(a), b, $signed(result));
            end
        end

        // Test ALU_SLT
        alu_op = ALU_SLT;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != ($signed(a) < $signed(b))) begin
                num_failures = num_failures + 1;
                $display("ALU_SLT: %d < %d != %d", a, b, result);
            end
        end

        // Test ALU_SLTU
        alu_op = ALU_SLTU;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != (a < b)) begin
                num_failures = num_failures + 1;
                $display("ALU_SLTU: %d <U %d != %d", a, b, result);
            end
        end

        // Test ALU_MUL
        alu_op = ALU_MUL;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result !== (a * b)) begin
                num_failures = num_failures + 1;
                $display("ALU_MUL: %d * %d != %d", a, b, result);
            end
        end

        // Test ALU_MULH
        alu_op = ALU_MULH;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if ($signed(result) != ($signed(a) * $signed(b)) >>> 32) begin
                num_failures = num_failures + 1;
                $display("ALU_MULH: (%d * %d) >>> 32 != %d", $signed(a), $signed(b), $signed(result));
            end
        end

        // Test ALU_MULHSU
        alu_op = ALU_MULHSU;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if ($signed(result) != ($signed(a) * b) >>> 32) begin
                num_failures = num_failures + 1;
                $display("ALU_MULHSU: (%d * %d) >>> 32 != %d", $signed(a), b, $signed(result));
            end
        end

        // Test ALU_MULHU
        alu_op = ALU_MULHU;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random;
            #10;
            if (result != (a * b) >>> 32) begin
                num_failures = num_failures + 1;
                $display("ALU_MULHU: (%d * %d) >>> 32 != %d", a, b, result);
            end
        end

        // Test ALU_DIV
        alu_op = ALU_DIV;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random | 1; // Avoid divide by zero
            #10;
            if ($signed(result) != $signed(a) / $signed(b)) begin
                num_failures = num_failures + 1;
                $display("ALU_DIV: %d / %d != %d", $signed(a), $signed(b), $signed(result));
            end
        end

        // Test ALU_DIVU
        alu_op = ALU_DIVU;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random | 1; // Avoid divide by zero
            #10;
            if (result != a / b) begin
                num_failures = num_failures + 1;
                $display("ALU_DIVU: %d /U %d != %d", a, b, result);
            end
        end

        // Test ALU_REM
        alu_op = ALU_REM;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random | 1; // Avoid divide by zero
            #10;
            if ($signed(result) != $signed(a) % $signed(b)) begin
                num_failures = num_failures + 1;
                $display("ALU_REM: %d %% %d != %d", $signed(a), $signed(b), $signed(result));
            end
        end

        // Test ALU_REMU
        alu_op = ALU_REMU;
        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            a = $random;
            b = $random | 1; // Avoid divide by zero
            #10;
            if (result != a % b) begin
                num_failures = num_failures + 1;
                $display("ALU_REMU: %d %%U %d != %d", a, b, result);
            end
        end

        if (num_failures == 0) begin
            $display("ALU: ALL TESTS PASSED");
        end

        $finish;
    end
endmodule
