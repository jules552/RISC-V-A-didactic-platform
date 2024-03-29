module ram (
    input clk,
    input reset_n,
    input wr_sig,
    input [31:0] wr_data,
    input [31:0] addr,
    output reg [31:0] rd_data
);

reg [31:0] mem [0:1023];

wire [9:0] addr10 = addr[11:2];

always @(*) begin : read 
    rd_data = mem[addr10];
end

always @(posedge clk or negedge reset_n) begin : ram
    if (wr_sig) begin
        mem[addr10] <= wr_data;
    end
end

endmodule
