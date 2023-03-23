`ifndef _parameters_h
`define _parameters_h
localparam ALU_ADD = 'b0000;
localparam ALU_SUB = 'b0001;
localparam ALU_XOR = 'b0010;
localparam ALU_OR = 'b0011;
localparam ALU_AND = 'b0100;
localparam ALU_SSL = 'b0101;
localparam ALU_SRL = 'b0110;
localparam ALU_SRA = 'b0111;
localparam ALU_SLT = 'b1000;
localparam ALU_SLTU = 'b1001;
localparam ALU_NOP = 'b1010;

localparam BR_BEQ = 'b0000;
localparam BR_BNE = 'b0001;
localparam BR_BLT = 'b0010;
localparam BR_BGE = 'b0011;
localparam BR_BLTU = 'b0100;
localparam BR_BGEU = 'b0101;
localparam BR_JALR = 'b0110;
localparam BR_JAL = 'b0111;

localparam LSU_LB = 'b0000;
localparam LSU_LH = 'b0001;
localparam LSU_LW = 'b0010;
localparam LSU_LBU = 'b0011;
localparam LSU_LHU = 'b0100;
localparam LSU_SB = 'b0101;
localparam LSU_SH = 'b0110;
localparam LSU_SW = 'b0111;

localparam OPCODE_LOAD = 7'b0000011;
localparam OPCODE_STORE = 7'b0100011;
localparam OPCODE_BRANCH = 7'b1100011;
localparam OPCODE_IMM_ARITH = 7'b0010011;
localparam OPCODE_ARITH = 7'b0110011;
localparam OPCODE_JALR = 7'b1100111;
localparam OPCODE_JAL = 7'b1101111;
localparam OPCODE_LUI = 7'b0110111;
localparam OPCODE_AUIPC = 7'b0010111;
localparam OPCODE_SYSTEM = 7'b1110011;
localparam OPCODE_FENCE = 7'b0001111;

localparam FUNCT3_ADD_SUB = 3'b000;
localparam FUNCT3_SLL = 3'b001;
localparam FUNCT3_SLT = 3'b010;
localparam FUNCT3_SLTU = 3'b011;
localparam FUNCT3_XOR = 3'b100;
localparam FUNCT3_SRL_SRA = 3'b101;
localparam FUNCT3_OR = 3'b110;
localparam FUNCT3_AND = 3'b111;

localparam FUNCT3_ADDI = 3'b000;
localparam FUNCT3_SLTI = 3'b010;
localparam FUNCT3_SLTIU = 3'b011;
localparam FUNCT3_XORI = 3'b100;
localparam FUNCT3_ORI = 3'b110;
localparam FUNCT3_ANDI = 3'b111;
localparam FUNCT3_SLLI = 3'b001;
localparam FUNCT3_SRLI_SRAI = 3'b101;

localparam FUNCT3_LB = 3'b000;
localparam FUNCT3_LH = 3'b001;
localparam FUNCT3_LW = 3'b010;
localparam FUNCT3_LBU = 3'b100;
localparam FUNCT3_LHU = 3'b101;

localparam FUNCT3_SB = 3'b000;
localparam FUNCT3_SH = 3'b001;
localparam FUNCT3_SW = 3'b010;

localparam FUNCT3_BEQ = 3'b000;
localparam FUNCT3_BNE = 3'b001;
localparam FUNCT3_BLT = 3'b100;
localparam FUNCT3_BGE = 3'b101;
localparam FUNCT3_BLTU = 3'b110;
localparam FUNCT3_BGEU = 3'b111;

localparam FUNCT7_ADD = 7'b0000000;
localparam FUNCT7_SUB = 7'b0100000;

localparam FUNCT7_SRL = 7'b0000000;
localparam FUNCT7_SRA = 7'b0100000;

localparam FUNCT7_SRLI = 7'b0000000;
localparam FUNCT7_SRAI = 7'b0100000;

// ORIGIN DATA
localparam RS2_RS1 = 2'b00;
localparam IMM_RS1 = 2'b10;
localparam IMM_PC = 2'b11;

// DESTINATION DATA
localparam PC = 2'b00;
localparam ALU = 2'b01;
localparam MEM = 2'b10;
`endif
