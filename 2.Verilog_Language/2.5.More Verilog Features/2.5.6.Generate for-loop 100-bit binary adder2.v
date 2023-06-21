module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
	genvar i;
    generate
        for(i=0;i<100;i++) begin:adder
            if(i==0)
                assign{cout[0],sum[0]}=a[0]+b[0]+cin;
            else
                assign{cout[i],sum[i]}=a[i]+b[i]+cout[i-1];
        end           
    endgenerate
endmodule
