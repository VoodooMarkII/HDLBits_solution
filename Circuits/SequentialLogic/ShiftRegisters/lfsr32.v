module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    
    reg [31:0] next_q;
    
    always @(*) begin
        next_q = q[31:1];
        next_q[31] = q[0] ^ 1'b0;
        next_q[21] = q[0] ^ q[22];
        next_q[1] = q[0] ^ q[2];
        next_q[0] = q[0] ^ q[1];
    end
        
    
    always @(posedge clk) begin
        if (reset)
            q <= 32'h0000_0001;
        else
            q <= next_q;
    end

endmodule
