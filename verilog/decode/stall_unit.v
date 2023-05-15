module stall_unit (
    input wire [4:0] reg_rs1_addr_i,
    input wire [4:0] reg_rs2_addr_i,
    input wire [4:0] id_ex_reg_wr_addr_i,
    input wire id_ex_reg_wr_sig_i,
    input wire [1:0] id_ex_data_dest_i,

    output wire stall_o
);
    `include "../parameters.vh"

    // If the instruction if currently in the EX stage, he cannot forward the result since
    // the computation could not be finished yet
    assign stall_o = (id_ex_data_dest_i == MEM) && id_ex_reg_wr_sig_i && (id_ex_reg_wr_addr_i != 5'd0) && 
    (reg_rs1_addr_i == id_ex_reg_wr_addr_i || reg_rs2_addr_i == id_ex_reg_wr_addr_i);

endmodule