module mux3x32 (
    input reg [31:0] a,
    input reg [31:0] b,
    input reg [31:0] c,
    input reg [1:0] sel,
    output reg [31:0] out
);
    
    always @ (*) begin
        case (sel)
            2'b00 : out = a;
            2'b01 : out = b;
            2'b10 : out = c;
            default: out = 0;
        endcase
    end
endmodule