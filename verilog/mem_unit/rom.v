module rom (
    input wire clk,
    input wire reset_n,
    input reg [31:0] addr,
    output reg [31:0] instruction
);

reg [31:0] mem [0:1023];

wire [9:0] addr10 = addr[11:2];

initial begin
    $readmemh("recursive_sum_of_n.hex", mem);
    //$readmemh("fibonacci.hex", mem);
    //$readmemh("program.hex", mem);
end
always @(posedge clk) begin : rom
    instruction <= mem[addr10];
end

endmodule
