localparam ALU_ADD = 'b00000;
localparam ALU_SUB = 'b00001;
localparam ALU_XOR = 'b00010;
localparam ALU_OR = 'b00011;
localparam ALU_AND = 'b00100;
localparam ALU_SSL = 'b00101;
localparam ALU_SRL = 'b00110;
localparam ALU_SRA = 'b00111;
localparam ALU_SLT = 'b01000;
localparam ALU_SLTU = 'b01001;
localparam ALU_NOP = 'b01010;
localparam ALU_MUL = 'b01011;
localparam ALU_MULH = 'b01100;
localparam ALU_MULHU = 'b01101;
localparam ALU_MULHSU = 'b01110;
localparam ALU_DIV = 'b01111;
localparam ALU_DIVU = 'b10000;
localparam ALU_REM = 'b10001;
localparam ALU_REMU = 'b10010;

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

// RV32M extension FUNCT3 and FUNCT7 parameters
localparam FUNCT3_MUL = 3'b000;
localparam FUNCT3_MULH = 3'b001;
localparam FUNCT3_MULHSU = 3'b010;
localparam FUNCT3_MULHU = 3'b011;
localparam FUNCT3_DIV = 3'b100;
localparam FUNCT3_DIVU = 3'b101;
localparam FUNCT3_REM = 3'b110;
localparam FUNCT3_REMU = 3'b111;

localparam FUNCT7_MUL_DIV_REM = 7'b0000001;
// ORIGIN DATA
localparam RS2_RS1 = 2'b00;
localparam IMM_RS1 = 2'b10;
localparam IMM_PC = 2'b11;

// DESTINATION DATA
localparam PC = 2'b00;
localparam ALU = 2'b01;
localparam MEM = 2'b10;
