module br_predictor (
    input wire [31:0] instruction_i,
    input wire [31:0] pc_i,
    input wire miss_pred_i,

    output wire br_pred_o,
    output wire [31:0] new_pc_pred_o
);
    // For the moment the branch predictor only predict that the branch will be taken
    // but before that it checks if the instruction is a conditional branch
    `include "../parameters.vh"

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [31:0] imm_b;
    wire [31:0] imm_j;

    reg br_pred;
    reg [31:0] new_pc_pred;

    assign opcode = instruction_i[6:0];
    assign funct3 = instruction_i[14:12];
    assign imm_b = {{19{instruction_i[31]}}, instruction_i[31], instruction_i[7], instruction_i[30:25], instruction_i[11:8], 1'b0};
    assign imm_j = {{11{instruction_i[31]}}, instruction_i[31], instruction_i[19:12], instruction_i[20], instruction_i[30:21], 1'b0};

    always @ (*) begin
        case(opcode)
            OPCODE_BRANCH : begin
                case(funct3)
                    FUNCT3_BEQ : begin
                        br_pred = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BNE : begin
                        br_pred = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BLT : begin
                        br_pred = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BGE : begin
                        br_pred = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BLTU : begin
                        br_pred = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BGEU : begin
                        br_pred = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    default : begin
                        br_pred = 1'b0;
                        new_pc_pred = pc_i + 4;
                    end
                endcase
            end

            OPCODE_JAL : begin
                br_pred = 1'b1;
                new_pc_pred = pc_i + imm_j;
            end
            /**
            * JALR is not present here cause JALR uses rs1 to compute the new PC
            * and the branch predictor cannot know the value of rs1 because it could
            * be modified by a previous instruction that hasn't been written back yet
            **/
            default : begin
                br_pred = 1'b0;
                new_pc_pred = pc_i + 4;
            end
        endcase
    end

    assign br_pred_o = br_pred;
    assign new_pc_pred_o = new_pc_pred;

endmodule