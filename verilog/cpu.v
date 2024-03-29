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

    // Wire for IF/ID register
    wire [31:0] if_id_instruction;
    wire [31:0] if_id_pc;
    wire if_id_br_pred;

    // Wire for ID/EX register
    wire [31:0] id_ex_pc;
    wire [31:0] id_ex_imm;
    wire [31:0] id_ex_pc_rs1;
    wire [31:0] id_ex_imm_rs2;
    wire [31:0] id_ex_rs2;
    wire [2:0] id_ex_br_op;
    wire id_ex_br_sig;
    wire [2:0] id_ex_lsu_op;
    wire [1:0] id_ex_data_origin;
    wire [1:0] id_ex_data_dest;
    wire [4:0] id_ex_alu_op;
    wire [4:0] id_ex_reg_wr_addr;
    wire id_ex_reg_wr_sig;
    wire id_ex_mem_wr_sig;
    wire id_ex_br_pred;

    // Wire for EX/MEM register
    wire [31:0] ex_mem_pc_plus4;
    wire [31:0] ex_mem_alu_result;
    wire [31:0] ex_mem_rs2;
    wire [2:0] ex_mem_lsu_op;
    wire [1:0] ex_mem_data_dest;
    wire [4:0] ex_mem_reg_wr_addr;
    wire ex_mem_reg_wr_sig;
    

    // Wire for MEM/WB register
    wire [31:0] mem_wb_pc_plus4;
    wire [31:0] mem_wb_alu_result;
    wire [31:0] mem_wb_mem_rd_data;
    wire [1:0] mem_wb_data_dest;
    wire [4:0] mem_wb_reg_wr_addr;
    wire mem_wb_reg_wr_sig;

    // Other wires
    wire br_sig;
    wire [2:0] br_op;   
    wire [2:0] lsu_op;
    wire [4:0] alu_op;

    wire [1:0] data_origin;
    wire [1:0] data_dest;

    wire [31:0] imm;
    wire [31:0] pc_rs1;
    wire [31:0] imm_rs2;
    wire [31:0] rs2;
    wire [4:0] reg_addr1;
    wire [4:0] reg_addr2;
    wire [4:0] reg_wr_addr;
    wire reg_wr_sig;

    wire mem_wr_enable;

    wire stall;

    wire [31:0] new_pc;
    wire br_taken;
    wire [31:0] pc_plus4;
    wire [31:0] alu_result;

    wire [31:0] rd_data;

    wire [31:0] reg_wr_data;

    wire br_pred;
    wire miss_pred;

    // Register values
    wire [31:0] reg_rs1;
    wire [31:0] reg_rs2;


    if_stage if_stage_inst (
        .clk(clk),
        .reset_n(reset_n),

        .instruction_i(instruction),
        .new_pc_i(new_pc),
        .br_taken_i(br_taken),
        .br_sig_i(id_ex_br_sig),
        .br_pred_i(id_ex_br_pred),
        .stall_i(stall),

        .pc_o(rom_addr),
        .br_pred_o(br_pred),
        .miss_pred_o(miss_pred)
    );

    if_id_register if_id_register_inst (
        .clk(clk),
        .reset_n(reset_n),

        .instruction_i(instruction),
        .pc_i(rom_addr),
        .br_pred_i(br_pred),
        .stall_i(stall),
        .flush_i(miss_pred),

        .instruction_o(if_id_instruction),
        .pc_o(if_id_pc),
        .br_pred_o(if_id_br_pred)
);

    id_stage id_stage_inst (
        .instruction_i(if_id_instruction),
        .pc_i(if_id_pc),
        .reg_rs1_i(reg_rs1),
        .reg_rs2_i(reg_rs2),
        .id_ex_reg_wr_addr_i(id_ex_reg_wr_addr),
        .id_ex_reg_wr_sig_i(id_ex_reg_wr_sig),
        .id_ex_data_dest_i(id_ex_data_dest),
        .id_ex_alu_result_i(alu_result),
        .id_ex_pc_plus4_i(pc_plus4),

        .ex_mem_reg_wr_addr_i(ex_mem_reg_wr_addr),
        .ex_mem_reg_wr_sig_i(ex_mem_reg_wr_sig),
        .ex_mem_data_dest_i(ex_mem_data_dest),
        .ex_mem_alu_result_i(ex_mem_alu_result),
        .ex_mem_pc_plus4_i(ex_mem_pc_plus4),
        .ex_mem_mem_rd_data_i(rd_data),

        .mem_wb_reg_wr_addr_i(mem_wb_reg_wr_addr),
        .mem_wb_reg_wr_sig_i(mem_wb_reg_wr_sig),
        .mem_wb_data_dest_i(mem_wb_data_dest),
        .mem_wb_mem_rd_data_i(mem_wb_mem_rd_data),
        .mem_wb_alu_result_i(mem_wb_alu_result),
        .mem_wb_pc_plus4_i(mem_wb_pc_plus4),
        
        .br_sig_o(br_sig),
        .br_op_o(br_op),
        .alu_op_o(alu_op),
        .lsu_op_o(lsu_op),
        .data_dest_o(data_dest),
        .imm_o(imm),
        .reg_addr1_o(reg_addr1),
        .pc_rs1_o(pc_rs1),
        .reg_addr2_o(reg_addr2),
        .imm_rs2_o(imm_rs2),
        .rs2_o(rs2),
        .reg_wr_addr_o(reg_wr_addr),
        .reg_wr_sig_o(reg_wr_sig),
        .mem_wr_sig_o(mem_wr_enable),
        .stall_o(stall)
    );


    id_ex_register id_ex_register_inst (
        .clk(clk),
        .reset_n(reset_n),

        .pc_i(if_id_pc),
        .br_sig_i(br_sig),
        .br_op_i(br_op),
        .alu_op_i(alu_op),
        .lsu_op_i(lsu_op),
        .data_dest_i(data_dest),
        .imm_i(imm),
        .pc_rs1_i(pc_rs1),
        .imm_rs2_i(imm_rs2),
        .rs2_i(rs2),
        .reg_wr_addr_i(reg_wr_addr),
        .reg_wr_sig_i(reg_wr_sig),
        .mem_wr_sig_i(mem_wr_enable),
        .br_pred_i(if_id_br_pred),
        .stall_i(stall),
        .flush_i(miss_pred),
        
        .pc_o(id_ex_pc),
        .imm_o(id_ex_imm),
        .pc_rs1_o(id_ex_pc_rs1),
        .imm_rs2_o(id_ex_imm_rs2),
        .rs2_o(id_ex_rs2),
        .br_op_o(id_ex_br_op),
        .br_sig_o(id_ex_br_sig),
        .lsu_op_o(id_ex_lsu_op),
        .alu_op_o(id_ex_alu_op),
        .data_dest_o(id_ex_data_dest),
        .reg_wr_addr_o(id_ex_reg_wr_addr),
        .reg_wr_sig_o(id_ex_reg_wr_sig),
        .mem_wr_sig_o(id_ex_mem_wr_sig),
        .br_pred_o(id_ex_br_pred)
    );

    ex_stage ex_stage_inst (
        .pc_i(id_ex_pc),
        .imm_i(id_ex_imm),
        .pc_rs1_i(id_ex_pc_rs1),
        .imm_rs2_i(id_ex_imm_rs2),
        .br_op_i(id_ex_br_op),
        .br_sig_i(id_ex_br_sig),
        .alu_op_i(id_ex_alu_op),

        .new_pc_o(new_pc),
        .br_taken_o(br_taken),
        .pc_plus4_o(pc_plus4),
        .alu_result_o(alu_result)
    );

    ex_mem_register ex_mem_register_inst (
        .clk(clk),
        .reset_n(reset_n),

        .pc_plus4_i(pc_plus4),
        .alu_result_i(alu_result),
        .rs2_i(id_ex_rs2),
        .lsu_op_i(id_ex_lsu_op),
        .data_dest_i(id_ex_data_dest),
        .reg_wr_addr_i(id_ex_reg_wr_addr),
        .reg_wr_sig_i(id_ex_reg_wr_sig),
        .mem_wr_sig_i(id_ex_mem_wr_sig),

        .pc_plus4_o(ex_mem_pc_plus4),
        .alu_result_o(ex_mem_alu_result),
        .rs2_o(ex_mem_rs2),
        .lsu_op_o(ex_mem_lsu_op),
        .data_dest_o(ex_mem_data_dest),
        .reg_wr_addr_o(ex_mem_reg_wr_addr),
        .reg_wr_sig_o(ex_mem_reg_wr_sig),
        .mem_wr_sig_o(mem_wr_sig)
    );

    mem_stage mem_stage_inst (
        .lsu_op_i(ex_mem_lsu_op),
        .addr_i(ex_mem_alu_result),
        .wr_data_i(ex_mem_rs2),
        .mem_rd_data_i(mem_rd_data),

        .mem_rd_data_o(rd_data),
        .mem_addr_o(mem_addr),
        .mem_wr_data_o(mem_wr_data)
    );

    mem_wb_register mem_wb_register_inst (
        .clk(clk),
        .reset_n(reset_n),

        .pc_plus4_i(ex_mem_pc_plus4),
        .alu_result_i(ex_mem_alu_result),
        .mem_rd_data_i(rd_data),
        .data_dest_i(ex_mem_data_dest),
        .reg_wr_addr_i(ex_mem_reg_wr_addr),
        .reg_wr_sig_i(ex_mem_reg_wr_sig),

        .pc_plus4_o(mem_wb_pc_plus4),
        .alu_result_o(mem_wb_alu_result),
        .mem_rd_data_o(mem_wb_mem_rd_data),
        .data_dest_o(mem_wb_data_dest),
        .reg_wr_addr_o(mem_wb_reg_wr_addr),
        .reg_wr_sig_o(mem_wb_reg_wr_sig)
    );

    wb_stage wb_stage_inst (
        .pc_plus4_i(mem_wb_pc_plus4),
        .alu_result_i(mem_wb_alu_result),
        .mem_rd_data_i(mem_wb_mem_rd_data),
        .data_dest_i(mem_wb_data_dest),

        .reg_wr_data_o(reg_wr_data)
    );

    register_file reg_file_inst (
        .clk(clk),
        .reset_n(reset_n),

        .rs1_addr_i(reg_addr1),
        .rs2_addr_i(reg_addr2),
        .wr_data_i(reg_wr_data),
        .wr_addr_i(mem_wb_reg_wr_addr),
        .wr_enable_i(mem_wb_reg_wr_sig),

        .rs1_o(reg_rs1),
        .rs2_o(reg_rs2)
    );
endmodule