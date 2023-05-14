module mux2x32 (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire sel,
    
    output wire [31:0] out
);
    assign out = (sel == 1'b0) ? a : b;
endmodule