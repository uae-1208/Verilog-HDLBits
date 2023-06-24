module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    wire [3:0] hndrd,ten,one;
    
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (one == 4'd9);
    assign c_enable[2] = (ten==4'd9 && one==4'd9);
    assign OneHertz = (hndrd==4'd9 && ten==4'd9 && one==4'd9);
    
    bcdcount counter0 (clk, reset, c_enable[0], one);
    bcdcount counter1 (clk, reset, c_enable[1], ten);
    bcdcount counter2 (clk, reset, c_enable[2], hndrd);

endmodule
