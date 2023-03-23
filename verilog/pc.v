module pc (
    input wire reset_n, clk,
    input reg [31:0] new_pc,
    output reg [31:0] pc
);

// We change the PC on the rising edge of the clock
always @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        pc <= -4;
    end
    else begin
        pc <= new_pc;
    end
end

endmodule
