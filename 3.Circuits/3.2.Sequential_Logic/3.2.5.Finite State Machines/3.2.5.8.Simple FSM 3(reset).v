module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    parameter A=0, B=1, C=2, D=3; 
    reg [2:0] state, next_state;

    // State transition logic
	always @(*) begin
        case(state) 
            A:next_state = (in == 1'b0) ? A : B;
            B:next_state = (in == 1'b0) ? C : B;
            C:next_state = (in == 1'b0) ? A : D;
            D:next_state = (in == 1'b0) ? C : B;
        endcase
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk) begin
        if(reset) begin
           state <= A; 
        end
        else begin
           state <= next_state; 
        end
    end
    // Output logic
    assign out = (state == D);

endmodule
