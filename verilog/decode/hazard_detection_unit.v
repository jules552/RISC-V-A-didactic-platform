module hazard_detection_unit (
    input wire [4:0] reg_rs1_addr_i,
    input wire [4:0] reg_rs2_addr_i,
    input wire [4:0] ex_reg_wr_addr_i,
    input wire [4:0] mem_reg_wr_addr_i,
    input wire [4:0] wb_reg_wr_addr_i,
    input wire ex_reg_wr_sig_i,
    input wire mem_reg_wr_sig_i,
    input wire wb_reg_wr_sig_i,
    output wire hazard_detected_o
);

    wire ex_hazard;
    wire mem_hazard;
    wire wb_hazard;

    // Detect any hazard in the EX stage
    assign ex_hazard = ex_reg_wr_sig_i && (ex_reg_wr_addr_i != 5'd0) && (reg_rs1_addr_i == ex_reg_wr_addr_i || reg_rs2_addr_i == ex_reg_wr_addr_i);

    // Detect any hazard in the MEM stage
    assign mem_hazard = mem_reg_wr_sig_i && (mem_reg_wr_addr_i != 5'd0) && (reg_rs1_addr_i == mem_reg_wr_addr_i || reg_rs2_addr_i == mem_reg_wr_addr_i);

    // Detect any hazard in the WB stage
    assign wb_hazard = wb_reg_wr_sig_i && (wb_reg_wr_addr_i != 5'd0) && (reg_rs1_addr_i == wb_reg_wr_addr_i || reg_rs2_addr_i == wb_reg_wr_addr_i);

    // If any hazard is detected, then the hazard_detected_o signal is asserted
    assign hazard_detected_o = ex_hazard || mem_hazard || wb_hazard;
endmodule