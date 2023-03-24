module ram (
    input clk,
    input reset_n,
    input wr_sig,
    input [31:0] wr_data,
    input [31:0] addr,
    output reg [31:0] rd_data
);

reg [31:0] mem [0:1023];

always @(*) begin : read 
    rd_data <= mem[addr >> 2];
end

always @(posedge clk or negedge reset_n) begin : ram
    integer i;
    if (!reset_n) begin
        for (i = 0; i < 1023; i = i+1) begin
            mem[i] <= 0;
        end
    end else begin
        if (wr_sig) begin
            mem[addr >> 2] <= wr_data;
        end
    end
end

endmodule
