/*
This is a ripple carry adder. The fulladd module uses boolean logic to perform the 1 bit addition
3 fulladd modules are combined using wires to create the full 3-bit ripple carry adder. 
*/

module adder3(num_1, num_2, sum, carryOut);
	input [2:0] num_1;
	input [2:0] num_2;
	output [3:0] sum;
	output carryOut;
	
	wire c1, c2;
	
	fulladd stage0 (.num_1(num_1[0]), .num_2(num_2[0]), .Cin(1'b0), .s(sum[0]), .Cout(c1));
	fulladd stage1 (.num_1(num_1[1]), .num_2(num_2[1]), .Cin(c1), .s(sum[1]), .Cout(c2));
	fulladd stage2	(.num_1(num_1[2]), .num_2(num_2[2]), .Cin(c2), .s(sum[2]), .Cout(carryOut));
	
endmodule	

module fulladd (num_1, num_2, Cin, s, Cout);
	input Cin, num_1, num_2;
	output s, Cout;
	assign s = num_1 ^ num_2 ^ Cin;
	assign Cout = (num_1 & num_2) | (num_1 & Cin) | (num_2 & Cin);
endmodule


