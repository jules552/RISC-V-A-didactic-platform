module mux2x32 (
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] out
);
    always @ (a,b,sel) begin
        case (sel)
            1'b0 : out = a;
            1'b1 : out = b;
            default: out = 0;
        endcase
    end
endmodule