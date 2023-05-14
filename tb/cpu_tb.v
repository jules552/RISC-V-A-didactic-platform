`timescale 1ms/100us

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


    rom #(.PROGRAM("programs/fibonacci.hex")) rom_init (
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
    #1
    reset_n = 1;

    #500
    if (cpu_inst.reg_file_inst.registers[3] == 55) begin
        $display("CPU: PASS FIBONACCI");
    end
    else begin
        $display("CPU: FAIL FIBONACCI");
        $display("CPU: Expected 55, got %d", cpu_inst.reg_file_inst.registers[3]);
    end
    $stop;
end
endmodule