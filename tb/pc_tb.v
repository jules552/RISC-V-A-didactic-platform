module pc_tb;

    // Inputs
    reg reset_n, clk;
    reg [31:0] new_pc, new_pc_pred;
    reg br_pred, miss_pred, stall;
    
    // Outputs
    wire [31:0] pc;

    integer i;
    reg [31:0] old_pc;
    localparam NB_RANDOM_TESTS = 1000;
    integer num_failures;

    pc pc_inst (
        .reset_n(reset_n),
        .clk(clk),
        .new_pc(new_pc),
        .br_pred(br_pred),
        .new_pc_pred(new_pc_pred),
        .miss_pred(miss_pred),
        .stall(stall),
        .pc(pc)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("vcd/pc.vcd");
        $dumpvars(0, pc_tb);

        reset_n = 0;
        clk = 0;
        new_pc = 0;
        br_pred = 0;
        new_pc_pred = 0;
        miss_pred = 0;
        stall = 0;

        num_failures = 0; 

        #10 reset_n = 1;

        for(i=0; i<NB_RANDOM_TESTS; i=i+1) begin
            new_pc = ($random & ~3);
            br_pred = $random & 1;
            new_pc_pred = ($random & ~3);
            miss_pred = $random & 1;
            stall = $random & 1;

            old_pc = pc;

            #10;            
            if(miss_pred) begin
                if(pc != new_pc) begin
                    num_failures = num_failures + 1;
                    $display("Error: Unexpected pc for miss_pred. Expected: %d, Got: %d", new_pc, pc);
                end
            end else if(stall) begin
                if(pc != pc) begin
                    num_failures = num_failures + 1;
                    $display("Error: Unexpected pc for stall. Expected: %d, Got: %d", pc, pc);
                end
            end else if(br_pred) begin
                if(pc != new_pc_pred) begin
                    num_failures = num_failures + 1;
                    $display("Error: Unexpected pc for br_pred. Expected: %d, Got: %d", new_pc_pred, pc);
                end
            end else begin
                if(pc != (old_pc + 4)) begin
                    num_failures = num_failures + 1;
                    $display("Error: Unexpected pc for normal case. Expected: %d, Got: %d", new_pc + 4, pc);
                end
            end
        end

        if(num_failures == 0) begin
            $display("PC operation test: ALL TESTS PASSED");
        end else begin
            $display("PC operation test: TEST FAILED. %d failures detected.", num_failures);
        end

        $finish;
    end
endmodule
