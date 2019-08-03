module top_module (input x, input y, output z);
    
    wire ia1_out, ia2_out, ib1_out, ib2_out;
    
    ia ia_inst_1 (
        .x(x),
        .y(y),
        .z(ia1_out)
    );
    
    ia ia_inst_2 (
        .x(x),
        .y(y),
        .z(ia2_out)
    );
    
    ib ib_inst_1 (
        .x(x),
        .y(y),
        .z(ib1_out)
    );
    
    ib ib_inst_2 (
        .x(x),
        .y(y),
        .z(ib2_out)
    );
    
    assign z = (ia1_out | ib1_out) ^ (ia2_out & ib2_out);
    

endmodule

module ia (input x, input y, output z);
    
    assign z = (x^y) & x;

endmodule

module ib ( input x, input y, output z );
    
    assign z = ~(x ^ y);

endmodule
