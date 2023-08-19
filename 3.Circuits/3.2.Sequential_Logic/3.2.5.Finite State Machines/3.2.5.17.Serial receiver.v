module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter start = 4'd0;     //代表上一个周期是start位
    parameter bit1 = 4'd1;
    parameter bit2 = 4'd2;
    parameter bit3 = 4'd3;
    parameter bit4 = 4'd4;
    parameter bit5 = 4'd5;
    parameter bit6 = 4'd6;
    parameter bit7 = 4'd7;
    parameter bit8 = 4'd8;
    parameter stop = 4'd9; 
    parameter error = 4'd10; 
    parameter idle = 4'd11; 
    reg [3:0] state, next_state;
   
    always @(*) begin
        case(state)
            start:next_state = bit1;
            bit1:next_state = bit2;
            bit2:next_state = bit3;
            bit3:next_state = bit4;
            bit4:next_state = bit5;
            bit5:next_state = bit6;
            bit6:next_state = bit7;
            bit7:next_state = bit8;
            bit8:begin
                if(in) begin
                    next_state = stop;
                end
                else begin
                    next_state = error;
                end
            end
            idle:begin
                if(in) begin
                    next_state = idle;
                end
                else begin
                    next_state = start;
                end
            end
            stop:begin
                if(in) begin
                    next_state = idle;
                end
                else begin
                    next_state = start;
                end
            end
            error:begin
                if(in) begin
                    next_state = idle;
                end
                else begin
                    next_state = error;
                end
            end
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
   
   assign done = (state == stop);
endmodule
