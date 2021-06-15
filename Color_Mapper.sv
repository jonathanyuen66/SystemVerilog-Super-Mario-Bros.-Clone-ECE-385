// in this module we just set the colors of every element of the game based on our palettes in the sprite modules module 
module  color_mapper ( 
							  input		  [1:0]	mario_health,
														luigi_health,
							  input					enemy_health,
							  input					piranha_health,
							  input              is_character1,
                                          is_character2,
							  input					is_barrier,
							  input					is_brick,
							  input					is_dirt,
							  input					is_pipe,
							  input					is_enemy,
														is_redupgrade,
														is_greenupgrade,
														is_question,
														is_question_empty,
							  input					is_piranha,
							  input					is_mario_on_ground,
														is_luigi_on_ground,
							  input					is_mario_walking,
														is_luigi_walking,
														is_game_over,
														is_logo,
							  input 			[1:0] mario_walk_count,
														luigi_walk_count,
							  input					enemy_walk_count,
							  input			[9:0] mario_address,
														luigi_address,
							  input			[8:0]	enemy_address,
							  input			[10:0]piranha_address,
							  input			[8:0] upgrade_address,
							  input			[8:0] question_address,
							  input			[19:0]game_over_address,
							  input			[17:0]logo_address,
							  input			[10:0] barrier_address,
                       input        [9:0] DrawX, DrawY,
                       output logic [7:0] Red, Green, Blue
                     );
    
