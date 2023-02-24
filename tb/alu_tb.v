module alu_tb;

    `include "../verilog/parameters.vh"

    // Inputs
    reg [31:0] a,b;
    reg [3:0] op_code;

    // Outputs
    wire [31:0] result;

    // Test Variables
    integer i;

    alu alu_inst (
        .a(a),
        .b(b),
        .op_code(op_code),
        .result(result)
    );

    initial begin
        // Test ALU_ADD
        op_code = ALU_ADD;

        // Test Basic Addition
        // Run 1000 tests
        for(i=0; i<1000; i=i+1)
        begin
            a = $random;
            b = $random;
            #10;
            if (result != a + b) begin
                $display("ALU_ADD: FAIL");
                $display("ALU_ADD: %d + %d = %d", a, b, result);
            end
        end
        

        // Test Corner Case Overflow
        a = 1;
        b = -1; // = 0xFFFFFFFF
        #10;
        if (result != 0) begin
            $display("ALU_ADD: FAIL");
        end 
        $display("ALU_ADD: PASS");

        // Test ALU_SUB
        op_code = ALU_SUB;
        
        // Test Basic Subtraction
        // Run 1000 tests
        for(i=0; i<1000; i=i+1)
        begin
            a = $random;
            b = $random;
            #10;
            if (result != a - b) begin
                $display("ALU_SUB: FAIL");
                $display("ALU_SUB: %d - %d = %d", a, b, result);
            end
        end

        // Test Corner Case Underflow
        a = 0;
        b = 1;
        #10;
        if (result != -1) begin
            $display("ALU_SUB: FAIL");
        end
        $display("ALU_SUB: PASS");

        $stop;
    end

endmodule