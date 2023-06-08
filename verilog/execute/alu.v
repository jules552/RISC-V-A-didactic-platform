module alu (
    input wire [31:0] a,b,
    input wire [4:0] alu_op,
    
    output reg [31:0] result
);

    wire signed [31:0] a_signed = a;
    wire signed [31:0] b_signed = b;

    `include "../parameters.vh"

    always @ (*) begin
        case (alu_op)
            ALU_ADD : result = a + b;
            ALU_SUB : result = a - b;
            ALU_XOR : result = a ^ b;
            ALU_OR : result = a | b;
            ALU_AND : result = a & b;
            ALU_SSL : result = a << b;
            ALU_SRL : result = a >> b;
            ALU_SRA : result = a_signed >>> b;
            ALU_SLT : result = a_signed < b_signed;
            ALU_SLTU : result = a < b;
            ALU_NOP : result = a; 

            // RV32M extension instructions
            ALU_MUL: result = a * b;
            ALU_MULH: result = (a_signed * b_signed) >>> 32;
            ALU_MULHSU: result = (a_signed * b) >>> 32;
            ALU_MULHU: result = (a * b) >> 32;
            ALU_DIV: begin
                if (b == 0) result = -1;
                else if (a == 32'h80000000 && b == -1) result = 32'h80000000;
                else result = a_signed / b_signed;
            end
            ALU_DIVU: result = (b == 0) ? -1 : a / b;
            ALU_REM: begin
                if (b == 0) result = a;
                else if (a == 32'h80000000 && b == -1) result = 0;
                else result = a_signed % b_signed;
            end
            ALU_REMU: result = (b == 0) ? a : a % b;

            default:
                result = 0;
        endcase
    end
endmodule
