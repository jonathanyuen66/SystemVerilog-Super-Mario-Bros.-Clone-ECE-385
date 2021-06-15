module game_over_screen(
					input [9:0]   DrawX, DrawY,
					input [1:0]   mario_life_counter, 
									  luigi_life_counter,
					output  is_game_over,
					output  [19:0] game_over_address
				);
				
	always_comb
	begin
		if (mario_life_counter == 0 && luigi_life_counter == 0)  // if both of the characters are dead 
		begin
			is_game_over = 1'b1;  // game is over 
			game_over_address = DrawX + DrawY * 640;  // set the game over address (takes up the whole screen)
		end
		else
		begin
			is_game_over = 1'b0;
			game_over_address = 20'b0;
		end
	end
			
endmodule
