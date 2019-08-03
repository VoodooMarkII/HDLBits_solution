module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    
    always @(*) begin
        case ({x3, x2, x1})
            3'd2: f = 1;
            3'd3: f = 1;
            3'd5: f = 1;
            3'd7: f = 1;
            default: f = 0;
        endcase
    end

endmodule
