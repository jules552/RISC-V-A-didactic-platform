module br_predictor (
    input wire reset_n,
    input wire clk,

    input wire [31:0] instruction_i,
    input wire [31:0] pc_i,
    input wire br_sig_i,
    input wire miss_pred_i,

    output wire br_pred_o,
    output wire [31:0] new_pc_pred_o
);
    `include "../parameters.vh"

    // Parameters for the two-level adaptive branch predictor
    localparam PHT_SIZE = 64;  // Pattern history table size
    localparam GH_SIZE = 6;      // Global history register size

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [31:0] imm_b;
    wire [31:0] imm_j;

    reg is_branch;
    reg is_unconditional;
    reg br_pred;
    reg [31:0] new_pc_pred;

    reg [GH_SIZE-1:0] global_history;
    reg [1:0] PHT [0:PHT_SIZE-1];

    assign opcode = instruction_i[6:0];
    assign funct3 = instruction_i[14:12];
    assign imm_b = {{19{instruction_i[31]}}, instruction_i[31], instruction_i[7], instruction_i[30:25], instruction_i[11:8], 1'b0};
    assign imm_j = {{11{instruction_i[31]}}, instruction_i[31], instruction_i[19:12], instruction_i[20], instruction_i[30:21], 1'b0};

    always @ (*) begin
        is_branch = 1'b0;
        is_unconditional = 1'b0;
        new_pc_pred = pc_i + 4;

        case(opcode)
            OPCODE_BRANCH : begin
                case(funct3)
                    FUNCT3_BEQ : begin
                        is_branch = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BNE : begin
                        is_branch = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BLT : begin
                        is_branch = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BGE : begin
                        is_branch = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BLTU : begin
                        is_branch = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                    FUNCT3_BGEU : begin
                        is_branch = 1'b1;
                        new_pc_pred = pc_i + imm_b;
                    end
                endcase
            end

            OPCODE_JAL : begin
                is_branch = 1'b1;
                is_unconditional = 1'b1;
                new_pc_pred = pc_i + imm_j;
            end
            /**
            * JALR is not present here cause JALR uses rs1 to compute the new PC
            * and the branch predictor cannot know the value of rs1 because it could
            * be modified by a previous instruction that hasn't been written back yet
            **/
        endcase
    end

    // Update the branch predictor based on the actual outcome of the branch
    always @(posedge clk or negedge reset_n) begin : predict_branch
        if (!reset_n) begin : reset_pht_and_ghr
            integer i;
            global_history <= {GH_SIZE{1'b0}};
            for (i = 0; i < PHT_SIZE; i = i + 1) begin
                PHT[i] <= 2'b11; // Initialize the PHT to strongly taken
            end
        end else if (br_sig_i) begin
            if (miss_pred_i) begin
                if (PHT[global_history] > 2'b00) begin
                    PHT[global_history] <= PHT[global_history] - 1'b1;
                end
            end else begin
                if (PHT[global_history] < 2'b11) begin
                    PHT[global_history] <= PHT[global_history] + 1'b1;
                end
            end
            // Shift in the outcome of the branch into the global history register
            global_history <= {global_history[GH_SIZE-2:0], miss_pred_i};
        end
    end


    always @ (*) begin : update_pht_ghr
        br_pred = PHT[global_history][1];
    end


    assign br_pred_o = is_branch ? br_pred || is_unconditional : 1'b0;
    assign new_pc_pred_o = new_pc_pred;

endmodule
