module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    parameter RCV1 = 2'd0;
    parameter RCV2 = 3'd1;
    parameter RCV3 = 3'd2;
    parameter RCV_DONE = 3'd3;
    parameter RCV_ERR = 3'd4;
    
    reg [2:0] state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            RCV1: next_state = in[3]? RCV2 :RCV1;
            RCV2: next_state = RCV3;
            RCV3: next_state = RCV_DONE;
            RCV_DONE: next_state = in[3]? RCV2 : RCV_ERR;
            RCV_ERR: next_state = in[3]? RCV2 : RCV_ERR;
            default: next_state = RCV1;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= RCV1;
        else
            state <= next_state;
    end
 
    // Output logic
    assign done = state == RCV_DONE;

endmodule
