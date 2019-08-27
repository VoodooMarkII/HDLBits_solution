module top_module ();
    
    reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff tff_inst(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 1'b1;
        #10 reset = 1'b0;
    end
    
    initial begin
        t = 1'b1;
        wait(q == 1'b1) t = 1'b0;
    end

endmodule
