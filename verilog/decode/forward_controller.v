module forward_controller (
    input wire [4:0] reg_addr1_i,
    input wire [31:0] reg_rs1_i,
    input wire [4:0] reg_addr2_i,
    input wire [31:0] reg_rs2_i,

    input wire [4:0] id_ex_reg_wr_addr_i,
    input wire id_ex_reg_wr_sig_i,
    input wire [1:0] id_ex_data_dest_i,
    input wire [31:0] id_ex_alu_result_i,
    input wire [31:0] id_ex_pc_plus4_i,

    input wire [4:0] ex_mem_reg_wr_addr_i,
    input wire ex_mem_reg_wr_sig_i,
    input wire [1:0] ex_mem_data_dest_i,
    input wire [31:0] ex_mem_alu_result_i,
    input wire [31:0] ex_mem_pc_plus4_i,
    input wire [31:0] ex_mem_mem_rd_data_i,
    
    input wire [4:0] mem_wb_reg_wr_addr_i,
    input wire mem_wb_reg_wr_sig_i,
    input wire [1:0] mem_wb_data_dest_i,
    input wire [31:0] mem_wb_mem_rd_data_i,
    input wire [31:0] mem_wb_alu_result_i,
    input wire [31:0] mem_wb_pc_plus4_i,


    output wire [31:0] rs1_o,
    output wire [31:0] rs2_o
);

    `include "../parameters.vh"

    reg [31:0] rs1_forward;
    reg [31:0] rs2_forward;

    always @ (*) begin
        rs1_forward = reg_rs1_i;
        rs2_forward = reg_rs2_i;

        if (id_ex_reg_wr_sig_i && id_ex_reg_wr_addr_i != 5'd0 && id_ex_reg_wr_addr_i == reg_addr1_i) begin
            if (id_ex_data_dest_i == ALU) begin
                rs1_forward = id_ex_alu_result_i;
            end else if (id_ex_data_dest_i == PC) begin
                rs1_forward = id_ex_pc_plus4_i;
            end
        end else if (ex_mem_reg_wr_sig_i && ex_mem_reg_wr_addr_i != 5'd0 && ex_mem_reg_wr_addr_i == reg_addr1_i) begin
            if (ex_mem_data_dest_i == ALU) begin
                rs1_forward = ex_mem_alu_result_i;
            end else if (ex_mem_data_dest_i == PC) begin
                rs1_forward = ex_mem_pc_plus4_i;
            end else if (ex_mem_data_dest_i == MEM) begin
                rs1_forward = ex_mem_mem_rd_data_i;
            end
        end else if (mem_wb_reg_wr_sig_i && mem_wb_reg_wr_addr_i != 5'd0 && mem_wb_reg_wr_addr_i == reg_addr1_i) begin
            if (mem_wb_data_dest_i == ALU) begin
                rs1_forward = mem_wb_alu_result_i;
            end else if (mem_wb_data_dest_i == MEM) begin
                rs1_forward = mem_wb_mem_rd_data_i;
            end else if (mem_wb_data_dest_i == PC) begin
                rs1_forward = mem_wb_pc_plus4_i;
            end
        end
        
        if (id_ex_reg_wr_sig_i && id_ex_reg_wr_addr_i != 5'd0 && id_ex_reg_wr_addr_i == reg_addr2_i) begin
            if (id_ex_data_dest_i == ALU) begin
                rs2_forward = id_ex_alu_result_i;
            end else if (id_ex_data_dest_i == PC) begin
                rs2_forward = id_ex_pc_plus4_i;
            end
        end else if (ex_mem_reg_wr_sig_i && ex_mem_reg_wr_addr_i != 5'd0 && ex_mem_reg_wr_addr_i == reg_addr2_i) begin
            if (ex_mem_data_dest_i == ALU) begin
                rs2_forward = ex_mem_alu_result_i;
            end else if (ex_mem_data_dest_i == PC) begin
                rs2_forward = ex_mem_pc_plus4_i;
            end else if (ex_mem_data_dest_i == MEM) begin
                rs2_forward = ex_mem_mem_rd_data_i;
            end
        end else if (mem_wb_reg_wr_sig_i && mem_wb_reg_wr_addr_i != 5'd0 && mem_wb_reg_wr_addr_i == reg_addr2_i) begin
            if (mem_wb_data_dest_i == ALU) begin
                rs2_forward = mem_wb_alu_result_i;
            end else if (mem_wb_data_dest_i == MEM) begin
                rs2_forward = mem_wb_mem_rd_data_i;
            end else if (mem_wb_data_dest_i == PC) begin
                rs2_forward = mem_wb_pc_plus4_i;
            end
        end
    end

    assign rs1_o = rs1_forward;
    assign rs2_o = rs2_forward;
endmodule