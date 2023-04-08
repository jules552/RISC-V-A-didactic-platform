module br (
    input wire [31:0] pc,
    input wire [31:0] imm,
    input wire br_sig,
    input wire [31:0] alu_out,
    input wire [2:0] br_op,
    output reg [31:0] new_pc,
    output reg [31:0] pc_plus4,
    output reg br_taken
);

    `include "../parameters.vh"

    wire signed [31:0] alu_out_signed = alu_out;

    always @ (*) begin
        pc_plus4 = pc + 4;
        new_pc = pc_plus4;
        br_taken = 0;

        if (br_sig) begin
            case (br_op)
                BR_BEQ : begin 
                    if (alu_out == 0) begin
                        new_pc = pc + imm;
                        br_taken = 1;
                    end
                end
                BR_BNE : begin
                    if (alu_out != 0) begin
                        new_pc = pc + imm;
                        br_taken = 1;
                    end
                end
                BR_BLT : begin
                    if (alu_out_signed < 0) begin
                        new_pc = pc + imm;
                        br_taken = 1;
                    end
                end
                BR_BLTU : begin
                    if (alu_out < 0) begin
                        new_pc = pc + imm;
                        br_taken = 1;
                    end
                end
                BR_BGE : begin
                    if (alu_out_signed >= 0) begin
                        new_pc = pc + imm;
                        br_taken = 1;
                    end
                end
                BR_BGEU : begin
                    if (alu_out >= 0) begin
                        new_pc = pc + imm;
                        br_taken = 1;
                    end
                end
                BR_JALR : begin
                    new_pc = alu_out & ~1;
                    br_taken = 1;
                end
                BR_JAL : begin 
                    new_pc = pc + imm;
                    br_taken = 1;
                end
                default: new_pc = pc + 4;
            endcase
        end
    end
endmodule