module rom #(
    parameter PROGRAM = "programs/recursive_sum_of_n.hex",
    parameter PROGRAM_SIZE = 1024
) (
    input wire clk,
    input wire reset_n,
    input wire [31:0] addr,
    output wire [31:0] instruction
);

reg [31:0] mem [0:1023];

wire [9:0] addr10 = addr[11:2];

initial begin
    $readmemh(PROGRAM, mem, 0, PROGRAM_SIZE - 1);
end

assign instruction = mem[addr10];

endmodule
