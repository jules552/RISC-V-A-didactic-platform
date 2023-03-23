module ram (
    input clk,
    input reset_n,
    input wr_sig,
    input [31:0] wr_data,
    input [31:0] addr,
    output reg [31:0] rd_data
);

wire [9:0] addr10;

assign addr10 = addr[11:2];

reg [31:0] mem [0:1023];

always @(posedge clk or negedge reset_n) begin : ram
    integer i;
    if (!reset_n) begin
        for (i = 0; i < 1023; i = i+1) begin
            mem[i] <= 0;
        end
    end else begin
        if (wr_sig) begin
            mem[addr10] <= wr_data;
        end
        rd_data <= mem[addr10];
    end
end

endmodule
