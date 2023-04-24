module ex_stage (
    input wire [31:0] pc_i,
    input wire [31:0] pc_rs1_i,
    input wire [31:0] imm_rs2_i,
    input reg br_sig_i,
    input reg [2:0] br_op_i,
    input reg [4:0] alu_op_i,
    input reg [31:0] imm_i,

    output wire [31:0] new_pc_o,
    output wire br_taken_o,
    output wire [31:0] pc_plus4_o,
    output wire [31:0] alu_result_o
);

    alu alu_inst (
        .a(pc_rs1_i),
        .b(imm_rs2_i),
        .alu_op(alu_op_i),

        .result(alu_result_o)
    );

    br br_inst (
        .pc(pc_i),
        .imm(imm_i),
        .br_sig(br_sig_i),
        .br_op(br_op_i),

        .new_pc(new_pc_o),
        .br_taken(br_taken_o),
        .pc_plus4(pc_plus4_o)
    );

endmodule