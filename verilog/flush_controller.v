module flush_controller (
    input wire clk,
    input wire reset_n,
    
    input wire br_taken_i,

    output wire flush_o
);
    reg flush;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            flush <= 0;
        // We cannot take two branches in a row, so we can safely flush
        end else if (flush) begin
            flush <= 0;
        end else begin
            flush <= br_taken_i;
        end
    end

    assign flush_o = flush;
endmodule



