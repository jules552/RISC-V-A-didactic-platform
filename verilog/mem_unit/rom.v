module rom (
    input clk,
    input [31:0] addr,
    output reg [31:0] instuction
);

wire [9:0] addr10;
parameter [31:0] MEM_INIT [0:1023];

assign addr10 = addr[9:0];

reg [31:0] mem [0:1023];

initial begin : rom_init
    integer i;
    for (i = 0; i < 1023; i = i+1) begin
        mem[i] = MEM_INIT[i];
    end
end

always @(posedge clk) begin
    instuction <= mem[addr10];
end

endmodule
