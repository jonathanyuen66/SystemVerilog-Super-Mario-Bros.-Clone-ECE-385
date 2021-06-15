module enemy_controller (
									input        Clk,
												    Reset,
													 frame_clk,
									input [2:0]	 level_num,
									input [9:0]  DrawX, DrawY,
									input [9:0]  mario_x, mario_y,
													 luigi_x, luigi_y,
									input [9:0]  mario_Size_Y,
													 luigi_Size_Y,
									input [1:0]	 mario_health,
													 luigi_health,
									output logic is_enemy,
									output logic enemy_walk_count,
									output logic enemy_health,
									output logic [8:0] enemy_address,
									output logic [9:0] enemy_x,
															 enemy_y
								 );
	// this module is the enemy controller - where we instantiate the enemy's 
	// helpful if we want to add more enemys 
	logic is_enemy1;
	logic [8:0] enemy_address1;
	logic enemy_walk_count1;
	logic enemy_health1;
	
	enemy enemy1(.Clk, 
						.Reset,
						.frame_clk, 
						.DrawX,
						.DrawY,
						.level_num(level_num),
						.enemy_level_num(3'b001),
						.start_x(10'd600),
						.start_y(10'd400),
						.mario_x(mario_x),
						.mario_y(mario_y),
						.luigi_x(luigi_x),
						.luigi_y(luigi_y), 
						.mario_Size_Y,
						.luigi_Size_Y,
						.mario_health,
						.luigi_health,
						.is_enemy(is_enemy1),
						.enemy_walk_count(enemy_walk_count1),
						.enemy_address(enemy_address1),
						.enemy_X_Pos(enemy_x),
						.enemy_Y_Pos(enemy_y),
						.enemy_health(enemy_health1));
	
	always_comb
	begin
		case(level_num)   // decide which levels to put the enemy in 
			3'b001:
				begin
					if(is_enemy1 == 1'b1)
						begin
							is_enemy = 1'b1;
							enemy_address = enemy_address1;
							enemy_walk_count = enemy_walk_count1;
							enemy_health = enemy_health1;
						end
						else
						begin
							is_enemy = 1'b0;
							enemy_address = 9'b0;
							enemy_walk_count = 1'b0;
							enemy_health = 1'b0;
						end
				end
			default:
				begin
					is_enemy = 1'b0;
					enemy_address = 9'b0;
					enemy_walk_count = 1'b0;
					enemy_health = 1'b0;
				end
		endcase
	end
							 
endmodule
