localparam ALU_ADD = 5'b00000;
localparam ALU_SUB = 5'b00001;
localparam ALU_XOR = 5'b00010;
localparam ALU_OR = 5'b00011;
localparam ALU_AND = 5'b00100;
localparam ALU_SSL = 5'b00101;
localparam ALU_SRL = 5'b00110;
localparam ALU_SRA = 5'b00111;
localparam ALU_SLT = 5'b01000;
localparam ALU_SLTU = 5'b01001;
localparam ALU_NOP = 5'b01010;
localparam ALU_MUL = 5'b01011;
localparam ALU_MULH = 5'b01100;
localparam ALU_MULHU = 5'b01101;
localparam ALU_MULHSU = 5'b01110;
localparam ALU_DIV = 5'b01111;
localparam ALU_DIVU = 5'b10000;
localparam ALU_REM = 5'b10001;
localparam ALU_REMU = 5'b10010;

localparam BR_BEQ = 4'b0000;
localparam BR_BNE = 4'b0001;
localparam BR_BLT = 4'b0010;
localparam BR_BGE = 4'b0011;
localparam BR_BLTU = 4'b0100;
localparam BR_BGEU = 4'b0101;
localparam BR_JALR = 4'b0110;
localparam BR_JAL = 4'b0111;

localparam LSU_LB = 4'b0000;
localparam LSU_LH = 4'b0001;
localparam LSU_LW = 4'b0010;
localparam LSU_LBU = 4'b0011;
localparam LSU_LHU = 4'b0100;
localparam LSU_SB = 4'b0101;
localparam LSU_SH = 4'b0110;
localparam LSU_SW = 4'b0111;

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

// FORWARDING
localparam NO_FORWARD = 1'b0;
localparam FORWARD = 1'b1;
