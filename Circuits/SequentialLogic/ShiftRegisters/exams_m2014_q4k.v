module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3:0] shifter;
    
    assign out = shifter[0];
    
    always @(posedge clk) begin
        if (~resetn)
            shifter <= 4'h0;
        else
            shifter <= {in, shifter[3:1]};
    end
            
endmodule
