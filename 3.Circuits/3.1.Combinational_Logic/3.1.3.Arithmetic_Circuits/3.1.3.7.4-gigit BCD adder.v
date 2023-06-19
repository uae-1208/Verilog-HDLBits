module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
   
    wire [2:0] Cout;

    bcd_fadd bcd1(a[3:0], b[3:0], cin, Cout[0], sum[3:0]);
    bcd_fadd bcd2(a[7:4], b[7:4], Cout[0], Cout[1], sum[7:4]);
    bcd_fadd bcd3(a[11:8], b[11:8], Cout[1], Cout[2], sum[11:8]);
    bcd_fadd bcd4(a[15:12], b[15:12], Cout[2], cout, sum[15:12]);
    
endmodule
