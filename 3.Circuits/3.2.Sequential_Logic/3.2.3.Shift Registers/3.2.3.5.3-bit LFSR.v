module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    wire [2:0] temp;
    always @(posedge KEY[0]) begin
        LEDR <= temp;
    end

    assign temp[0] = (SW[0] & KEY[1]) | (LEDR[2] & ~KEY[1]);
    assign temp[1] = (SW[1] & KEY[1]) | (LEDR[0] & ~KEY[1]);
    assign temp[2] = (SW[2] & KEY[1]) | ((LEDR[1]^LEDR[2]) & ~KEY[1]);
endmodule
