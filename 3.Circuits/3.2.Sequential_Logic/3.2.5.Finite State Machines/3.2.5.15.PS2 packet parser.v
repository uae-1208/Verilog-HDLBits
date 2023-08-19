module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter done_b1 = 2'd0, b1 = 2'd1, b2 = 2'd2, b3 = 2'd3; 
    reg [1:0] state, next_state;
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            done_b1:begin
                if(in[3]) begin
                	next_state = b2;
                end
                else begin
                	next_state = b1;
                end
            end
            b1:begin
                if(in[3]) begin
                	next_state = b2;
                end
                else begin
                	next_state = b1;
                end
            end
            b2:begin
                next_state = b3;
            end
            b3:begin
                next_state = done_b1;
            end
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            state <= b1;
        end
        else begin
            state <= next_state;
        end
    end
    // Output logic
    assign done = (state == done_b1);
endmodule
