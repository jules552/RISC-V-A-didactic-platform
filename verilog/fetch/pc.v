module pc (
    input wire reset_n, clk,
    input wire [31:0] new_pc,
    input wire br_taken,
    input wire stall,
    output wire [31:0] pc
);

reg [31:0] pc_reg;

assign pc = pc_reg;

always @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        pc_reg = 0;
    end
    else if (br_taken) begin
        pc_reg = new_pc;
    end
    else if (stall) begin
        pc_reg = pc_reg;
    end
    else begin
        pc_reg = pc_reg + 4;
    end
end

endmodule
