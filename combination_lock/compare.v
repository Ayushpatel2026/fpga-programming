
// compare the two nums and return 1 if equal, else 0
module compare(num1, num2, result);
	input [3:0] num1, num2;
	output reg result;
	
	always @(num1, num2)
	begin 
		result = 0;
		if (num1 == num2) result = 1;
	end
	
endmodule