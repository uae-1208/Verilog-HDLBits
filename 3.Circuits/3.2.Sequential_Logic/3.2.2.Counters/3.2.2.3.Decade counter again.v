module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        if(reset)
            q <= 4'h1;
        else
        	q <= q + 4'b1;
        
        if(q == 4'd10)
            q <= 4'b1;
    end
endmodule
