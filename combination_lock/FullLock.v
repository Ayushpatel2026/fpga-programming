/*
	In this file everything is put together to assemble the combination lock system
	
	The compare module is used to compare the input_combo with actual_combo
	
	The enter and change input signals undergo input conditioning before being input 
	into comboLock
	
	The output of the combo lock is used to drive the hex display
	
	Wires are used to connect the various components. 
*/

module FullLock(combo, Clock, Resetn, enter, change, disp);
	input [3:0] combo;
	input Clock, Resetn, enter, change;
	
	output [0:6] disp;
	
	wire [3:0] combo_wire;
	wire [3:0] stored_combo;
	wire isCombo;
	wire enter_cond;
	wire change_cond;
	wire set;
	wire [2:0] y;
	
	register input_combo (combo, Clock, Resetn, combo_wire);
	combStoreReg actual_combo (combo_wire, set, Resetn, stored_combo);
	compare check_combo (combo_wire, stored_combo, isCombo);
	input_conditioning e (Clock, enter, Resetn, enter_cond);
	input_conditioning c (Clock, change, Resetn, change_cond);
	comboLock lock (enter_cond, change_cond, isCombo, Clock, Resetn, y, set);
	display hexdisp (y, disp);
	

endmodule