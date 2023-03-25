module cpu (
    input wire clk,
    input wire reset_n,
    input wire [31:0] instruction,
    input wire [31:0] mem_rd_data,
    output wire [31:0] rom_addr,
    output wire [31:0] mem_addr,
    output wire [31:0] mem_wr_data,
    output wire mem_wr_sig
);

    wire br_sig;
    wire [2:0] br_op;
    wire [2:0] lsu_op;
    wire [4:0] alu_op;

    wire [1:0] data_origin;
    wire [1:0] data_dest;

    wire [31:0] imm;
    wire [31:0] reg_wr_data;
    wire [4:0] reg_addr1;
    wire [4:0] reg_addr2;
    wire [4:0] reg_wr_addr;
    wire reg_wr_sig;

    wire [31:0] rs1;
    wire [31:0] rs2;

    wire [31:0] pc_rs1;
    wire [31:0] imm_rs2;
    wire [31:0] pc;
    wire [31:0] new_pc;
    wire [31:0] pc_plus4;

    wire [31:0] alu;

    wire [31:0] rd_data;

    assign rom_addr = new_pc;

    controler controler_inst (
        .instruction_i(instruction),
        .br_sig_o(br_sig),
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
        .wr_data(reg_wr_data),
        .wr_addr(reg_wr_addr),
        .wr_enable(reg_wr_sig),
        .rs1(rs1),
        .rs2(rs2)
    );

    mux2x32 mux_pc_rs1 (
        .a(rs1),
        .b(pc),
        .sel(data_origin[0]),
        .out(pc_rs1)
    );

    mux2x32 mux_imm_rs2 (
        .a(rs2),
        .b(imm),
        .sel(data_origin[1]),
        .out(imm_rs2)
    );

    alu alu_inst (
        .a(pc_rs1),
        .b(imm_rs2),
        .alu_op(alu_op),
        .result(alu)
    );

    br br_inst (
        .pc(pc),
        .imm(imm),
        .br_sig(br_sig),
        .alu_out(alu),
        .br_op(br_op),
        .new_pc(new_pc),
        .pc_plus4(pc_plus4)
    );

    lsu lsu_inst (
        .lsu_op(lsu_op),
        .addr(alu),
        .wr_data(rs2),
        .mem_rd_data(mem_rd_data),
        .rd_data(rd_data),
        .mem_addr(mem_addr),
        .mem_wr_data(mem_wr_data)
    );

    mux3x32 data_written_back (
        .a(pc_plus4),
        .b(alu),
        .c(rd_data),
        .sel(data_dest),
        .out(reg_wr_data)
    );

    pc pc_inst (
        .clk(clk),
        .reset_n(reset_n),
        .pc(pc),
        .new_pc(new_pc)
    );

endmodule