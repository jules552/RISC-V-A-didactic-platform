`include "parameters.vh"

module alu (
    input [31:0] a,b,
    input [3:0] op_code,
    output result
);

always @ (a,b, op_code) begin
    case (op_code)
        ALU_ADD : result = a + b;
        ALU_SUB : result = a - b;
        ALU_XOR : result = a ^ b;
        ALU_OR : result = a | b;
        ALU_AND : result = a & b;
        ALU_SSL : result = a << b;
        ALU_SRL : result = a >> b;
        ALU_SRA : result = a >>> b;
        ALU_SLT : result = a < b;
        ALU_SLTU : result = a < b;
        ALU_NOP : result = a; 
        default: 
            result = 0;
    endcase
end
endmodule