module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter NONE = 4'h0;
    parameter ONE = 4'h1;
    parameter TWO = 4'h2;
    parameter THREE = 4'h3;
    parameter FOUR = 4'h4;
    parameter FIVE = 4'h5;
    parameter SIX = 4'h6;
    parameter ERROR = 4'h7;
    parameter DISCARD = 4'h8;
    parameter FLAG = 4'h9;
    
    reg [3:0] state, next_state;
    
    always @(*) begin
        case (state)
            NONE: next_state = in? ONE : NONE;
            ONE: next_state = in? TWO : NONE;
            TWO: next_state = in? THREE : NONE;
            THREE: next_state = in? FOUR : NONE;
            FOUR: next_state = in? FIVE : NONE;
            FIVE: next_state = in? SIX : DISCARD;
            SIX: next_state = in? ERROR: FLAG;
            ERROR: next_state = in? ERROR: NONE;
            DISCARD: next_state = in? ONE : NONE;
            FLAG: next_state = in? ONE : NONE;
            default: next_state = NONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= NONE;
        else
            state <= next_state;
    end
    
    assign err = state == ERROR;
    assign flag = state == FLAG;
    assign disc = state == DISCARD;

endmodule
