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

    `include "parameters.vh"

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1;
    wire [4:0] rs2;

    // Extract instruction fields
    assign opcode = instruction_i[6:0];
    assign funct3 = instruction_i[14:12];
    assign funct7 = instruction_i[31:25];
    assign rs1 = instruction_i[19:15];
    assign rs2 = instruction_i[24:20];
    assign shamt = instruction_i[24:20];

    always @ (instruction_i) begin
        case (opcode)
            default : $display("Invalid opcode: %b", opcode); 
            OPCODE_IMM_ARITH : begin
                case (funct3)
                    FUNCT3_ADDI : begin
                        alu_op_o = ALU_ADD;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_SLTI : begin
                        alu_op_o = ALU_SLT;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_SLTIU : begin
                        alu_op_o = ALU_SLTU;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_XORI : begin
                        alu_op_o = ALU_XOR;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_ORI : begin
                        alu_op_o = ALU_OR;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_ANDI : begin
                        alu_op_o = ALU_AND;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_SLLI : begin
                        alu_op_o = ALU_SSL;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_SRLI_SRAI : begin
                        case (funct7) 
                            FUNCT7_SRLI : begin
                                alu_op_o = ALU_SRL;
                                data_origin_o = 2'b01;
                                data_dest_o = 2'b10;
                            end
                            FUNCT7_SRAI : begin
                                alu_op_o = ALU_SRA;
                                data_origin_o = 2'b01;
                                data_dest_o = 2'b10;
                            end
                            default : $display("Invalid funct7: %b", funct7);
                        endcase
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_ARITH : begin
                case (funct3)
                    FUNCT3_ADD_SUB : begin
                        case (funct7)
                            FUNCT7_ADD : begin
                                alu_op_o = ALU_ADD;
                                data_origin_o = 2'b01;
                                data_dest_o = 2'b10;
                            end
                            FUNCT7_SUB : begin
                                alu_op_o = ALU_SUB;
                                data_origin_o = 2'b01;
                                data_dest_o = 2'b10;
                            end
                            default : $display("Invalid funct7: %b", funct7);
                        endcase
                    end
                    FUNCT3_SLL : begin
                        alu_op_o = ALU_SSL;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_SLT : begin
                        alu_op_o = ALU_SLT;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_SLTU : begin
                        alu_op_o = ALU_SLTU;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_XOR : begin
                        alu_op_o = ALU_XOR;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_SRL_SRA : begin
                        case (funct7)
                            FUNCT7_SRL : begin
                                alu_op_o = ALU_SRL;
                                data_origin_o = 2'b01;
                                data_dest_o = 2'b10;
                            end
                            FUNCT7_SRA : begin
                                alu_op_o = ALU_SRA;
                                data_origin_o = 2'b01;
                                data_dest_o = 2'b10;
                            end
                            default : $display("Invalid funct7: %b", funct7);
                        endcase
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_LOAD : begin
                case (funct3)
                    FUNCT3_LB : begin
                        mem_op_o = MEM_LB;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_LH : begin
                        mem_op_o = MEM_LH;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_LW : begin
                        mem_op_o = MEM_LW;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_LBU : begin
                        mem_op_o = MEM_LBU;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    FUNCT3_LHU : begin
                        mem_op_o = MEM_LHU;
                        data_origin_o = 2'b01;
                        data_dest_o = 2'b10;
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_STORE : begin
                case (funct3)
                    FUNCT3_SB : begin
                        mem_op_o = MEM_SB;
                        data_origin_o = 2'b11;
                    end
                    FUNCT3_SH : begin
                        mem_op_o = MEM_SH;
                        data_origin_o = 2'b11;
                    end
                    FUNCT3_SW : begin
                        mem_op_o = MEM_SW;
                        data_origin_o = 2'b11;
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase
            end

            OPCODE_BRANCH : begin
                case (funct3)
                    FUNCT3_BEQ : begin
                        br_op_o = BR_BEQ;
                        data_origin_o = 2'b11;
                    end
                    FUNCT3_BNE : begin
                        br_op_o = BR_BNE;
                        data_origin_o = 2'b11;
                    end
                    FUNCT3_BLT : begin
                        br_op_o = BR_BLT;
                        data_origin_o = 2'b11;
                    end
                    FUNCT3_BGE : begin
                        br_op_o = BR_BGE;
                        data_origin_o = 2'b11;
                    end
                    FUNCT3_BLTU : begin
                        br_op_o = BR_BLTU;
                        data_origin_o = 2'b11;
                    end
                    FUNCT3_BGEU : begin
                        br_op_o = BR_BGEU;
                        data_origin_o = 2'b11;
                    end
                    default : $display("Invalid funct3: %b", funct3);
                endcase

                br_sig_o = 1'b1;
            end

            OPCODE_JALR : begin
                br_op_o = BR_JALR;
                br_sig_o = 1'b1;
                data_origin_o = 2'b01;
                data_dest_o = 2'b10;
            end

            OPCODE_JAL : begin
                br_op_o = BR_JAL;
                br_sig_o = 1'b1;
                data_dest_o = 2'b10;
            end

            OPCODE_LUI : begin
                alu_op_o = ALU_LUI;
                data_dest_o = 2'b10;
            end

            OPCODE_AUIPC : begin
                alu_op_o = ALU_AUIPC;
                data_dest_o = 2'b10;
            end

            OPCODE_SYSTEM : begin
                // EBREAK and ECALL
                // Not needed for the project
            end

            OPCODE_FENCE : begin
                // FENCE
                // Not needed for the project
            end            
        endcase
    end

    

endmodule