module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter S = 0;
    parameter S1= 1;
    parameter S11 = 2;
    parameter S110 = 3;
    parameter B0 = 4;
    parameter B1 = 5;
    parameter B2 = 6;
    parameter B3 = 7;
    parameter COUNT = 8;
    parameter WAIT = 9;
    
    reg [3:0] state, next_state;
    
    always @(*) begin
        case (state)
            S: next_state = data? S1 : S;
            S1: next_state = data? S11 : S;
            S11: next_state = data? S11 : S110;
            S110: next_state = data? B0 : S;
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = COUNT;
            COUNT: next_state = done_counting? WAIT : COUNT;
            WAIT: next_state = ack? S : WAIT;
            default: next_state = S;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end
    
    assign shift_ena = state == B0 | state == B1 | state == B2 | state == B3;
    assign counting = state==COUNT;
    assign done = state==WAIT;

endmodule
