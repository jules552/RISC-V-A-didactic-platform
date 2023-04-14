module id_stage (
    input wire [31:0] instruction_i,
    input wire [4:0] ex_reg_wr_addr_i,
    input wire [4:0] mem_reg_wr_addr_i,
    input wire [4:0] wb_reg_wr_addr_i,
    input wire ex_reg_wr_sig_i,
    input wire mem_reg_wr_sig_i,
    input wire wb_reg_wr_sig_i,

    output wire br_sig_o,
    output wire [2:0] br_op_o,
    output wire [2:0] lsu_op_o,
    output wire [4:0] alu_op_o,
    output wire [1:0] data_origin_o,
    output wire [1:0] data_dest_o,
    output wire [31:0] imm_o,
    output wire [4:0] reg_addr1_o,
    output wire [4:0] reg_addr2_o,
    output wire [4:0] reg_wr_addr_o,
    output wire reg_wr_sig_o,
    output wire mem_wr_sig_o,
    output wire hazard_detected_o
);

    controller controller_inst (
        .instruction_i(instruction_i),

        .br_sig_o(br_sig_o),
        .br_op_o(br_op_o),
        .lsu_op_o(lsu_op_o),
        .alu_op_o(alu_op_o),
        .data_origin_o(data_origin_o),
        .data_dest_o(data_dest_o),
        .imm_o(imm_o),
        .reg_addr1_o(reg_addr1_o),
        .reg_addr2_o(reg_addr2_o),
        .reg_wr_addr_o(reg_wr_addr_o),
        .reg_wr_sig_o(reg_wr_sig_o),
        .mem_wr_sig_o(mem_wr_sig_o)
    );

    hazard_detection_unit hazard_detection_unit_inst (
        .reg_rs1_addr_i(reg_addr1_o),
        .reg_rs2_addr_i(reg_addr2_o),
        .ex_reg_wr_addr_i(ex_reg_wr_addr_i),
        .mem_reg_wr_addr_i(mem_reg_wr_addr_i),
        .wb_reg_wr_addr_i(wb_reg_wr_addr_i),
        .ex_reg_wr_sig_i(ex_reg_wr_sig_i),
        .mem_reg_wr_sig_i(mem_reg_wr_sig_i),
        .wb_reg_wr_sig_i(wb_reg_wr_sig_i),

        .hazard_detected_o(hazard_detected_o)
    );

endmodule