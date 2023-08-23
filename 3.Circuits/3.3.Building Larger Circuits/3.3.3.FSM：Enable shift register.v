module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    parameter IDLE  = 2'd0;
    parameter RESET = 2'd1;
    parameter SHIFT = 2'd2;
    
    reg [1:0] state, next_state, cnt;
    
    
    always @(*)begin
        case(state)
            IDLE :  next_state = reset ? RESET : IDLE;
            RESET:begin
                    if(reset) begin
                        next_state = reset;
                    end
                    else begin
                        next_state = SHIFT;
                    end
                  end
            SHIFT:begin
                    if(cnt == 2'd0) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = SHIFT;
                    end
                  end
        endcase
    end
    
    
    always @(posedge clk) begin
        state <= next_state;
    end
    
    always @(posedge clk) begin
        if(reset) begin
            cnt <= 2'd3;
        end
        else if(cnt > 2'd0) begin
            cnt <= cnt - 2'd1;
        end
    end

    assign shift_ena = ((state == RESET) | (state == SHIFT));
endmodule
