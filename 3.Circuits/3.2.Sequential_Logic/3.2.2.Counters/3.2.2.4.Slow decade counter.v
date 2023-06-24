module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always @(posedge clk) begin
        if(reset)
            q <= 4'h0;
        else if(slowena)  begin
        	q <= q + 4'b1;
            if(q == 4'd9)
           		q <= 4'b0;
        end
    end

endmodule
