`timescale 1ms/1us

module cpu_tb;
`include "../verilog/parameters.vh"

    // Clock
    reg clk;
    initial clk = 1;
    reg reset_n;
    initial reset_n = 0;
    always #0.5 clk = ~clk;

    wire [31:0] rom_addr;
    wire [31:0] instruction; 

    wire mem_wr_sig;
    wire [31:0] mem_wr_data;
    wire [31:0] mem_addr;
    wire [31:0] mem_rd_data;


    rom rom_init (
        .clk(clk),
        .reset_n(reset_n),
        .addr(rom_addr),
        .instruction(instruction)
    );

    ram ram_init (
        .clk(clk),
        .reset_n(reset_n),
        .wr_sig(mem_wr_sig),
        .wr_data(mem_wr_data),
        .addr(mem_addr),
        .rd_data(mem_rd_data)
    );

    cpu cpu_inst (
        .clk(clk),
        .reset_n(reset_n),
        .instruction(instruction),
        .mem_rd_data(mem_rd_data),
        .mem_wr_sig(mem_wr_sig),
        .mem_wr_data(mem_wr_data),
        .mem_addr(mem_addr),
        .rom_addr(rom_addr)
    );

    initial begin
        $dumpfile("vcd/dump.vcd");
        $dumpvars(0, cpu_tb);
      
        #1
        reset_n = 1;

        #500

        // if (cpu_inst.reg_file_inst.registers[29] == 55) begin
        //     $display("cpu: pass recursive sum of n");
        // end
        // else begin : fail
        //     $display("cpu: fail recursive sum of n");
        //     $display("cpu: expected 55, got %d", cpu_inst.reg_file_inst.registers[29]);
        // end
        $finish;
    end
endmodule