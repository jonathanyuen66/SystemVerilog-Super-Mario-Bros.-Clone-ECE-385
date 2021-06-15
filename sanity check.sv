module i_am_going_insane (
									input        Clk,
												    Reset,
													 frame_clk,
									input [2:0]	 level_num,
									input [9:0]  DrawX, DrawY,
									output logic is_piranha,
									output logic piranha_health,
									output logic [10:0] piranha_address,
									output logic [9:0] piranha_x,
															 piranha_y
								 );
	logic is_piranha1;
	logic [10:0] piranha_address1;
	logic piranha_health1;
	
	insane piranha1(.Clk, 
						.Reset,
						.frame_clk, 
						.DrawX,
						.DrawY,
						.level_num(level_num),
						.piranha_level_num(3'b011),
						.start_x(10'd500),
						.start_y(10'd405),
						.is_piranha(is_piranha1),
						.piranha_address(piranha_address1),
						.piranha_X_Pos(piranha_x),
						.piranha_Y_Pos(piranha_y),
						.piranha_health(piranha_health1)
						);
	// this module is our piranha controller t
	always_comb
	begin
	// choose which rooms the piranha plant will show up in 
		case(level_num)
			3'b011:
				begin
					if(is_piranha1 == 1'b1)
						begin
							is_piranha = 1'b1;
							piranha_address = piranha_address1;
							piranha_health = piranha_health1;
						end
					else
						begin
							is_piranha = 1'b0;
							piranha_address = 9'b0;
							piranha_health = 1'b0;
						end
				end
			default:
				begin
					is_piranha = 1'b0;
					piranha_address = 9'b0;
					piranha_health = 1'b0;
				end
		endcase
	end
endmodule

