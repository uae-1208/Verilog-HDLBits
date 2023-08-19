module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state) 
            OFF:begin
                if(j == 1'b0) begin
                    next_state = OFF;
                end 
                else begin
                    next_state = ON;
                end
            end
            
            ON:begin
                if(k == 1'b0) begin
                    next_state = ON;
                end 
                else begin
                    next_state = OFF;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with Synchronous reset
        if(reset) begin
            state <= OFF;
        end 
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == ON);

endmodule

