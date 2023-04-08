module mem_stage (
    input wire [2:0] lsu_op_i,
    input wire [31:0] addr_i,
    input wire [31:0] wr_data_i,
    input wire [31:0] mem_rd_data_i,
    output wire [31:0] mem_rd_data_o,
    output wire [31:0] mem_addr_o,
    output wire [31:0] mem_wr_data_o
);

    lsu lsu_inst (
        .lsu_op(lsu_op_i),
        .addr(addr_i),
        .wr_data(wr_data_i),
        .mem_rd_data(mem_rd_data_i),
        .rd_data(mem_rd_data_o),
        .mem_addr(mem_addr_o),
        .mem_wr_data(mem_wr_data_o)
    );

endmodule