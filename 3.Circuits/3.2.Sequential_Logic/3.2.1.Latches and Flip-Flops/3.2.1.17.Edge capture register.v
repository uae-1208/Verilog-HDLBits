module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    wire [31:0] in_last;
    int i;
    
    always @(posedge clk) begin
        if(reset)
			out <= 32'h0000;
    	else begin
        	for(i=0;i<32;i++)
                if((in_last[i]==1'b1) && (in[i]==1'b0))
                    out[i] <= 1'b1;
        end
            
        in_last <= in;
    end

endmodule
