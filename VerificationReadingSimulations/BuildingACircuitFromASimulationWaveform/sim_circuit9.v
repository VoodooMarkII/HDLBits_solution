module top_module (
    input clk,
    input a,
    output [3:0] q );
    
    reg [3:0] count;
    
    always @(posedge clk) begin
        if (a)
            q <= 4'h4;
        else if (q == 4'h6)
            q <= 4'h0;
        else
            q <= q + 1'b1;
    end
    

endmodule
