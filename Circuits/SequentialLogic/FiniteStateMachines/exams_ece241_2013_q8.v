module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter S0 = 2'd0;
    parameter S1 = 2'd1;
    parameter S2 = 2'd2;
    
    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            S0: next_state = x? S1 : S0;
            S1: next_state = x? S1 : S2;
            S2: next_state = x? S1 : S0;
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else
            state <= next_state;
    end
    
    assign z = x & (state == S2);

endmodule
