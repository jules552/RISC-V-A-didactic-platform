module mem_wb_register (
    input wire clk,
    input wire reset_n,

    input wire [31:0] pc_plus4_i,
    input wire [31:0] alu_result_i,
    input wire [31:0] mem_rd_data_i,
    input wire [1:0] data_dest_i,
    input wire [4:0] reg_wr_addr_i,
    input wire reg_wr_sig_i,

    output wire [31:0] pc_plus4_o,
    output wire [31:0] alu_result_o,
    output wire [31:0] mem_rd_data_o,
    output wire [1:0] data_dest_o,
    output wire [4:0] reg_wr_addr_o,
    output wire reg_wr_sig_o
);

    reg [31:0] pc_plus4;
    reg [31:0] alu_result;
    reg [31:0] mem_rd_data;
    reg [1:0] data_dest;
    reg [4:0] reg_wr_addr;
    reg reg_wr_sig;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            alu_result <= 0;
            pc_plus4 <= 0;
            mem_rd_data <= 0;
            data_dest <= 0;
            reg_wr_addr <= 0;
            reg_wr_sig <= 0;
        end else begin
            alu_result <= alu_result_i;
            pc_plus4 <= pc_plus4_i;
            mem_rd_data <= mem_rd_data_i;
            data_dest <= data_dest_i;
            reg_wr_addr <= reg_wr_addr_i;
            reg_wr_sig <= reg_wr_sig_i;
        end
    end

    assign alu_result_o = alu_result;
    assign pc_plus4_o = pc_plus4;
    assign mem_rd_data_o = mem_rd_data;
    assign data_dest_o = data_dest;
    assign reg_wr_addr_o = reg_wr_addr;
    assign reg_wr_sig_o = reg_wr_sig;
endmodule