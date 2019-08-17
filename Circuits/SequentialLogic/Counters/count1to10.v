module top_module (
    input clk,
    input reset,
    output [3:0] q);
    
    always @(posedge clk) begin
        if (reset)
            q <= 4'h1;
        else if (q == 4'ha)
            q <= 4'h1;
        else
            q <= q + 1'b1;
    end

endmodule
