module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    
    parameter RESET = 3'd0;
    parameter S1 = 3'd1;
    parameter S11 = 3'd2;
    parameter S110 = 3'd3;
    parameter S1101 = 3'd4;
    parameter SHIFT = 3'd5;
    parameter CNTING = 3'd6;
    parameter DONE = 3'd7;
    
    reg [2:0] state, next_state, cnt;
    wire counts_num;
    
    always @(*)begin
        case(state)
            RESET : next_state = data ? S1 : RESET;
            S1    : next_state = data ? S11 : RESET;
            S11   : next_state = data ? S11 : S110;
            S110  : next_state = data ? S1101 : RESET;
            S1101 : begin
                        next_state = SHIFT;
                        count = {count[2:0],data};
                    end
            SHIFT : begin
                        count = {count[2:0],data};
                        if(cnt == 2'd0) begin
                            next_state = CNTING;
                            counts_num = count * 1000 + 1;
                        end
                        else begin
                            next_state = SHIFT;
                        end
                    end
            CNTING: begin
                        if(counts_num == 0) begin
                            next_state = DONE;
                        end
                        else begin
                            next_state = CNTING;
                            counts_num = counts_num - 1;
                        end
                    end
            DONE  : next_state = ack ? RESET : DONE;
        endcase
    end
    
    
    always @(posedge clk) begin
        if(reset)begin
            state <= RESET;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(posedge clk) begin
        if(next_state == S1101) begin
            cnt <= 2'd3;
        end
        else if(cnt > 2'd0) begin
            cnt <= cnt - 2'd1;
        end
    end

    assign counting = (state == CNTING);
    assign done = (state == DONE);
endmodule
