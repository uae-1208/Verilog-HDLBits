module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);

    always @(posedge clk,posedge ar) 
        if(ar)  
            q <= 8'b0;
        else
            q <= d;
endmodule
