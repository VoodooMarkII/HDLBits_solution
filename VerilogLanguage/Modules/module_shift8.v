module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    
    wire [7:0] dff1_q, dff2_q, dff3_q;

    my_dff8 my_dff8_inst_1 (
        .clk(clk),
        .d(d),
        .q(dff1_q)
    );
    
    my_dff8 my_dff8_inst_2 (
        .clk(clk),
        .d(dff1_q),
        .q(dff2_q)
    );
    
    my_dff8 my_dff8_inst_3 (
        .clk(clk),
        .d(dff2_q),
        .q(dff3_q)
    );
    
    always @(*) begin
        case (sel)
            2'b00: q = d;
            2'b01: q = dff1_q;
            2'b10: q = dff2_q;
            2'b11: q = dff3_q;
        endcase
    end
    
endmodule