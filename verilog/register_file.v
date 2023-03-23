module register_file (
    input reg clk,
    input reg reset_n,
    input reg [4:0] rs1_addr,
    input reg [4:0] rs2_addr,
    input reg [31:0] wr_data,
    input reg [4:0] wr_addr,
    input reg wr_enable,
    output [31:0] rs1,
    output [31:0] rs2
);

    reg [31:0] registers [0:31];

    assign rs1 = registers[rs1_addr];
    assign rs2 = registers[rs2_addr];

    // Writes need to be synchronous to the clock
    always @ (posedge clk or negedge reset_n) begin : write_registers
        integer i;
        if (!reset_n) begin
            registers[0] = 0;
        end 
        else if (wr_enable) begin
            if (wr_addr != 0) begin
                registers[wr_addr] <= wr_data;
            end
        end
    end

endmodule