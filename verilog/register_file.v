module register_file (
    input reg clk,
    input reg reset_n,
    input reg [4:0] rs1_addr_i,
    input reg [4:0] rs2_addr_i,
    input reg [31:0] wr_data_i,
    input reg [4:0] wr_addr_i,
    input reg wr_enable_i,
    output [31:0] rs1_o,
    output [31:0] rs2_o
);

    reg [31:0] registers [0:31];

    assign rs1_o = registers[rs1_addr_i];
    assign rs2_o = registers[rs2_addr_i];

    // Writes need to be synchronous to the clock
    always @ (posedge clk or negedge reset_n) begin : write_registers
        if (!reset_n) begin
            registers[0] <= 0;
        end else begin
            if (wr_enable_i) begin
                if (wr_addr_i != 0) begin
                    registers[wr_addr_i] <= wr_data_i;
                end
            end
        end
    end

endmodule