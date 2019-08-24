module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter WAIT4S = 4'h0;
    parameter RCV0 = 4'h1;
    parameter RCV1 = 4'h2;
    parameter RCV2 = 4'h3;
    parameter RCV3 = 4'h4;
    parameter RCV4 = 4'h5;
    parameter RCV5 = 4'h6;
    parameter RCV6 = 4'h7;
    parameter RCV7 = 4'h8;
    parameter CHK_STOP = 4'h9;
    parameter OKAY = 4'ha;
    parameter ERR = 4'hb;
    
    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            WAIT4S: next_state = in? WAIT4S : RCV0;
            RCV0: next_state = RCV1;
            RCV1: next_state = RCV2;
            RCV2: next_state = RCV3;
            RCV3: next_state = RCV4;
            RCV4: next_state = RCV5;
            RCV5: next_state = RCV6;
            RCV6: next_state = RCV7;
            RCV7: next_state = CHK_STOP;
            CHK_STOP: next_state = in? OKAY : ERR;
            OKAY: next_state = in? WAIT4S : RCV0;
            ERR: next_state = in? WAIT4S : ERR;
            default: next_state = WAIT4S;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= WAIT4S;
        else
            state <= next_state;
    end
    
    assign done = state == OKAY;

endmodule
