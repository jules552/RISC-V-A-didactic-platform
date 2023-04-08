module ex_mem_register (
    input wire clk,
    input wire reset_n,

    input wire [31:0] new_pc_i,
    input wire [31:0] pc_plus4_i,
    input wire [31:0] alu_result_i,
    input wire [31:0] rs2_i,
    input wire [1:0] data_dest_i,
    input wire [3:0] lsu_op_i,
    input wire [31:0] reg_wr_addr_i,
    input wire reg_wr_sig_i,
    input wire mem_wr_sig_i,

    output wire [31:0] new_pc_o,
    output wire [31:0] pc_plus4_o,
    output wire [31:0] alu_result_o,
    output wire [31:0] rs2_o,
    output wire [1:0] data_dest_o,
    output wire [3:0] lsu_op_o,
    output wire [31:0] reg_wr_addr_o,
    output wire reg_wr_sig_o,
    output wire mem_wr_sig_o
);

    reg [31:0] new_pc;
    reg [31:0] pc_plus4;
    reg [31:0] alu_result;
    reg [31:0] rs2;
    reg [1:0] data_dest;
    reg [3:0] lsu_op;
    reg [31:0] reg_wr_addr;
    reg reg_wr_sig;
    reg mem_wr_sig;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            new_pc <= 0;
            alu_result <= 0;
            rs2 <= 0;
            pc_plus4 <= 0;
            data_dest <= 0;
            lsu_op <= 0;
            new_pc <= 0;
            reg_wr_addr <= 0;
            reg_wr_sig <= 0;
            mem_wr_sig <= 0;
        end else begin
            new_pc <= new_pc_i;
            alu_result <= alu_result_i;
            rs2 <= rs2_i;
            pc_plus4 <= pc_plus4_i;
            data_dest <= data_dest_i;
            lsu_op <= lsu_op_i;
            new_pc <= new_pc_i;
            reg_wr_addr <= reg_wr_addr_i;
            reg_wr_sig <= reg_wr_sig_i;
            mem_wr_sig <= mem_wr_sig_i;
        end
    end

    assign new_pc_o = new_pc;
    assign alu_result_o = alu_result;
    assign rs2_o = rs2;
    assign pc_plus4_o = pc_plus4;
    assign data_dest_o = data_dest;
    assign lsu_op_o = lsu_op;
    assign new_pc_o = new_pc;
    assign reg_wr_addr_o = reg_wr_addr;
    assign reg_wr_sig_o = reg_wr_sig;
    assign mem_wr_sig_o = mem_wr_sig;

endmodule