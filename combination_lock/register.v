// classic 4 bit register with async active low reset

module register(D, Clock, Resetn, Q);
  input [3:0] D;
  input Clock, Resetn;
  output reg [3:0] Q;

  always @(posedge Clock or negedge Resetn) begin
    if (Resetn == 0)
      Q <= 4'b0000;  
    else
      Q <= D;
  end
endmodule