module rom (
    input wire clk,
    input [31:0] addr,
    output reg [31:0] instruction
);

reg [31:0] mem [0:1023];

initial begin
    $readmemh("program.hex", mem);
end

always @(posedge clk) begin
    instruction <= mem[addr];
end

endmodule
