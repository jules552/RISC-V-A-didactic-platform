module cpu (
    input clk,
    input reset_n,
    input [31:0] instuction,
    input [31:0] mem_rd_data,
    output [31:0] pc,
    output [31:0] mem_addr,
    output [31:0] mem_wr_data,
    output wr_sig,
);

    wire br_sig;
    wire br_op;
    wire lsu_op;
    wire alu_op;

    wire [1:0] data_origin;
    wire [1:0] data_dest;

    wire [31:0] imm;
    wire [4:0] reg_addr1;
    wire [4:0] reg_addr2;
    wire [4:0] reg_wr_addr;
    wire reg_wr_sig;

    wire mem_wr_sig;

    wire rs1;
    wire rs2;

    control_unit control_unit_inst (
        .instruction_i(instuction),
        .br_sig_o(br_sig)
        .br_op_o(br_op),
        .lsu_op_o(lsu_op),
        .alu_op_o(alu_op),
        .data_origin_o(data_origin),
        .data_dest_o(data_dest),
        .imm_o(imm),
        .reg_addr1_o(reg_addr1),
        .reg_addr2_o(reg_addr2),
        .reg_wr_addr_o(reg_wr_addr),
        .reg_wr_sig_o(reg_wr_sig),
        .mem_wr_sig_o(mem_wr_sig)
    );

    register_file register_file_inst (
        .clk(clk),
        .reset_n(reset_n),
        .rs1_addr(reg_addr1),
        .rs2_addr(reg_addr2),
        .wr_data(mem_rd_data),
        .wr_addr(reg_wr_addr),
        .wr_enable(reg_wr_sig),
        .rs1(rs1),
        .rs2(rs2)
    );


endmodule