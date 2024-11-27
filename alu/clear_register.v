// Classic 3 bit register with active low reset

module clear_register (D, Clock, Resetn, Q);
  input [2:0] D;
  input Clock, Resetn;
  output reg [2:0] Q;

  always @(posedge Clock or negedge Resetn) begin
    if (Resetn == 0)
      Q <= 3'b000;  
    else
      Q <= D;
  end
endmodule