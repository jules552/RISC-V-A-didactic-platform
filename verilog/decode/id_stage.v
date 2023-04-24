module id_stage (
    input wire [31:0] instruction_i,
    input wire [31:0] pc_i,
    input wire [31:0] reg_rs1_i,
    input wire [31:0] reg_rs2_i,
    input wire [4:0] id_ex_reg_wr_addr_i,
    input wire id_ex_reg_wr_sig_i,
    input wire [4:0] ex_mem_reg_wr_addr_i,
    input wire ex_mem_reg_wr_sig_i,
    input wire [1:0] ex_mem_data_dest_i,
    input wire [31:0] ex_mem_alu_result_i,
    input wire [31:0] ex_mem_pc_plus4_i,
    input wire [4:0] mem_wb_reg_wr_addr_i,
    input wire mem_wb_reg_wr_sig_i,
    input wire [1:0] mem_wb_data_dest_i,
    input wire [31:0] mem_wb_mem_rd_data_i,
    input wire [31:0] mem_wb_alu_result_i,
    input wire [31:0] mem_wb_pc_plus4_i,

    output wire br_sig_o,
    output wire [2:0] br_op_o,
    output wire [2:0] lsu_op_o,
    output wire [4:0] alu_op_o,
    output wire [1:0] data_dest_o,
    output wire [31:0] imm_o,
    output wire [4:0] reg_addr1_o,
    output wire [4:0] reg_addr2_o,
    output wire [31:0] pc_rs1_o,
    output wire [31:0] imm_rs2_o,
    output wire [31:0] rs2_o,
    output wire [4:0] reg_wr_addr_o,
    output wire reg_wr_sig_o,
    output wire mem_wr_sig_o,
    output wire stall_o
);

    wire [1:0] data_origin;
    wire [31:0] rs1;

    mux2x32 mux_pc_rs1 (
        .a(rs1),
        .b(pc_i),
        .sel(data_origin[0]),

        .out(pc_rs1_o)
    );

    mux2x32 mux_imm_rs2 (
        .a(rs2_o),
        .b(imm_o),
        .sel(data_origin[1]),
        
        .out(imm_rs2_o)
    );

    controller controller_inst (
        .instruction_i(instruction_i),

        .br_sig_o(br_sig_o),
        .br_op_o(br_op_o),
        .lsu_op_o(lsu_op_o),
        .alu_op_o(alu_op_o),
        .data_origin_o(data_origin),
        .data_dest_o(data_dest_o),
        .imm_o(imm_o),
        .reg_addr1_o(reg_addr1_o),
        .reg_addr2_o(reg_addr2_o),
        .reg_wr_addr_o(reg_wr_addr_o),
        .reg_wr_sig_o(reg_wr_sig_o),
        .mem_wr_sig_o(mem_wr_sig_o)
    );

    stall_unit stall_unit_inst (
        .reg_rs1_addr_i(reg_addr1_o),
        .reg_rs2_addr_i(reg_addr2_o),
        .id_ex_reg_wr_addr_i(id_ex_reg_wr_addr_i),
        .id_ex_reg_wr_sig_i(id_ex_reg_wr_sig_i),
        .ex_mem_reg_wr_addr_i(ex_mem_reg_wr_addr_i),
        .ex_mem_reg_wr_sig_i(ex_mem_reg_wr_sig_i),
        .ex_mem_data_dest_i(ex_mem_data_dest_i),

        .stall_o(stall_o)
    );

    forward_controller forward_controller_inst (
        .reg_addr1_i(reg_addr1_o),
        .reg_rs1_i(reg_rs1_i),
        .reg_addr2_i(reg_addr2_o),
        .reg_rs2_i(reg_rs2_i),

        .ex_mem_reg_wr_addr_i(ex_mem_reg_wr_addr_i),
        .ex_mem_reg_wr_sig_i(ex_mem_reg_wr_sig_i),
        .ex_mem_data_dest_i(ex_mem_data_dest_i),
        .ex_mem_alu_result_i(ex_mem_alu_result_i),
        .ex_mem_pc_plus4_i(ex_mem_pc_plus4_i),
        .mem_wb_reg_wr_addr_i(mem_wb_reg_wr_addr_i),
        .mem_wb_reg_wr_sig_i(mem_wb_reg_wr_sig_i),
        .mem_wb_data_dest_i(mem_wb_data_dest_i),
        .mem_wb_mem_rd_data_i(mem_wb_mem_rd_data_i),
        .mem_wb_alu_result_i(mem_wb_alu_result_i),
        .mem_wb_pc_plus4_i(mem_wb_pc_plus4_i),

        .rs1_o(rs1),
        .rs2_o(rs2_o)
    );

endmodule