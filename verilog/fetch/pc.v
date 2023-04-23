module pc (
    input wire reset_n, clk,

    input wire [31:0] new_pc,
    input wire br_pred,
    input wire [31:0] new_pc_pred,
    input wire miss_pred,
    input wire stall,

    output wire [31:0] pc
);

reg [31:0] pc_reg;

assign pc = pc_reg;

always @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        pc_reg = 0;
    end
    else if (miss_pred) begin
        pc_reg = new_pc;
    end
    else if (stall) begin
        pc_reg = pc_reg;
    end
    else if (br_pred) begin
        pc_reg = new_pc_pred;
    end
    else begin
        pc_reg = pc_reg + 4;
    end
end

endmodule
