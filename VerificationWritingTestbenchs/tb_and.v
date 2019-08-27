module top_module();
    
    reg [1:0] in;
    wire out;
    
    andgate andgate_inst(
        .in(in),
        .out(out)
    );
    
    initial begin
        in = 2'b00;
        #10 in[0] = 1'b1;
        #10 in[1] = 1'b1;
        in[0] = 1'b0;
        #10 in[0] = 1'b1;
    end

endmodule
