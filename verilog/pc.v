module pc (
    input reset_n, clk,
    input [31:0] new_pc,
    output [31:0] pc
);

reg [31:0] pc_reg;

// We change the PC on the rising edge of the clock
always @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        pc_reg = 0;
    end
    else begin
        pc_reg = new_pc;
    end
end

endmodule
