module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter S0 = 2'd0;
    parameter S1 = 2'd1;
    parameter S2 = 2'd3;
    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            S0: next_state = x? S1 : S0;
            S1: next_state = x? S2 : S1;
            S2: next_state = x? S2 : S1;
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end
    
    assign z = state == S1;

endmodule
