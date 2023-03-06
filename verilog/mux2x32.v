module mux2x32 (
    input reg [31:0] a,
    input reg [31:0] b,
    input reg sel,
    output reg [31:0] out
);
    always @ (*) begin
        case (sel)
            1'b0 : out = a;
            1'b1 : out = b;
            default: out = 0;
        endcase
    end
endmodule