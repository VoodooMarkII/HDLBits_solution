module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    parameter A = 1'b0;
    parameter B = 1'b1;
    reg state, next_state;
    reg [1:0] count_3;
    reg [1:0] cnt_w;
    
    wire [1:0] next_cnt_w;
    wire count_en;
    
    always @(*) begin
        case (state)
            A: next_state = s? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    assign count_en = state == B;
    
    always @(posedge clk) begin
        if (reset) begin
            count_3 <= 2'd0;
            cnt_w <= 2'd0;
        end
        else if (count_en) begin
            if (count_3==2'd2) begin
            	count_3 <= 2'd0;
            	cnt_w <= 2'd0;
            end
        	else begin
            	count_3 <= count_3 + 1'b1;
                cnt_w <= next_cnt_w;
            end
        end
    end
	
    assign next_cnt_w = cnt_w + w;
    
    always @(posedge clk) begin
        if (reset)
            z <= 1'b0;
        else if (count_3 == 2'd2 & next_cnt_w == 2'd2)
            z <= 1'b1;
        else 
            z <= 1'b0;
    end
            
endmodule
