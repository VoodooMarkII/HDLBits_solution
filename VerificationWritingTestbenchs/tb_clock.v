module top_module ( );
    
    reg clk;
    
    initial begin
        clk = 0;
    end
    
    initial begin
    	forever #5 clk = ~clk;
    end

    
    dut u_dut(
        .clk(clk)
    );

endmodule
