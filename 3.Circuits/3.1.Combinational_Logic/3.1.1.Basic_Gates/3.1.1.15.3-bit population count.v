module top_module( 
    input [2:0] in,
    output [1:0] out );

    int i;
    always @(*)
    begin
        out = 2'b0;
        for(i=0;i<3;i++)  
            if(in[i]) 
                out = out + 1'b1;
     end
endmodule