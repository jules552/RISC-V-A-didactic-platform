module controler (
    input [31:0] instruction_i,

    output br_sig_o,
    output [2:0] br_op_o,
    output [3:0] mem_op_o,
    output [3:0] alu_op_o,

    output [1:0] data_origin_o,
    output [1:0] data_dest_o,

    output [31:0] imm_o,
    output [4:0] reg_addr1_o,
    output [4:0] reg_addr2_o,
    output [4:0] reg_wr_addr_o,
    output reg_wr_sig_o,

    output [31:0] mem_wr_data_o,
    output mem_wr_o;
);

    wire [6:0] opcode_i;
    wire [2:0] funct3_i;
    wire [6:0] funct7_i;
    wire [4:0] rs1_i;
    wire [4:0] rs2_i;

    // Extract instruction fields
    assign opcode_i = instruction_i[6:0];
    assign funct3_i = instruction_i[14:12];
    assign funct7_i = instruction_i[31:25];
    assign rs1_i = instruction_i[19:15];
    assign rs2_i = instruction_i[24:20];

    // Control signals for branching
    assign br_op_o = 3'b000; // Default to no branch
    assign br_sig_o = 1'b0; // Default to no branch
    case (funct3_i)
        3'b000: br_op_o = 3'b000; // BEQ
        3'b001: br_op_o = 3'b001; // BNE
        3'b100: br_op_o = 3'b100; // BLT
        3'b101: br_op_o = 3'b101; // BGE
        3'b110: br_op_o = 3'b110; // BLTU
        3'b111: br_op_o = 3'b111; // BGEU
    default: br_op_o = 3'b000; // No branch
  endcase
  assign br_sig_o = (br_op_o != 3'b000) ? 1'b1 : 1'b0;

endmodule