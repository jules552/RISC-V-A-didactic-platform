module cpu_tb;
`include "../verilog/parameters.vh"
`timescale 1ms/10us

    // Clock
    reg clk;
    initial clk = 1;
    reg reset_n;
    initial reset_n = 0;
    always #20 clk = ~clk;

    // Signals
    wire [31:0] rom_addr;
    wire [31:0] instruction; 

    wire mem_wr_sig;
    wire [31:0] mem_wr_data;
    wire [31:0] mem_addr;
    wire [31:0] mem_rd_data;


    //ROM
    rom rom_init (
        .clk(clk),
        .reset_n(reset_n),
        .addr(rom_addr),
        .instruction(instruction)
    );


    //RAM
    ram ram_init (
        .clk(clk),
        .reset_n(reset_n),
        .wr_sig(mem_wr_sig),
        .wr_data(mem_wr_data),
        .addr(mem_addr),
        .rd_data(mem_rd_data)
    );

    //CPU Initialisation
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
    #40
    reset_n = 1;

    #15000
    $stop;
end

endmodule