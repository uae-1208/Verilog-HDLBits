module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );

    int i;
    
    always @*
    begin
        for(i=2;i>=0;i--)
            out_both[i] = in[i+1] & in[i];
        for(i=3;i>0;i--)
            out_any[i] = in[i] | in[i-1];
        for(i=3;i>=0;i--)
            if(i == 3)
                out_different[i] = in[3] ^ in[0];
        	else
                out_different[i] = in[i] ^ in[i+1];
    end

endmodule
