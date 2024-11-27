
/*
	Full ALU with 2 registers, an adder module and the display module
*/

module alu3 (num_1, Reset, Clock, leds);
	input [2:0] num_1;
	input Clock, Reset;
	output wire [1:7] leds;
	
	wire [2:0] A;
	wire [2:0] B;
	wire [2:0] C;
	wire carryout;
	wire [3:0] disp;
	
	assign disp = {carryout, C};
	
	
	// stores the first number for addition
	clear_register reg_1 (.D(num_1), .Clock(Clock), .Resetn(Reset), .Q(A));
	
	adder3 adder (.num_1(A), .num_2(B), .sum(C), .carryOut(carryout));
	
	// stores the 3 LSB from the sum (the second number for addition)
	clear_register reg_2 (.D(C), .Clock(Clock), .Resetn(Reset), .Q(B));
	
	hex7seg display (.bcd(disp), .leds(leds));
	
	
endmodule

