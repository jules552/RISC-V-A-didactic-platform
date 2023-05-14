module register_file (
    input wire clk,
    input wire reset_n,
    input wire [4:0] rs1_addr_i,
    input wire [4:0] rs2_addr_i,
    input wire [31:0] wr_data_i,
    input wire [4:0] wr_addr_i,
    input wire wr_enable_i,

    output wire [31:0] rs1_o,
    output wire [31:0] rs2_o
);

    reg [31:0] registers [0:31];

    assign rs1_o = registers[rs1_addr_i];
    assign rs2_o = registers[rs2_addr_i];

    // Writes need to be synchronous to the clock
    always @ (posedge clk or negedge reset_n) begin : write_registers
        integer i;
        if (!reset_n) begin
            for (i = 0; i < 32; i = i+1) begin
                registers[i] <= 0;
            end
        end 
        else if (wr_enable_i) begin
            if (wr_addr_i != 0) begin
                registers[wr_addr_i] <= wr_data_i;
            end
        end
    end

endmodule