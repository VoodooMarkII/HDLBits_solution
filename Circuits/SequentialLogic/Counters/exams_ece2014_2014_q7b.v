module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    wire [3:0] q0, q1, q2;
    wire carry0, carry1;
    
    assign c_enable = {carry1, carry0, 1'b1};
    
    assign carry0 = (q0 == 4'd9);
    assign carry1 = (q1 == 4'd9) & (q0 == 4'd9);
    assign OneHertz = (q2 == 4'd9) & (q1 == 4'd9) & (q0 == 4'd9);
        
    bcdcount counter0 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[0]),
        .Q(q0)
    );
    
    bcdcount counter1 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[1]),
        .Q(q1)
    );
    
    bcdcount counter2 (
        .clk(clk),
        .reset(reset),
        .enable(c_enable[2]),
        .Q(q2)
    );    

endmodule
