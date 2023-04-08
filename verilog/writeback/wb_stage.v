module wb_stage (
    input wire [31:0] pc_plus4_i,
    input wire [31:0] alu_result_i,
    input wire [31:0] mem_rd_data_i,
    input wire [1:0] data_dest_i,
    output wire [31:0] reg_wr_data_o
);

    mux3x32 data_written_back(
        .a(pc_plus4_i),
        .b(alu_result_i),
        .c(mem_rd_data_i),
        .sel(data_dest_i),
        .out(reg_wr_data_o)
    );

endmodule