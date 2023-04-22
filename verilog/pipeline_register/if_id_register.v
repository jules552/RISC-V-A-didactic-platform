module if_id_register (
    input wire clk,
    input wire reset_n,

    input wire [31:0] instruction_i,
    input wire [31:0] pc_i,
    input wire stall_i,
    input wire flush_i,

    output wire [31:0] instruction_o,
    output wire [31:0] pc_o
);

    reg [31:0] instruction;
    reg [31:0] pc;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            instruction <= 0;
            pc <= 0;
        end else if (flush_i) begin
            instruction <= 32'h0013; // Set to NOP (addi x0, x0, 0)
            pc <= pc_i;
        end else if (!stall_i) begin
            instruction <= instruction_i;
            pc <= pc_i;
        end
    end

    assign instruction_o = instruction;
    assign pc_o = pc;

endmodule
