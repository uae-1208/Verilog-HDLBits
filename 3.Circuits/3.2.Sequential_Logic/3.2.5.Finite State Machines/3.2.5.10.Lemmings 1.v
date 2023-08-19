module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    reg state, next_state;
    parameter left =0, right = 1;
    
    always @(*) begin
        // State transition logic
        case (state) 
            left:begin
                if(bump_left) begin
                	next_state = right;
                end
                else begin
                	next_state = left;    
                end
            end
        	right:begin
                 if(bump_right) begin
                     next_state = left;
                 end
                 else begin
                     next_state = right;    
                 end
             end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) begin
            state <= left;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == left);
    assign walk_right = (state == right);

endmodule
