module top_module();
    
    reg clk;
    reg in;
    reg [2:0] s;
    wire out;
    
    q7 q7_inst(
        .clk(clk),
        .in(in),
        .s(s),
        .out(out)
    );
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        in = 1'b0;
        #20 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #30 in = 1'b0;
    end
    
    initial begin
        s = 3'd2;
        #10 s = 3'd6;
        #10 s = 3'd2;
        #10 s = 3'd7;
        #10 s = 3'd0;
    end

endmodule
