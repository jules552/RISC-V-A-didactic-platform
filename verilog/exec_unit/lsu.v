module lsu (
    input reg [2:0] op_code,
    input reg [31:0] addr,
    input reg [31:0] wr_data,
    input reg [31:0] mem_rd_data,
    output reg [31:0] rd_data,
    output reg [31:0] mem_addr,
    output reg [31:0] mem_wr_data
);
    `include "../parameters.vh"

    always @ (*) begin

        //Default values
        mem_addr = addr;
        mem_wr_data = wr_data;

        case (op_code)
            LSU_LB : rd_data = {{24{mem_rd_data[7]}}, mem_rd_data[7:0]};
            LSU_LH : rd_data = {{16{mem_rd_data[15]}}, mem_rd_data[15:0]};
            LSU_LW : rd_data = mem_rd_data;
            LSU_LBU : rd_data = {24'b0, mem_rd_data[7:0]};
            LSU_LHU : rd_data = {16'b0, mem_rd_data[15:0]};
            LSU_SB : rd_data = {mem_rd_data[31:8], wr_data[7:0]};
            LSU_SH : rd_data = {mem_rd_data[31:16], wr_data[15:0]};
            LSU_SW : rd_data = wr_data;
            default:
                rd_data = 0;
        endcase
    end

endmodule