//	 logic [19:0]mario_background_address;
//	 logic is_background;
//	 assign is_background = 1'b1;
//	 assign mario_background_address = DrawX + DrawY * 640;
	 logic [23:0] pixel_color_logo,
					  pixel_color_ground,
					  pixel_color_brick,
					  pixel_color_mario_still, 
					  pixel_color_mario_jump, 
					  pixel_color_mario_walk_1, 
					  pixel_color_mario_walk_2,
					  pixel_color_mario_walk_3,
					  pixel_color_mario_big_still,
					  pixel_color_mario_big_jump,
					  pixel_color_mario_big_walk_1,
					  pixel_color_mario_big_walk_2,
					  pixel_color_mario_big_walk_3,
					  pixel_color_mario_dead,
					  pixel_color_luigi_still, 
					  pixel_color_luigi_jump, 
					  pixel_color_luigi_walk_1, 
					  pixel_color_luigi_walk_2,
					  pixel_color_luigi_walk_3,
					  pixel_color_luigi_big_still,
					  pixel_color_luigi_big_jump,
					  pixel_color_luigi_big_walk_1,
					  pixel_color_luigi_big_walk_2,
					  pixel_color_luigi_big_walk_3,
					  pixel_color_luigi_dead,
					  pixel_color_enemy_walk_1,
					  pixel_color_enemy_walk_2,
					  pixel_color_enemy_squished,
					  pixel_color_dirt,
					  pixel_color_game_over,
					  pixel_color_pipe,
					  pixel_color_piranha,
					  pixel_color_redupgrade,
					  pixel_color_greenupgrade,
					  pixel_color_question_blink_1,
					  pixel_color_question_empty,
					  pixel_color_background;
    
	 // sprite modules
		 // ground tiles
		 mario_grass_sprite grass_sprite0(.read_address(barrier_address), .pixel_color(pixel_color_ground));
		 mario_brick_sprite  brick_sprite0(.read_address(barrier_address), .pixel_color(pixel_color_brick));
		 mario_dirt_sprite  dirt_sprite0(.read_address(barrier_address), .pixel_color(pixel_color_dirt));
		 mario_pipe_sprite  pipe_sprite0(.read_address(barrier_address), .pixel_color(pixel_color_pipe));
	 
		 // mario sprites
		 mario_sprite_still mario_sprite_still0(.read_address(mario_address), .pixel_color(pixel_color_mario_still));
		 mario_sprite_jump mario_sprite_jump0(.read_address(mario_address), .pixel_color(pixel_color_mario_jump));
		 mario_sprite_walk1 mario_sprite_walk1_0(.read_address(mario_address), .pixel_color(pixel_color_mario_walk_1));
		 mario_sprite_walk2 mario_sprite_walk2_0(.read_address(mario_address), .pixel_color(pixel_color_mario_walk_2));
		 mario_sprite_walk3 mario_sprite_walk3_0(.read_address(mario_address), .pixel_color(pixel_color_mario_walk_3));
		 
		 big_mario_sprite_still big_mario_sprite_still0(.read_address(mario_address), .pixel_color(pixel_color_mario_big_still));
		 big_mario_sprite_jump big_mario_sprite_jump0(.read_address(mario_address), .pixel_color(pixel_color_mario_big_jump));
		 big_mario_sprite_walk1 big_mario_sprite_walk1_0(.read_address(mario_address), .pixel_color(pixel_color_mario_big_walk_1));
		 big_mario_sprite_walk2 big_mario_sprite_walk2_0(.read_address(mario_address), .pixel_color(pixel_color_mario_big_walk_2));
		 big_mario_sprite_walk3 big_mario_sprite_walk3_0(.read_address(mario_address), .pixel_color(pixel_color_mario_big_walk_3));
		 
		 mario_sprite_death mario_sprite_death0(.read_address(mario_address), .pixel_color(pixel_color_mario_dead));
		 
		 //luigi sprites
		 
		 luigi_sprite_still luigi_sprite_still0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_still));
		 luigi_sprite_jump luigi_sprite_jump0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_jump));
		 luigi_sprite_walk1 luigi_sprite_walk1_0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_walk_1));
		 luigi_sprite_walk2 luigi_sprite_walk2_0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_walk_2));
		 luigi_sprite_walk3 luigi_sprite_walk3_0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_walk_3));
		 
		 big_luigi_sprite_still big_luigi_sprite_still0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_big_still));
		 big_luigi_sprite_jump big_luigi_sprite_jump0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_big_jump));
		 big_luigi_sprite_walk1 big_luigi_sprite_walk1_0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_big_walk_1));
		 big_luigi_sprite_walk2 big_luigi_sprite_walk2_0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_big_walk_2));
		 big_luigi_sprite_walk3 big_luigi_sprite_walk3_0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_big_walk_3));
		 
		 luigi_sprite_death luigi_sprite_death0(.read_address(luigi_address), .pixel_color(pixel_color_luigi_dead));
		 
		 // enemy sprites
		 enemy_sprite_walk1 enemy_sprite_walk1_0(.read_address(enemy_address), .pixel_color(pixel_color_enemy_walk_1));
		 enemy_sprite_walk2 enemy_sprite_walk2_0(.read_address(enemy_address), .pixel_color(pixel_color_enemy_walk_2));
		 enemy_sprite_squished enemy_sprite_squished0(.read_address(enemy_address), .pixel_color(pixel_color_enemy_squished));
		 
		 //piranha sprite
		 piranha_sprite piranha_sprite0(.read_address(piranha_address), .pixel_color(pixel_color_piranha));
		 
		 //upgrades
		 red_upgrade_sprite red_upgrade_sprite0(.read_address(upgrade_address), .pixel_color(pixel_color_redupgrade));
		 green_upgrade_sprite green_upgrade_sprite0(.read_address(upgrade_address), .pixel_color(pixel_color_greenupgrade));
		 
		 // question sprites 
		 question_sprite question_sprite0(.read_address(question_address), .pixel_color(pixel_color_question_blink_1));
		 question_empty_sprite question_empty_sprite0(.read_address(question_address), .pixel_color(pixel_color_question_empty));
		 
		 
//		 
//		 game_over_sprite game_over_sprite0(.read_address(game_over_address), .pixel_color(pixel_color_game_over));
//	 	 logo_sprite  logo_sprite0(.read_address(logo_address), .pixel_color(pixel_color_logo));
//		 background_sprite background_sprite(.read_address(mario_background_address), .pixel_color(pixel_color_background));

    always_comb
    begin
