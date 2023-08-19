module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    reg [2:0] state,next_state;
    reg [4:0] fall_cycle;
    parameter left = 3'd0;
    parameter right = 3'd1;
    parameter fall_left = 3'd2;
    parameter fall_right = 3'd3;
    parameter dig_left = 3'd4;
    parameter dig_right = 3'd5;
    parameter die = 3'd6;
    
    always @(*) begin
        // State transition logic
        case (state) 
            fall_left:begin
                if(fall_cycle >= 5'd20) begin
                	next_state = die;
                end
                else if(ground) begin
                	next_state = left;
                end
                else begin
                	next_state = fall_left;
                end
            end
            dig_left:begin
                if(ground) begin
                    next_state = dig_left;    
                end
                else begin
                	next_state = fall_left;
                end
            end
            left:begin
                if(~ground) begin
                	next_state = fall_left;
                end
                else if(dig) begin
                	next_state = dig_left;
                end
                else if(bump_left) begin
                	next_state = right;
                end
                else begin
                	next_state = left;    
                end
            end
            fall_right:begin
                if(fall_cycle >= 5'd20) begin
                	next_state = die;
                end
                else if(ground) begin
                	next_state = right;
                end
                else begin
                	next_state = fall_right;
                end
            end
            dig_right:begin
                if(ground) begin
                    next_state = dig_right;    
                end
                else begin
                	next_state = fall_right;
                end
            end
        	right:begin
                if(~ground) begin
                	next_state = fall_right;
                end
                else if(dig) begin
                	next_state = dig_right;
                end
                else if(bump_right) begin
                    next_state = left;
                end
                else begin
                    next_state = right;    
                end
             end
            die:begin
                next_state = die;    
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
            if((state == fall_right) && (state == fall_left)) begin
                fall_cycle = fall_cycle + 5'd1;
            end
            else begin
                fall_cycle = 5'd0;
            end
        end
    end

    // Output logic
    assign walk_left = (state == left);
    assign walk_right = (state == right);
    assign aaah = (state == fall_right) | (state == fall_left);
    assign digging = (state == dig_right) | (state == dig_left);
    
endmodule
