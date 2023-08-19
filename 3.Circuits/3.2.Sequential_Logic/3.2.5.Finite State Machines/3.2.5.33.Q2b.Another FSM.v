module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    parameter idle = 4'd0; 
    parameter fout = 4'd1; 
    parameter s1   = 4'd2; 
    parameter s2   = 4'd3; 
    parameter s3   = 4'd4; 
    parameter s4   = 4'd5; 
    parameter s5   = 4'd6; 
    parameter a0   = 4'd7; 
    parameter a1   = 4'd8; 
    
    reg [3:0] current_state,next_state;

    always @(*) begin
        case(current_state)
            idle:  next_state = resetn ? fout : idle;
            fout:  next_state = s1;
            s1  :  next_state = x ? s2 : s1;
            s2  :  next_state = x ? s2 : s3;
            s3  :  next_state = x ? s4 : s1;
            s4  :  next_state = y ? a1 : s5;
            s5  :  next_state = y ? a1 : a0;
            a1  :  next_state = a1;
            a0  :  next_state = a0;
        endcase
    end

    always @(posedge clk) begin
        if(~resetn)begin
            current_state <= idle;
        end
        else begin
            current_state <= next_state;
        end
    end

    assign f = (current_state == fout);
    assign g = ((current_state == s4) | (current_state == s5) | (current_state == a1));

endmodule
