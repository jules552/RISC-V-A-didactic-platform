module if_stage (
    input wire reset_n, clk,
    input wire [31:0] new_pc_i,
    input wire br_taken_i,
    input wire [31:0] instruction_i,
    output wire [31:0] pc_o
);

    pc pc_inst (
        .reset_n(reset_n),
        .clk(clk),
        .new_pc(new_pc_i),
        .br_taken(br_taken_i),
        .stall(stall_i),
        .pc(pc_o)
    );

endmodule