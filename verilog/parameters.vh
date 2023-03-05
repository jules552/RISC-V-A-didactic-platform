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
localparam ALU_INVALID = 'b1111;


localparam OPCODE_LOAD = 7'b0000011;
localparam OPCODE_STORE = 7'b0100011;
localparam OPCODE_BRANCH = 7'b1100011;
localparam OPCODE_IMM_ARITH = 7'b0010011;
localparam OPCODE_ARITH = 7'b0110011;

localparam FUNCT3_ADD = 3'b000;
localparam FUNCT3_SUB = 3'b000;
localparam FUNCT3_SLL = 3'b001;
localparam FUNCT3_SLT = 3'b010;
localparam FUNCT3_SLTU = 3'b011;
localparam FUNCT3_XOR = 3'b100;
localparam FUNCT3_SRL = 3'b101;
localparam FUNCT3_SRA = 3'b101;
localparam FUNCT3_OR = 3'b110;
localparam FUNCT3_AND = 3'b111;
`endif
