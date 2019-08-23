module top_module(
    input clk,
    input load,
    input [-1:0] data,
    output [-1:0] q );

    wire [-1:0] next_state;
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_state;
    end
endmodule
module next_life_gen(
    input wire center,
    input wire left,
    input wire left_up,
    input wire left_down,
    input wire center_up,
    input wire center_down,
    input wire right,
    input wire right_up,
    input wire right_down,
    output reg next_state );
    
    wire [2:0] count;
    wire [7:0] neighbour;
    
    assign neighbour = {left, left_up, left_down, center_up, center_down, right, right_up, right_down};
    
    integer i;
    
    always @(*) begin
        count = 3'd0;
        for (i=0; i<8; i=i+1) begin
            count = count + neighbour[i];
        end
    end
    
    always @(*) begin
        if (count < 3'd1)
            next_state = 1'b0;
        else if (count == 3'd2)
            next_state = center;
        else if (count == 3'd3)
            next_state = 1'b1;
        else
            next_state = 1'b0;
    end
endmodule
