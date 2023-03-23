module controler (
    input reg [31:0] instruction_i,

    output reg br_sig_o,
    output reg [2:0] br_op_o,
    output reg [2:0] lsu_op_o,
    output reg [3:0] alu_op_o,

    output reg [1:0] data_origin_o,
    output reg [1:0] data_dest_o,

    output reg [31:0] imm_o,
    output reg [4:0] reg_addr1_o,
    output reg [4:0] reg_addr2_o,
    output reg [4:0] reg_wr_addr_o,
    output reg reg_wr_sig_o,

    output reg mem_wr_sig_o
);

    `include "parameters.vh"

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [31:0] imm;
    wire [31:0] imm_s;
    wire [31:0] imm_b;
    wire [31:0] imm_j;
    wire [31:0] imm_u;
    wire [4:0] shamt;

    // Extract instruction fields
    assign opcode = instruction_i[6:0];
    assign funct3 = instruction_i[14:12];
    assign funct7 = instruction_i[31:25];
    assign rs1 = instruction_i[19:15];
    assign rs2 = instruction_i[24:20];
    assign rd = instruction_i[11:7];
    assign imm = {{20{instruction_i[31]}}, instruction_i[31:20]};
    assign imm_s = {{20{instruction_i[31]}}, instruction_i[31:25], instruction_i[11:7]};
    assign imm_b = {{20{instruction_i[31]}}, instruction_i[31], instruction_i[7], instruction_i[30:25], instruction_i[11:8], 1'b0};
    assign imm_j = {{12{instruction_i[31]}}, instruction_i[31], instruction_i[19:12], instruction_i[20], instruction_i[30:21]};
    assign imm_u = {instruction_i[31:12], 12'b0};
    assign shamt = instruction_i[24:20];


    always @ (*) begin
        // Default values, all signals are 0
        br_op_o = 0;
        br_sig_o = 1'b0;

        lsu_op_o = 0;

        alu_op_o = 0;

        data_origin_o = 0;
        data_dest_o = 0;

        imm_o = 0;

        reg_addr1_o = 0;
        reg_addr2_o = 0;
        reg_wr_addr_o = 0;
        reg_wr_sig_o = 1'b0;

        mem_wr_sig_o = 1'b0;

        case (opcode)
            default : $display("Invalid opcode: %b", opcode); 
            OPCODE_IMM_ARITH : begin
                data_origin_o = IMM_RS1;
                data_dest_o = ALU;
                reg_addr1_o = rs1;
                imm_o = imm;
                reg_wr_addr_o = rd;
                reg_wr_sig_o = 1'b1;

                case (funct3)
                    FUNCT3_ADDI : begin
                        alu_op_o = ALU_ADD;
                    end
                    FUNCT3_SLTI : begin
                        alu_op_o = ALU_SLT;
                    end
                    FUNCT3_SLTIU : begin
                        alu_op_o = ALU_SLTU;
                    end
                    FUNCT3_XORI : begin
                        alu_op_o = ALU_XOR;
                    end
                    FUNCT3_ORI : begin
                        alu_op_o = ALU_OR;
                    end
                    FUNCT3_ANDI : begin
                        alu_op_o = ALU_AND;
                    end
                    // The immediate for those instructions need to be masked 
                    // because the shamt (shift amount) is only the 5 LSBs
                    FUNCT3_SLLI : begin
                        alu_op_o = ALU_SSL;
                        imm_o = imm & 32'h1F;
                    end
                    FUNCT3_SRLI_SRAI : begin
                        case (funct7) 
                            FUNCT7_SRLI : begin
                                alu_op_o = ALU_SRL;
                                imm_o = imm & 32'h1F;
                            end
                            FUNCT7_SRAI : begin
                                alu_op_o = ALU_SRA;
                                imm_o = imm & 32'h1F; 
                            end
                            default : $display("Invalid funct7: %b", funct7);
                        endcase
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_ARITH : begin
                data_origin_o = RS2_RS1;
                data_dest_o = ALU;
                reg_addr1_o = rs1;
                reg_addr2_o = rs2;
                reg_wr_addr_o = rd;
                reg_wr_sig_o = 1'b1;

                case (funct3)
                    FUNCT3_ADD_SUB : begin
                        case (funct7)
                            FUNCT7_ADD : begin
                                alu_op_o = ALU_ADD;
                            end
                            FUNCT7_SUB : begin
                                alu_op_o = ALU_SUB;
                            end
                            default : $display("Invalid funct7: %b", funct7);
                        endcase
                    end
                    FUNCT3_SLL : begin
                        alu_op_o = ALU_SSL;
                    end
                    FUNCT3_SLT : begin
                        alu_op_o = ALU_SLT;
                    end
                    FUNCT3_SLTU : begin
                        alu_op_o = ALU_SLTU;
                    end
                    FUNCT3_XOR : begin
                        alu_op_o = ALU_XOR;
                    end
                    FUNCT3_SRL_SRA : begin
                        case (funct7)
                            FUNCT7_SRL : begin
                                alu_op_o = ALU_SRL;
                            end
                            FUNCT7_SRA : begin
                                alu_op_o = ALU_SRA;
                            end
                            default : $display("Invalid funct7: %b", funct7);
                        endcase
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_LOAD : begin
                alu_op_o = ALU_ADD;
                data_origin_o = IMM_RS1;
                data_dest_o = MEM;
                reg_addr1_o = rs1;
                reg_addr2_o = rs2;
                imm_o = imm;
                reg_wr_addr_o = rd;
                mem_wr_sig_o = 1'b1;

                case (funct3)
                    FUNCT3_LB : begin
                        lsu_op_o = LSU_LB;
                    end
                    FUNCT3_LH : begin
                        lsu_op_o = LSU_LH;
                    end
                    FUNCT3_LW : begin
                        lsu_op_o = LSU_LW;
                    end
                    FUNCT3_LBU : begin
                        lsu_op_o = LSU_LBU;
                    end
                    FUNCT3_LHU : begin
                        lsu_op_o = LSU_LHU;
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_STORE : begin
                alu_op_o = ALU_ADD;
                data_origin_o = IMM_RS1;
                data_dest_o = MEM;
                reg_addr1_o = rs1;
                imm_o = imm_s;
                mem_wr_sig_o = 1'b1;

                case (funct3)
                    FUNCT3_SB : begin
                        lsu_op_o = LSU_SB;
                    end
                    FUNCT3_SH : begin
                        lsu_op_o = LSU_SH;
                    end
                    FUNCT3_SW : begin
                        lsu_op_o = LSU_SW;
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_BRANCH : begin
                alu_op_o = ALU_SUB;
                data_origin_o = RS2_RS1;
                reg_addr1_o = rs1;
                reg_addr2_o = rs2;
                imm_o = imm_b;
                reg_wr_sig_o = 1'b1;
                br_sig_o = 1'b1;

                case (funct3)
                    FUNCT3_BEQ : begin
                        br_op_o = BR_BEQ;
                    end
                    FUNCT3_BNE : begin
                        br_op_o = BR_BNE;
                    end
                    FUNCT3_BLT : begin
                        br_op_o = BR_BLT;
                    end
                    FUNCT3_BGE : begin
                        br_op_o = BR_BGE;
                    end
                    FUNCT3_BLTU : begin
                        br_op_o = BR_BLTU;
                    end
                    FUNCT3_BGEU : begin
                        br_op_o = BR_BGEU;
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_JALR : begin
                alu_op_o = ALU_ADD;
                data_origin_o = IMM_RS1;
                data_dest_o = PC;
                reg_addr1_o = rs1;
                imm_o = imm;
                reg_wr_addr_o = rd;
                reg_wr_sig_o = 1'b1;
                br_sig_o = 1'b1;

                br_op_o = BR_JALR;
            end

            OPCODE_JAL : begin
                alu_op_o = ALU_ADD;
                data_origin_o = IMM_PC;
                data_dest_o = PC;
                imm_o = imm_j;
                reg_wr_addr_o = rd;
                reg_wr_sig_o = 1'b1;
                br_sig_o = 1'b1;
                
                br_op_o = BR_JAL;
            end

            OPCODE_LUI : begin
                alu_op_o = ALU_ADD;
                data_origin_o = IMM_RS1;
                data_dest_o = ALU;
                imm_o = imm_u;
                reg_addr1_o = {5{1'b0}};
                reg_wr_addr_o = rd;
                reg_wr_sig_o = 1'b1;
            end

            OPCODE_AUIPC : begin
                alu_op_o = ALU_ADD;
                data_origin_o = IMM_PC;
                data_dest_o = ALU;
                imm_o = imm_u;
                reg_wr_addr_o = rd;
                reg_wr_sig_o = 1'b1;
            end

            OPCODE_SYSTEM : begin
                // EBREAK and ECALL
                // CSR instructions
                // Not needed for the project
            end

            OPCODE_FENCE : begin
                // FENCE
                // Not needed for the project
            end            
        endcase
    end
endmodule