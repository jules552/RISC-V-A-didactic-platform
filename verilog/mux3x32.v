module mux3x32 (
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [2:0] sel,
    output [31:0] out
);
    assign out = sel == 3'b000 ? a : sel == 3'b001 ? b : c;
endmodule