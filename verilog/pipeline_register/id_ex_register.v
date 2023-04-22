module id_ex_register (
    input wire clk,
    input wire reset_n,

    input wire [31:0] pc_i,
    input wire [31:0] rs1_i,
    input wire [31:0] rs2_i,
    input wire br_sig_i,
    input wire [2:0] br_op_i,
    input wire [2:0] lsu_op_i,
    input wire [4:0] alu_op_i,
    input wire [1:0] data_origin_i,
    input wire [1:0] data_dest_i,
    input wire [31:0] imm_i,
    input wire [4:0] reg_wr_addr_i,
    input wire reg_wr_sig_i,
    input wire mem_wr_sig_i,
    input wire stall_i,

    output wire [31:0] pc_o,
    output wire [31:0] rs1_o,
    output wire [31:0] rs2_o,
    output wire br_sig_o,
    output wire [2:0] br_op_o,
    output wire [2:0] lsu_op_o,
    output wire [4:0] alu_op_o,
    output wire [1:0] data_origin_o,
    output wire [1:0] data_dest_o,
    output wire [31:0] imm_o,
    output wire [4:0] reg_wr_addr_o,
    output wire reg_wr_sig_o,
    output wire mem_wr_sig_o
);

    reg [31:0] pc;
    reg [31:0] rs1;
    reg [31:0] rs2;
    reg br_sig;
    reg [2:0] br_op;
    reg [2:0] lsu_op;
    reg [4:0] alu_op;
    reg [1:0] data_origin;
    reg [1:0] data_dest;
    reg [31:0] imm;
    reg [4:0] reg_wr_addr;
    reg reg_wr_sig;
    reg mem_wr_sig;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pc <= 32'b0;
            rs1 <= 32'b0;
            rs2 <= 32'b0;
            br_sig <= 1'b0;
            br_op <= 3'b0;
            lsu_op <= 3'b0;
            alu_op <= 5'b0;
            data_origin <= 2'b0;
            data_dest <= 2'b0;
            imm <= 32'b0;
            reg_wr_addr <= 5'b0;
            reg_wr_sig <= 1'b0;
            mem_wr_sig <= 1'b0;
        end else if (!stall_i)begin
            pc <= pc_i;
            rs1 <= rs1_i;
            rs2 <= rs2_i;
            br_sig <= br_sig_i;
            br_op <= br_op_i;
            lsu_op <= lsu_op_i;
            alu_op <= alu_op_i;
            data_origin <= data_origin_i;
            data_dest <= data_dest_i;
            imm <= imm_i;
            reg_wr_addr <= reg_wr_addr_i;
            reg_wr_sig <= reg_wr_sig_i;
            mem_wr_sig <= mem_wr_sig_i;
        end else begin // stall condition
            data_origin <= 2'b0;
            data_dest <= 2'b0;
            imm <= 32'b0;
            reg_wr_addr <= 5'b0;
            reg_wr_sig <= 1'b0;
            mem_wr_sig <= 1'b0;
        end
    end

    assign pc_o = pc;
    assign rs1_o = rs1;
    assign rs2_o = rs2;
    assign br_sig_o = br_sig;
    assign br_op_o = br_op;
    assign lsu_op_o = lsu_op;
    assign alu_op_o = alu_op;
    assign data_origin_o = data_origin;
    assign data_dest_o = data_dest;
    assign imm_o = imm;
    assign reg_wr_addr_o = reg_wr_addr;
    assign reg_wr_sig_o = reg_wr_sig;
    assign mem_wr_sig_o = mem_wr_sig;

endmodule
