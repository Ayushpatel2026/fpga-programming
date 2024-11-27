/*
	Takes in 3 bits (calculated based on current state)
	and outputs 7 bits for the hex display
	The hex disp is active low
*/
	
module display(x, leds);
	input [2:0] x;
	output reg [0:6] leds;
	
	always @(x) begin
        case (x) // 
            3'b000: leds = 7'b0000001; // 0
            3'b001: leds = 7'b0001000; // A
            3'b010: leds = 7'b1111110; // -
            3'b011: leds = 7'b1101010; // n
            default: leds = 7'b1111110; // -
        endcase
    end
	
endmodule