module alu (
    input reg [31:0] a,b,
    input reg [4:0] alu_op,
    output reg [31:0] result
);

    `include "../parameters.vh"

    always @ (*) begin
        case (alu_op)
            ALU_ADD : result = $unsigned(a) + $unsigned(b);
            ALU_SUB : result = $unsigned(a) - $unsigned(b);
            ALU_XOR : result = a ^ b;
            ALU_OR : result = a | b;
            ALU_AND : result = a & b;
            ALU_SSL : result = a << b;
            ALU_SRL : result = a >> b;
            ALU_SRA : result = a >>> b;
            ALU_SLT : result = $signed(a) < $signed(b);
            ALU_SLTU : result = $unsigned(a) < $unsigned(b);
            ALU_NOP : result = a; 

            // RV32M extension instructions
            ALU_MUL: result = a * b;
            ALU_MULH: result = ($signed(a) * $signed(b)) >>> 32;
            ALU_MULHSU: result = ($signed(a) * $unsigned(b)) >>> 32;
            ALU_MULHU: result = ($unsigned(a) * $unsigned(b)) >>> 32;
            ALU_DIV: result = (b == 0) ? 32'hFFFFFFFF : $signed(a) / $signed(b);
            ALU_DIVU: result = (b == 0) ? 32'hFFFFFFFF : $unsigned(a) / $unsigned(b);
            ALU_REM: result = (b == 0) ? a : $signed(a) % $signed(b);
            ALU_REMU: result = (b == 0) ? a : $unsigned(a) % $unsigned(b);
            
            default:
                result = 0;
        endcase
    end

    

endmodule