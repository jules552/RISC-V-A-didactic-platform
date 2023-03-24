module br (
    input wire [31:0] pc,
    input wire [31:0] imm,
    input wire br_sig,
    input wire [31:0] alu_out,
    input wire [2:0] br_op,
    output reg [31:0] new_pc,
    output reg [31:0] pc_plus4
);

    `include "../parameters.vh"

    wire signed [31:0] alu_out_signed;
    always @ (*) begin
        pc_plus4 = pc + 4;

        if (br_sig) begin
            case (br_op)
                BR_BEQ : new_pc = alu_out == 0 ? pc + imm : pc + 4;
                BR_BNE : new_pc = alu_out != 0 ? pc + imm : pc + 4;
                BR_BLT : new_pc = alu_out_signed < 0 ? pc + imm : pc + 4;
                BR_BLTU : new_pc = alu_out < 0 ? pc + imm : pc + 4;
                BR_BGE : new_pc = alu_out_signed >= 0 ? pc + imm : pc + 4;
                BR_BGEU : new_pc = alu_out >= 0 ? pc + imm : pc + 4;
                BR_JALR : new_pc = alu_out & ~1;
                BR_JAL : new_pc = alu_out;
                default: new_pc = pc + 4;
            endcase
        end
        else begin
            new_pc = pc + 4;
        end
    end

endmodule