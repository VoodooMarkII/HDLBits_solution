module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg [7:0] lut;
    
    always @(posedge clk) begin
        if (enable)
            lut <= {lut[6:0], S};
    end
    
    assign Z = lut[{A,B,C}];

endmodule
