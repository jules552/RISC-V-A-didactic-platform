module ram (
    input clk,
    input reset_n,
    input wr_en,
    input [31:0] wr_data,
    input [31:0] wr_addr,
    input [31:0] rd_addr,
    output reg [31:0] rd_data
);

wire [9:0] wr_addr10;
wire [9:0] rd_addr10;

assign wr_addr10 = wr_addr[9:0];
assign rd_addr10 = rd_addr[9:0];

reg [31:0] mem [0:1023];

always @(posedge clk) begin : ram
    integer i;
    if (!reset_n) begin
        for (i = 0; i < 1023; i = i+1) begin
            mem[i] <= 0;
        end
    end else begin
        if (wr_en) begin
            mem[wr_addr10] <= wr_data;
        end
        rd_data <= mem[rd_addr10];
    end
end

endmodule
