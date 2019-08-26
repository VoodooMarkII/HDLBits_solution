module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter SHIFT = 0;
    parameter DONE = 1;
    
    reg state, next_state;
    reg [3:0] count;
    wire shift_done;
    
    always @(*) begin
        case (state)
            SHIFT: next_state = shift_done? DONE : SHIFT;
            DONE: next_state = DONE;
            default: next_state = SHIFT;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= SHIFT;
        else
            state <= next_state;
    end
    
    assign shift_ena = state == SHIFT;
        
    always @(posedge clk) begin
        if (reset)
            count <= 4'h0;
        else if (count < 3) begin
            count <= count + 1'b1;
        end
    end
    assign shift_done = count == 3;

endmodule
