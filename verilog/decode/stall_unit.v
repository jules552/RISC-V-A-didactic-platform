module stall_unit (
    input wire [4:0] reg_rs1_addr_i,
    input wire [4:0] reg_rs2_addr_i,
    input wire [4:0] id_ex_reg_wr_addr_i,
    input wire id_ex_reg_wr_sig_i,
    input wire [4:0] ex_mem_reg_wr_addr_i,
    input wire ex_mem_reg_wr_sig_i,
    input wire [1:0] ex_mem_data_dest_i,

    output wire stall_o
);

    `include "../parameters.vh"

    wire id_ex_hazard;
    wire ex_mem_hazard;

    // If the instruction if currently in the EX stage, he cannot forward the result since
    // the computation could not be finished yet
    assign id_ex_hazard = id_ex_reg_wr_sig_i && (id_ex_reg_wr_addr_i != 5'd0) && (reg_rs1_addr_i == id_ex_reg_wr_addr_i || reg_rs2_addr_i == id_ex_reg_wr_addr_i);

    // If the instruction currently in the ex_mem registers is a load same story as above
    // but if the instruction is something that has been comptuted in the EX stage, then
    // we should not stall since we can forward the result
    assign ex_mem_hazard = (ex_mem_data_dest_i == MEM) && ex_mem_reg_wr_sig_i && (ex_mem_reg_wr_addr_i != 5'd0) && (reg_rs1_addr_i == ex_mem_reg_wr_addr_i || reg_rs2_addr_i == ex_mem_reg_wr_addr_i);

    // If the instruction currently in the mem_wb registers the result is already computed
    // for any of the instructions so we can forward the result and not stall

    // If any hazard is detected, then the hazard_detected_o signal is asserted
    assign stall_o = id_ex_hazard || ex_mem_hazard;
endmodule