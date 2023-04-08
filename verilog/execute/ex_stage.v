module ex_stage (
    input wire [31:0] pc_i,
    input wire [31:0] rs1_i,
    input wire [31:0] rs2_i,
    input reg br_sig_i,
    input reg [2:0] br_op_i,
    input reg [4:0] alu_op_i,
    input reg [1:0] data_origin_i,
    input reg [31:0] imm_i,

    output wire [31:0] new_pc_o,
    output wire [31:0] pc_plus4_o,
    output wire [31:0] alu_result_o
);

    wire [31:0] pc_rs1;
    wire [31:0] imm_rs2;

    mux2x32 mux_pc_rs1 (
        .a(rs1_i),
        .b(pc_i),
        .sel(data_origin_i[0]),
        .out(pc_rs1)
    );

    mux2x32 mux_imm_rs2 (
        .a(rs2_i),
        .b(imm_i),
        .sel(data_origin_i[1]),
        .out(imm_rs2)
    );

    alu alu_inst (
        .a(pc_rs1),
        .b(imm_rs2),
        .alu_op(alu_op_i),
        .result(alu_result_o)
    );

    br br_inst (
        .pc(pc_i),
        .imm(imm_i),
        .br_sig(br_sig_i),
        .br_op(br_op_i),
        .alu_out(alu_out),
        .new_pc(new_pc_o),
        .pc_plus4(pc_plus4_o)
    );

endmodule