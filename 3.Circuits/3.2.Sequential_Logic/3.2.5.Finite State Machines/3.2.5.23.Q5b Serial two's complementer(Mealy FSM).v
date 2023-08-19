module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter S0 = 1'b0, S1 = 1'b1;
    reg current_state,next_state;

    always @(*) begin
        case(current_state)
            S0:     next_state = x ? S1 : S0;
            S1:     next_state = S1;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if(areset)begin
            current_state <= S0;
        end
        else begin
            current_state <= next_state;
        end
    end

    assign z = ((current_state == S0) && x) || ((current_state == S1) && ~x);

endmodule
