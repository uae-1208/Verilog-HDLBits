module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    
    reg [7:0] in_last;
    int i;
    
    always @(posedge clk) begin
        for(i=0;i<8;i++)
            if((in_last[i] != in[i]) && in[i])
                pedge[i] <= 1'b1;
            else
                pedge[i] <= 1'b0;

        in_last <= in; 
    end

endmodule
