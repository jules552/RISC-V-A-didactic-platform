module if_stage (
    input wire reset_n, clk,

    input wire [31:0] new_pc_i,
    input wire [31:0] instruction_i,
    input wire br_taken_i,
    input wire br_pred_i,
    input wire stall_i,

    output wire [31:0] pc_o,
    output wire br_pred_o,
    output wire [31:0] new_pc_pred_o,
    output wire miss_pred_o
);

    assign miss_pred_o = br_pred_i != br_taken_i;

    pc pc_inst (
        .reset_n(reset_n),
        .clk(clk),

        .new_pc(new_pc_i),
        .br_pred(br_pred_o),
        .new_pc_pred(new_pc_pred_o),
        .miss_pred(miss_pred_o),
        .stall(stall_i),

        .pc(pc_o)
    );

    br_predictor br_predictor_inst (
        .instruction_i(instruction_i),
        .pc_i(pc_o),
        .miss_pred_i(miss_pred_o),

        .br_pred_o(br_pred_o),
        .new_pc_pred_o(new_pc_pred_o)
    );

endmodule