module top_module( 
    input [254:0] in,
    output [7:0] out );

    int i;
	always @* begin
        out = 8'b0;
        for(i=0;i<255;i++) 
            out = out + in[i];
    end
endmodule
