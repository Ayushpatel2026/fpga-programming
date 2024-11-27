/*
	This 4 bit register stores the combination for the lock
	The combination is reset to 0110 when the system is reset
	The combination is set to a new value (x) at the positive edge of the set signal
*/

module combStoreReg(x, set, Resetn, Y);
	input [3:0] x;
	input set, Resetn;
	output reg [3:0] Y;
	
	always@(posedge set, negedge Resetn)
	begin
		if (Resetn == 0)
			Y <= 4'b0110;
		else
			Y <= x;
	end

endmodule