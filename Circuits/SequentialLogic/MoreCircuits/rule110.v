module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    wire [511:0] left, center, right;
    
    assign left = {1'b0,q[511:1]};
    assign right = {q[510:0],1'b0};
    assign center = q;
    
    always @(posedge clk) begin
        if (load)
           	q <= data;
        else
            q <= (~right & center) | (~left & right) | (~center & right);
    end
    
endmodule
