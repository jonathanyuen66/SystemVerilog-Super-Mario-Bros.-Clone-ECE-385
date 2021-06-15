module question(
					input        Clk,
                            Reset,
                            frame_clk,
               input [9:0]  DrawX, DrawY,
					input [2:0]  level_num,
					input	[2:0]	 question_level_num,
					input [9:0]  block_x, block_y,
					input [9:0]	 mario_x, mario_y,
									 luigi_x, luigi_y,
					input [9:0]	 mario_Size_Y,
									 luigi_Size_Y,
					input [1:0]	 mario_health,
									 luigi_health,
               output logic is_question,
					output logic is_question_empty,
					output logic [8:0] question_address
				 );
	
	logic [9:0] question_X_Pos, question_Y_Pos;
	
	logic	is_question_empty_next;
	logic [9:0] question_X_Pos_next, question_Y_Pos_next;
	
	logic [9:0] delay;
	 
   always_ff @ (posedge Reset or posedge frame_clk)
   begin
		if (Reset)  // if we reset, these are the parameters 
      begin
			is_question_empty <= 1'b0;
			question_X_Pos <= 10'd800;
			question_Y_Pos <= 10'd0;
			delay <= 10'd0;
		end
		else if (level_num == question_level_num)  // if the level num is the same as the question level 
		begin
			is_question_empty <= is_question_empty_next;  // update its empty status 
			question_X_Pos <= block_x;
         question_Y_Pos <= block_y;
			if (delay > 500)    //create a delay loop 
				delay <= 0;
			else
				delay <= delay + 1;  // update 
		end
      else
      begin
			is_question_empty <= is_question_empty_next;
			question_X_Pos <= 10'd800;  // set its position on the screen 
         question_Y_Pos <= 10'd0;
			delay <= 0;
		end
	end

   always_comb
   begin
      question_X_Pos_next = question_X_Pos;
      question_Y_Pos_next = question_Y_Pos;
		is_question_empty_next = is_question_empty;	
		if (is_question_empty == 1'b0)  // if the block is not empty yet 
		begin
			// mario its it from beneath and marrio is not dead
			if ( ((mario_x + 7 >= question_X_Pos && mario_x <= question_X_Pos + 13) || (mario_x >= question_X_Pos + 7 && mario_x <= question_X_Pos + 27)) &&
				  ((mario_y - mario_Size_Y <= question_Y_Pos + 21) && (mario_y - mario_Size_Y > question_Y_Pos + 9)) && mario_health != 2'd0
				)
				begin
					is_question_empty_next = 1'b1;  // the q block will then be empty 
				end
				
				// if luigi hits the q block from beneath 
			if ( ((luigi_x + 7 >= question_X_Pos && luigi_x <= question_X_Pos + 13) || (luigi_x >= question_X_Pos + 7 && luigi_x <= question_X_Pos + 27)) &&
				  ((luigi_y - luigi_Size_Y <= question_Y_Pos + 21) && (luigi_y - luigi_Size_Y > question_Y_Pos + 9)) && luigi_health != 2'd0
				)
				begin
					is_question_empty_next = 1'b1; // the q block wil then be empty 
				end
		end
	end
	
   always_comb 
	begin
	// same check if the q block is a q block in terms of what we want to render
	// q block is stationary though, so we don't need to dynamically check 
		if (DrawX >= question_X_Pos && DrawY >= question_Y_Pos && DrawX <= (question_X_Pos + 20) && DrawY <= (question_Y_Pos + 20))
			is_question = 1'b1;
		else
			is_question = 1'b0;
		// this isn't a q block that we want to see 
		if (is_question == 1'b1)
		begin
			question_address = (DrawX % 20) + (DrawY % 20) * 20;  // set the correct question address just using his dimensions 
		end
		else
			question_address = 9'b0;
	end
	
endmodule
