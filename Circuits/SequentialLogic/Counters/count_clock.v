module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    // Carry signal declearation
    wire ss_10_pls1, mm_10_pls1, hh_10_pls1, hh_10_rollover;
    wire mm_pls1, hh_pls1, pm_toggle;
    wire pm_toggle_235959, pm_toggle_115959;
    
    // Carry signal assignment
    assign ss_10_pls1 = ena & (ss[3:0] == 4'h9);
    assign mm_pls1 = ena & (ss == 8'h59);
    assign mm_10_pls1 = mm_pls1 & (mm[3:0] == 4'h9);
    assign hh_pls1 = ena & (mm == 8'h59) & (ss == 8'h59);
    assign hh_10_pls1 = hh_pls1 & (hh[3:0] == 4'h9);
    assign pm_toggle = ena & (hh == 8'h11) & (mm == 8'h59) & (ss == 8'h59);
    
    // Second units
    always @(posedge clk) begin
        if (reset)
            ss[3:0] <= 4'h0;
        else if (ena & (ss[3:0]==4'h9))
            ss[3:0] <= 4'h0;
        else if (ena)
            ss[3:0] <= ss[3:0] + 1'b1;
    end
    
    // Second tens
    always @(posedge clk) begin
        if (reset)
            ss[7:4] <= 4'h0;
        else if (ss_10_pls1 & (ss == 8'h59))
            ss[7:4] <= 4'h0;
        else if (ss_10_pls1)
            ss[7:4] <= ss[7:4] + 1'b1;
    end 

    // Minute units
    always @(posedge clk) begin
        if (reset)
            mm[3:0] <= 4'h0;
        else if (mm_pls1 & (mm[3:0]==4'h9))
            mm[3:0] <= 4'h0;
        else if (mm_pls1)
            mm[3:0] <= mm[3:0] + 1'b1;
    end
               
    // Minute tens
    always @(posedge clk) begin
        if (reset)
            mm[7:4] <= 4'h0;
        else if (mm_10_pls1 & (mm == 8'h59))
            mm[7:4] <= 4'h0;
        else if (mm_10_pls1)
            mm[7:4] <= mm[7:4] + 1'b1;
    end 

    // Hour units
    always @(posedge clk) begin
        if (reset)
            hh[3:0] <= 4'h2;
        else if (hh_pls1 & (hh == 8'h12)) // Flip from 12 to 01
            hh[3:0] <= 4'h1;
        else if (hh_pls1 & (hh[3:0] == 4'h9))
            hh[3:0] <= 4'h0;
        else if (hh_pls1)
            hh[3:0] <= hh[3:0] + 1'b1;
    end
               
    // Hour tens
    always @(posedge clk) begin
        if (reset)
            hh[7:4] <= 4'h1;
        else if (hh_pls1 & (hh == 8'h12)) //// Flip from 12 to 01
            hh[7:4] <= 4'h0;
        else if (hh_10_pls1)
            hh[7:4] <= hh[7:4] + 1'b1;
    end     

    
    always @(posedge clk) begin
        if (reset)
            pm <= 1'b0;
        else if (pm_toggle)
            pm <= ~pm;
    end

endmodule