module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    parameter BL1 = 3'd0;
    parameter BTW12 = 3'd1;
    parameter BTW23 = 3'd2;
    parameter ABV3 = 2'd3;
    parameter BTW23_DOWN = 3'd4;
    parameter BTW12_DOWN = 3'd5;
    parameter BL1_DOWN = 3'd6;
    parameter IDLE_STS = 3'd7;
    
    
    reg [2:0] state, next_state;
    
    always @(*) begin
        case (state)
            BL1: next_state = s[1]? BTW12 : BL1;

            BTW12: begin
                if (s[2])
                    next_state = BTW23;
                else if (~s[1])
                    next_state = BL1_DOWN;
                else
                    next_state = BTW12;
            end

            BTW23: begin
                if (s[3])
                    next_state = ABV3;
                else if (~s[2])
                    next_state = BTW12_DOWN;
                else
                    next_state = BTW23;
            end

            ABV3: next_state = ~s[3]? BTW23_DOWN : ABV3;

            BTW23_DOWN: begin
                if(s[3])
                    next_state = ABV3;
                else if (~s[2])
                    next_state = BTW12_DOWN;
                else
                    next_state = BTW23_DOWN;
            end

            BTW12_DOWN: begin
                if(s[2])
                    next_state = BTW23;
                else if (~s[1])
                    next_state = BL1_DOWN;
                else
                    next_state = BTW12_DOWN;
            end
            BL1_DOWN: next_state = s[1]? BTW12 : BL1_DOWN;
            IDLE_STS: next_state = s[1]? BTW12 : IDLE_STS;
            default: next_state = IDLE_STS;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE_STS;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign fr1 = (state == BL1) | (state == BTW12) | (state == BTW23) | (state == BL1_DOWN) | (state == BTW12_DOWN) | (state == BTW23_DOWN) | (state == IDLE_STS);
    assign fr2 = (state == BL1) | (state == BTW12) | (state == BL1_DOWN) | (state == BTW12_DOWN) | (state == IDLE_STS);
    assign fr3 = (state == BL1) | (state == BL1_DOWN) | (state == IDLE_STS);
    assign dfr = (state == BTW12_DOWN) | (state == BTW23_DOWN) | (state == BL1_DOWN) | (state == IDLE_STS);
            
endmodule
