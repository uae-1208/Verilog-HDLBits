module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter idle = 4'd0; 
    parameter bit1 = 4'd1;
    parameter bit2 = 4'd2;
    parameter bit3 = 4'd3;
    parameter bit4 = 4'd4;
    parameter bit5 = 4'd5;
    parameter bit6 = 4'd6;
    parameter FLAG = 4'd7;
    parameter DISC = 4'd8;
    parameter ERR = 4'd9;
    
    reg [3:0] state, next_state;
    
    always @(*) begin
        case(state)
            idle:next_state = in ? bit1 : idle;
            bit1:next_state = in ? bit2 : idle;
            bit2:next_state = in ? bit3 : idle;
            bit3:next_state = in ? bit4 : idle;
            bit4:next_state = in ? bit5 : idle;
            bit5:next_state = in ? bit6 : DISC;
            bit6:next_state = in ? ERR  : FLAG;
            FLAG:next_state = in ? bit1 : idle;
            DISC:next_state = in ? bit1 : idle;
            ERR :next_state = in ? ERR  : idle;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= idle;
        end
        else begin
            state <= next_state;
        end
    end
   
   
    assign disc = (state == DISC);
    assign err  = (state == ERR);
    assign flag = (state == FLAG);
endmodule
