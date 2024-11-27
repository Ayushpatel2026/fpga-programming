
/*
	This module is the heart of this system, implementing the logic for the lock
	using an FSM
	
	Core Lock Functionality: 
		If the input matches stored combo and enter is pressed, open (display 'O')
		After two failed attempts to open lock, set off alarm (display 'A')
		pressing Resetn turns alarm off and system goes back to start state (display '-')
		pressing Resetn also resets stored combo to 0110
		To change the stored combo, set the input to the old combo and press change (display 'n')
		Set the input to the new combo and press enter or change to store it
		After two incorrect attempts to change combo, alarm is set off
		

*/

module comboLock(enter, change, isCombo, Clock, Resetn, y, set);
	input enter, change, isCombo, Clock, Resetn;
	output [2:0] y;
	output set;
	
	reg[2:0] w, W;
	
	/*
		This FSM has 6 states
		A is the starting/reset state
		B is the open state (combo is correct and enter is pressed)
		C is the buffer state to track that enter/change has already been pressed once
		D is the alarm state (2 wrong changes/enters)
		E is the change combo state (combo is correct and change is pressed)
		F is used to tell the system to store the new combo
	
	*/
	
	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
	
	always @ (enter, change, isCombo, w)
	begin 
		case (w)
			A: if (change & isCombo) W = E;
				else if ((enter | change) & ~isCombo ) W = C;
				else if (enter & isCombo) W = B;
				else W = A;
			B: if (enter) W = A;
				else W = B;
			C: if (change & isCombo) W = E;
				else if ((enter | change) & ~isCombo) W = D;
				else if (enter & isCombo) W = B;
				else W = C;
			D: W = D;
			E: if (enter | change) W = F;
				else W = E;
			F: W = A;
			default: W = 3'bxxx;
		endcase
		
	
	end 
	
	
	always @ (posedge Clock, negedge Resetn)
	begin 
		if (Resetn == 0)
			// back to start state
			w <= A;
		else 
			w <= W;
	end
	
	// y[2] is always 0
	assign y[2] = w[2] & w[1] & w[0];
	// needs to be one when reset/start or new 
	assign y[1] = (~w[2] & ~w[1] & ~w[0]) | (w[2] & w[0]);
	
	// needs to be one when Alarm or new
	assign y[0] = (w[1] & w[0]) | (w[2] & w[0]);
	
	// set the new combo when in state F
	assign set = w[2] & w[0];
	
	
endmodule
	