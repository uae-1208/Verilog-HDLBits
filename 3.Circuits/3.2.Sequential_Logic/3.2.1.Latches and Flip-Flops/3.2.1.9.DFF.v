module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);

    always @(posedge clk) 
        if(r)  
            q <= 8'b0;
        else
            q <= d;
endmodule
