module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    integer i;
    
    reg [31:0] in_d;
    
    always @(posedge clk) begin
        in_d <= in;
        for (i=0; i<32; i=i+1) begin
            if (reset)
                out[i] <= 1'b0;
        	else if (~in[i] & in_d[i])
                out[i]<= 1'b1;
        end
    end

endmodule
