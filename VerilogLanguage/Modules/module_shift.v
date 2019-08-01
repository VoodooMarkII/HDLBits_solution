module top_module ( input clk, input d, output q );
    
    wire dff1_q, dff2_q;

    my_dff my_dff_inst_1 (
        .clk(clk),
        .d(d),
        .q(dff1_q)
    );
    
    my_dff my_dff_inst_2 (
        .clk(clk),
        .d(dff1_q),
        .q(dff2_q)
    );
    
    my_dff my_dff_inst_3 (
        .clk(clk),
        .d(dff2_q),
        .q(q)
    );
    
endmodule