//		  if (is_game_over == 1'b1)
//				begin
//					Red = pixel_color_game_over[23:16];
//					Green = pixel_color_game_over[15:8];
//					Blue = pixel_color_game_over[7:0]; 
//				end	
//		  else if (is_logo == 1'b1)
//		  begin
//				if (pixel_color_logo == 24'h00FFCC)
//					begin
//						Red = 8'h00;
//						Green = 8'h00;
//						Blue = 8'h7f - DrawX[9:3];
//					end
//					else 
//					begin
//						Red = pixel_color_logo[23:16];
//						Green = pixel_color_logo[15:8];
//						Blue = pixel_color_logo[7:0];
//					end
//		  end
		  if (is_character1 == 1'b1 || is_character2 == 1'b1)
		  begin
			  if (is_character1 == 1'b1) 
			  begin
					if (mario_health == 2'd0)
					begin
						if (pixel_color_mario_dead == 24'h00FFCC)
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'h7f - DrawX[9:3];
						end
						else 
						begin
							Red = pixel_color_mario_dead[23:16];
							Green = pixel_color_mario_dead[15:8];
							Blue = pixel_color_mario_dead[7:0];
						end
					end
					else if (mario_health == 2'd2)
					begin
						if (is_mario_on_ground == 1'b1)				
						begin
							if (is_mario_walking == 1'b1)
							begin
								if (mario_walk_count == 3'd1)
								begin
									if (pixel_color_mario_big_walk_1 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_mario_big_walk_1[23:16];
										Green = pixel_color_mario_big_walk_1[15:8];
										Blue = pixel_color_mario_big_walk_1[7:0];
									end
								end
								else if (mario_walk_count == 3'd2)
								begin
									if (pixel_color_mario_big_walk_2 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_mario_big_walk_2[23:16];
										Green = pixel_color_mario_big_walk_2[15:8];
										Blue = pixel_color_mario_big_walk_2[7:0];
									end
								end
								else
								begin
									if (pixel_color_mario_big_walk_3 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_mario_big_walk_3[23:16];
										Green = pixel_color_mario_big_walk_3[15:8];
										Blue = pixel_color_mario_big_walk_3[7:0];
									end
								end
							end
							else
							begin
								if (pixel_color_mario_big_still == 24'h00FFCC)
								begin
									Red = 8'h00;
									Green = 8'h00;
									Blue = 8'h7f - DrawX[9:3];
								end
								else 
								begin
									Red = pixel_color_mario_big_still[23:16];
									Green = pixel_color_mario_big_still[15:8];
									Blue = pixel_color_mario_big_still[7:0];
								end
							end
						end
						else
						begin
							if (pixel_color_mario_big_jump == 24'h00FFCC)
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h7f - DrawX[9:3];
							end
							else 
							begin
								Red = pixel_color_mario_big_jump[23:16];
								Green = pixel_color_mario_big_jump[15:8];
								Blue = pixel_color_mario_big_jump[7:0];
							end
						end
					end
					else
					begin
						if (is_mario_on_ground == 1'b1)				
						begin
							if (is_mario_walking == 1'b1)
							begin
								if (mario_walk_count == 3'd1)
								begin
									if (pixel_color_mario_walk_1 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_mario_walk_1[23:16];
										Green = pixel_color_mario_walk_1[15:8];
										Blue = pixel_color_mario_walk_1[7:0];
									end
								end
								else if (mario_walk_count == 3'd2)
								begin
									if (pixel_color_mario_walk_2 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_mario_walk_2[23:16];
										Green = pixel_color_mario_walk_2[15:8];
										Blue = pixel_color_mario_walk_2[7:0];
									end
								end
								else
								begin
									if (pixel_color_mario_walk_3 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_mario_walk_3[23:16];
										Green = pixel_color_mario_walk_3[15:8];
										Blue = pixel_color_mario_walk_3[7:0];
									end
								end
							end
							else
							begin
								if (pixel_color_mario_still == 24'h00FFCC)
								begin
									Red = 8'h00;
									Green = 8'h00;
									Blue = 8'h7f - DrawX[9:3];
								end
								else 
								begin
									Red = pixel_color_mario_still[23:16];
									Green = pixel_color_mario_still[15:8];
									Blue = pixel_color_mario_still[7:0];
								end
							end
						end
						else
						begin
							if (pixel_color_mario_jump == 24'h00FFCC)
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h7f - DrawX[9:3];
							end
							else 
							begin
								Red = pixel_color_mario_jump[23:16];
								Green = pixel_color_mario_jump[15:8];
								Blue = pixel_color_mario_jump[7:0];
							end
						end
					end
				end
			  
			  
	//luigi		  
			  
			  else if (is_character2 == 1'b1)
			  begin
			  if (luigi_health == 2'd0)
					begin
						if (pixel_color_luigi_dead == 24'h00FFCC)
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'h7f - DrawX[9:3];
						end
						else 
						begin
							Red = pixel_color_luigi_dead[23:16];
							Green = pixel_color_luigi_dead[15:8];
							Blue = pixel_color_luigi_dead[7:0];
						end
					end
					else if (luigi_health == 2'd2)
					begin
						if (is_luigi_on_ground == 1'b1)				
						begin
							if (is_luigi_walking == 1'b1)
							begin
								if (luigi_walk_count == 3'd1)
								begin
									if (pixel_color_luigi_big_walk_1 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_luigi_big_walk_1[23:16];
										Green = pixel_color_luigi_big_walk_1[15:8];
										Blue = pixel_color_luigi_big_walk_1[7:0];
									end
								end
								else if (luigi_walk_count == 3'd2)
								begin
									if (pixel_color_luigi_big_walk_2 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_luigi_big_walk_2[23:16];
										Green = pixel_color_luigi_big_walk_2[15:8];
										Blue = pixel_color_luigi_big_walk_2[7:0];
									end
								end
								else
								begin
									if (pixel_color_luigi_big_walk_3 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_luigi_big_walk_3[23:16];
										Green = pixel_color_luigi_big_walk_3[15:8];
										Blue = pixel_color_luigi_big_walk_3[7:0];
									end
								end
							end
							else
							begin
								if (pixel_color_luigi_big_still == 24'h00FFCC)
								begin
									Red = 8'h00;
									Green = 8'h00;
									Blue = 8'h7f - DrawX[9:3];
								end
								else 
								begin
									Red = pixel_color_luigi_big_still[23:16];
									Green = pixel_color_luigi_big_still[15:8];
									Blue = pixel_color_luigi_big_still[7:0];
								end
							end
						end
						else
						begin
							if (pixel_color_luigi_big_jump == 24'h00FFCC)
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h7f - DrawX[9:3];
							end
							else 
							begin
								Red = pixel_color_luigi_big_jump[23:16];
								Green = pixel_color_luigi_big_jump[15:8];
								Blue = pixel_color_luigi_big_jump[7:0];
							end
						end
					end
					else
					begin
						if (is_luigi_on_ground == 1'b1)				
						begin
							if (is_luigi_walking == 1'b1)
							begin
								if (luigi_walk_count == 3'd1)
								begin
									if (pixel_color_luigi_walk_1 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_luigi_walk_1[23:16];
										Green = pixel_color_luigi_walk_1[15:8];
										Blue = pixel_color_luigi_walk_1[7:0];
									end
								end
								else if (luigi_walk_count == 3'd2)
								begin
									if (pixel_color_luigi_walk_2 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_luigi_walk_2[23:16];
										Green = pixel_color_luigi_walk_2[15:8];
										Blue = pixel_color_luigi_walk_2[7:0];
									end
								end
								else
								begin
									if (pixel_color_luigi_walk_3 == 24'h00FFCC)
									begin
										Red = 8'h00;
										Green = 8'h00;
										Blue = 8'h7f - DrawX[9:3];
									end
									else 
									begin
										Red = pixel_color_luigi_walk_3[23:16];
										Green = pixel_color_luigi_walk_3[15:8];
										Blue = pixel_color_luigi_walk_3[7:0];
									end
								end
							end
							else
							begin
								if (pixel_color_luigi_still == 24'h00FFCC)
								begin
									Red = 8'h00;
									Green = 8'h00;
									Blue = 8'h7f - DrawX[9:3];
								end
								else 
								begin
									Red = pixel_color_luigi_still[23:16];
									Green = pixel_color_luigi_still[15:8];
									Blue = pixel_color_luigi_still[7:0];
								end
							end
						end
						else
						begin
							if (pixel_color_luigi_jump == 24'h00FFCC)
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h7f - DrawX[9:3];
							end
							else 
							begin
								Red = pixel_color_luigi_jump[23:16];
								Green = pixel_color_luigi_jump[15:8];
								Blue = pixel_color_luigi_jump[7:0];
							end
						end
					end
			  end
			  else
			  begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h7f - DrawX[9:3];
			  end
		  end
		  else if (is_enemy == 1'b1)
		  begin
				if (enemy_health == 1'b0)
				begin
					if (pixel_color_enemy_squished == 24'h00FFCC)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h7f - DrawX[9:3];
					end
					else
					begin
						Red = pixel_color_enemy_squished[23:16];
						Green = pixel_color_enemy_squished[15:8];
						Blue = pixel_color_enemy_squished[7:0]; 
					end
				end
				else
				begin
					if (enemy_walk_count == 1'b0)
					begin
						if (pixel_color_enemy_walk_1 == 24'h00FFCC)
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'h7f - DrawX[9:3];
						end
						else
						begin
							Red = pixel_color_enemy_walk_1[23:16];
							Green = pixel_color_enemy_walk_1[15:8];
							Blue = pixel_color_enemy_walk_1[7:0]; 
						end
					end
					else
					begin
						if (pixel_color_enemy_walk_2 == 24'h00FFCC)
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'h7f - DrawX[9:3];
						end
						else
						begin
							Red = pixel_color_enemy_walk_2[23:16];
							Green = pixel_color_enemy_walk_2[15:8];
							Blue = pixel_color_enemy_walk_2[7:0]; 
						end
					end
				end
		  end
		  else if (is_redupgrade == 1'b1)
		  begin
				if (pixel_color_redupgrade == 24'h00FFCC)
				begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h7f - DrawX[9:3];
				end
				else
				begin
					Red = pixel_color_redupgrade[23:16];
					Green = pixel_color_redupgrade[15:8];
					Blue = pixel_color_redupgrade[7:0]; 
				end
		  end
		  else if (is_greenupgrade == 1'b1)
		  begin
				if (pixel_color_greenupgrade == 24'h00FFCC)
				begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h7f - DrawX[9:3];
				end
				else
				begin
					Red = pixel_color_greenupgrade[23:16];
					Green = pixel_color_greenupgrade[15:8];
					Blue = pixel_color_greenupgrade[7:0]; 
				end
		  end
		  else if (is_question == 1'b1)
		  begin
				if (is_question_empty == 1'b0)
				begin
					if (pixel_color_question_blink_1 == 24'h00FFCC)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h7f - DrawX[9:3];
					end
					else
					begin
						Red = pixel_color_question_blink_1[23:16];
						Green = pixel_color_question_blink_1[15:8];
						Blue = pixel_color_question_blink_1[7:0];
					end
				end
				else
				begin
					if (pixel_color_question_empty == 24'h00FFCC)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h7f - DrawX[9:3];
					end
					else
					begin
						Red = pixel_color_question_empty[23:16];
						Green = pixel_color_question_empty[15:8];
						Blue = pixel_color_question_empty[7:0];
					end
				end
		  end
		  else if (is_barrier == 1'b1)
		  begin
				if (is_brick == 1'b0 && is_dirt == 1'b0 && is_pipe == 1'b0)
				begin
					Red = pixel_color_ground[23:16];
					Green = pixel_color_ground[15:8];
					Blue = pixel_color_ground[7:0];
				end
				else if (is_brick == 1'b0 && is_dirt == 1'b1 && is_pipe == 1'b0)
				begin
					Red = pixel_color_dirt[23:16];
					Green = pixel_color_dirt[15:8];
					Blue = pixel_color_dirt[7:0];
				end
				else if (is_brick == 1'b0 && is_dirt == 1'b0 && is_pipe == 1'b1)
				begin
					if (pixel_color_pipe == 24'h00FFCC)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h7f - DrawX[9:3];
					end
					else
					begin
						Red = pixel_color_pipe[23:16];
						Green = pixel_color_pipe[15:8];
						Blue = pixel_color_pipe[7:0];
					end
				end
				else
				begin
					Red = pixel_color_brick[23:16];
					Green = pixel_color_brick[15:8];
					Blue = pixel_color_brick[7:0];
				end
		  end
		  else if (is_piranha == 1'b1)
		  begin
				if (piranha_health == 1'b1)
				begin
					if (pixel_color_piranha == 24'h00FFCC)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h7f - DrawX[9:3];
					end
					else
					begin
						Red = pixel_color_piranha[23:16];
						Green = pixel_color_piranha[15:8];
						Blue = pixel_color_piranha[7:0]; 
					end
				end
				else
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h7f - DrawX[9:3];
					end
		  end
		  else 
		  begin
				Red = 8'h00; 
				Green = 8'h00;
				Blue = 8'h7f - DrawX[9:3];
		  end
    end
    
endmodule
