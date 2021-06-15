module Level_Mux (
					input logic [9:0] Sel,
					output logic [2:0] Level_Mux_Out
					);
					
always_comb
begin 
	// a level selction mux that takes in a selection bit and outputs which room we will go in
	case(Sel)
		10'b1:
			Level_Mux_Out = 3'b001;
		10'b10:
			Level_Mux_Out = 3'b010;
		10'b11:
			Level_Mux_Out = 3'b011;
		default:
			Level_Mux_Out = 3'b000;
	endcase
	
end
endmodule
