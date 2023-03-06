module alu (
    input reg [31:0] a,b,
    input reg [3:0] op_code,
    output reg [31:0] result
);

    `include "parameters.vh"

    always @ (*) begin
        case (op_code)
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
            default:
                result = 0;
        endcase
    end

    

endmodule