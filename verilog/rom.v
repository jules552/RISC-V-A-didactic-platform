module rom (
    input wire clk,
    input wire reset_n,
    input wire [31:0] addr,
    output wire [31:0] instruction
);

reg [31:0] mem [0:1023];

wire [9:0] addr10 = addr[11:2];

initial begin
    $readmemh("programs/recursive_sum_of_n.hex", mem);
    //$readmemh("programs/fibonacci.hex", mem);
    //$readmemh("programs/program.hex", mem);
end

assign instruction = mem[addr10];

endmodule
