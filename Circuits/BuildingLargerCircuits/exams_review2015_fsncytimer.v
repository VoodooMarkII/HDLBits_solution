module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
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
    reg [9:0] timer;
    wire shift_ena;
    wire done_counting;
    wire sub;
    
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
    
    always @(posedge clk) begin
        if (reset)
            count <= 4'h0;
        else if (shift_ena)
            count <= {count[2:0], data};
        else if (sub)
            count <= count - 1'b1;
        
    end
    
    
    
    always @(posedge clk) begin
        if (reset)
            timer <= 10'd999;
        else if (timer == 0)
            timer <= 10'd999;
        else if (counting)
            timer <= timer -1'b1;
    end
    assign sub = timer == 10'd0;
    assign done_counting = count == 4'h0 & sub == 1;
    
    

endmodule
