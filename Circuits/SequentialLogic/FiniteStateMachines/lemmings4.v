module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LEFT = 3'd0;
    parameter RIGHT = 3'd1;
    parameter FALL_L = 3'd2;
    parameter FALL_R = 3'd3;
    parameter DIG_L = 3'd4;
    parameter DIG_R = 3'd5;
    parameter SPLAT = 3'd6;
    
    reg [2:0] state, next_state;
    reg [4:0] acc;
    wire acc_clr;
    wire acc_en;
    wire too_high;

    assign acc_clr = (state != FALL_L) & (state != FALL_R);
    assign too_high = (acc == 5'd20);
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            acc <= 5'h00;
        else if (acc_clr)
            acc <= 5'h00;
        else if (acc <20)
            acc <= acc + 1'b1;
    end
    
    
    always @(*) begin
        case (state)
            LEFT: begin
                if (~ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            DIG_L: next_state = ground? DIG_L : FALL_L;
            DIG_R: next_state = ground? DIG_R : FALL_R;
            FALL_L: next_state = ground? (too_high? SPLAT : LEFT) : FALL_L;
            FALL_R: next_state = ground? (too_high? SPLAT : RIGHT) : FALL_R;
            SPLAT: next_state = SPLAT;
            default: next_state = LEFT;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;
    assign aaah = (state == FALL_L) | (state == FALL_R);
    assign digging = (state == DIG_L) | (state == DIG_R);    

endmodule
