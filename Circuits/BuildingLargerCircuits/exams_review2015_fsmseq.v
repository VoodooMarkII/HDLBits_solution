module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter S0 = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;
    parameter S4 = 4;
    
    reg [2:0] state, next_state;
    
    always @(*) begin
        case (state)
            S0: next_state = data? S1 : S0;
            S1: next_state = data? S2 : S0;
            S2: next_state = data? S2 : S3;
            S3: next_state = data? S4 : S1;
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    assign start_shifting = state==S4;
            

endmodule
