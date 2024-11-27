
/*
	This module conditions the input signals to make sure that input is high for only 
	one clock cycle. 
	A human pressing a push button once may coincide with many clock cycles for the
	system clock, but we only want that to be read as pressing the button once
	Another button press is not "read" until the human lets go and presses again
*/

module input_conditioning(Clock, A, Resetn, A_pulse);
	input Clock, A, Resetn;
	output A_pulse;
	reg [1:0] y = 2'b00;
	reg [1:0] Y = 2'b00;
	parameter B = 2'b00, C =2'b01, D = 2'b10;
	always @(A, y)
	begin
		case (y)
			B: if (A == 0) Y = B;
				else 		  	Y = C;
			C: if (A == 0) Y = B;
				else 		  	Y = D;
			D: if (A == 0) Y = B ;
				else 		   Y = D;
			default: Y = B;
		endcase
	end
	always @(posedge Clock, negedge Resetn)
	begin
		if (Resetn == 0)
			y <= B;
		else
			y <=Y;
	end
	assign A_pulse = (y == C);
endmodule