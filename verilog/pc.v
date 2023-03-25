module pc (
    input wire reset_n, clk,
    input wire [31:0] new_pc,
    output wire [31:0] pc
);

reg [31:0] pc_reg;

assign pc = pc_reg;

// We change the PC on the rising edge of the clock
always @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        pc_reg <= -4;
    end
    else begin
        pc_reg <= new_pc;
    end
end

endmodule
