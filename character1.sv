module  character1 ( input         Clk,
                             Reset,
									  Run,
                             frame_clk,
					input [2:0]	  level_sel,
               input [9:0]   DrawX, DrawY,
					input 		  w_press, a_press, d_press,
					input	[9:0]   enemy_x,
									  enemy_y,
									  piranha_x,
									  piranha_y,
									  redupgrade_x,
									  redupgrade_y,
									  greenupgrade_x,
									  greenupgrade_y,
					input			  othercharacter_transitioning,
					input [1:0]	  othercharacter_health,
					output logic  [9:0] character_X_Pos,
											  character_Y_Pos,
					output logic  [9:0] character_Size_Y,
               output logic  is_character,
					output logic  [9:0] character_address,
					output logic  on_ground,     // is on the ground for gravity and jumping logic
					output logic  is_walking,
					output logic  [1:0]  walk_count,
					output logic  [1:0]  character_health,
					output logic  [2:0] level_num,
					output logic  [1:0] life_counter,
					output logic transitioning
              );

	parameter [9:0] character_X_Center = 10'd60;   // get the x value of the middle of mario
   parameter [9:0] character_Y_Center = 10'd400;  // get the y value of the midde of mario

	// getting these ready so we can compare mario to his surronding's location
	parameter [9:0] character_X_Min = 10'd0;   // get the x value of mario's bottom bound
   parameter [9:0] character_X_Max = 10'd639; // get the x value of mario's top boundary
   parameter [9:0] character_Y_Min = 10'd0;   // get the y value of mario's bottom boundary
   parameter [9:0] character_Y_Max = 10'd479; // get the y vaue of mario's top boundary
   parameter [9:0] character_X_Step = 10'd2;  // get the value of mario's x direction step -> 2 looked the best
   
	// prepare his x and y velocity and logic for which way he is facing
	logic [4:0] character_X_Vel, character_Y_Vel;
	logic direction; 
	logic Respawn;   // does he have to respawn?
	
	// get location of character on screen
	logic [9:0] character_X_Pos_next, character_Y_Pos_next;
	logic [4:0] character_X_Vel_next, character_Y_Vel_next;
	logic [9:0] character_X_Pos_next_temp, character_Y_Pos_next_temp, character_Size_Y_next;
//	logic [9:0] character_Size_Y_next;
	logic direction_next;
	logic on_ground_next;
	logic is_walking_next;
	logic [1:0] walk_count_next;
	logic [1:0] character_health_next;  // we need these 'next' bits later in our logic if a transition is happening
	logic [1:0] level_num_next;         // or if we need to temporarily handle one of those values
	logic transitioning_next;
	logic [1:0] life_counter_next;
	logic respawn_next;
	logic [9:0] delay;  // delay for animations throughout this project
	
	// need these to establish wall boundaries
	logic bottom_barrier, bottom_barrier_left, bottom_barrier_right, right_barrier_collision, left_barrier_collision, bottom_barrier_collision, top_barrier_collision, top_barrier_left_collision, top_barrier_right_collision, bottom_barrier_left_collision, bottom_barrier_right_collision;
//	assign on_ground_hex = on_ground;
	
	
	//instantiate barriers
	// instantiations of the rooms module
   //entering the character's position and seeing if at a barrier	
	rooms barrier0(
					.DrawX(character_X_Pos_next_temp - 10'd10), 
					.DrawY(character_Y_Pos_next_temp - character_Size_Y), 
					.level_num(level_num), 
					.is_barrier(top_barrier_left_collision)
					);
	rooms barrier1(
					.DrawX(character_X_Pos_next_temp - 10'd10),
					.DrawY(character_Y_Pos_next_temp + character_Size_Y), 
					.level_num(level_num), 
					.is_barrier(bottom_barrier_left_collision)
					);
	rooms barrier2(                                                    
					.DrawX(character_X_Pos_next),   
					.DrawY(character_Y_Pos_next + character_Size_Y + 1),  
					.level_num(level_num), 
					.is_barrier(bottom_barrier)
					);
				// adding correct y buffer
	rooms barrier3(
					.DrawX(character_X_Pos_next_temp + 10'd10), 
					.DrawY(character_Y_Pos_next_temp + character_Size_Y),  
					.level_num(level_num),                                 
					.is_barrier(bottom_barrier_right_collision)
					);
	rooms barrier4(
					.DrawX(character_X_Pos_next + 8),    
					.DrawY(character_Y_Pos_next + character_Size_Y + 1), 
					.level_num(level_num), 
					.is_barrier(bottom_barrier_right)
					);
	rooms barrier5(
					.DrawX(character_X_Pos_next - 6),
					.DrawY(character_Y_Pos_next + character_Size_Y + 1), 
					.level_num(level_num), 
					.is_barrier(bottom_barrier_left)
					);
					 // making sure that luigi doesn't move right through a wall
	rooms barrier6(
					.DrawX(character_X_Pos_next_temp + 10'd10),  
					.DrawY(character_Y_Pos), 
					.level_num(level_num), 
					.is_barrier(right_barrier_collision)
					);
					// making sure that luigi doesn't move left through a wall
	rooms barrier7(
					.DrawX(character_X_Pos_next_temp - 10'd10),   
					.DrawY(character_Y_Pos), 
					.level_num(level_num), 
					.is_barrier(left_barrier_collision)
					);
	rooms barrier8(
					.DrawX(character_X_Pos), 
					.DrawY(character_Y_Pos_next_temp + character_Size_Y), 
					.level_num(level_num), 
					.is_barrier(bottom_barrier_collision)
					);
	rooms barrier9(
					.DrawX(character_X_Pos_next_temp + 10'd10), 
					.DrawY(character_Y_Pos_next_temp - character_Size_Y), 
					.level_num(level_num), 
					.is_barrier(top_barrier_right_collision)
					);
					 // after all of these, this should cover all the ways luigi
					 // could interact with a boundary 
	rooms barrier10(
					.DrawX(character_X_Pos), 
					.DrawY(character_Y_Pos_next_temp - character_Size_Y), 
					.level_num(level_num), 
					.is_barrier(top_barrier_collision)
					);
	
   always_ff @ (posedge Reset or posedge frame_clk )
   begin
		// if we reset, these are the parameter values for mario
		if (Reset)
      begin
			level_num <= 3'b000;
			character_health <= 2'd1;
			life_counter <= 2'd2;
			character_X_Pos <= character_X_Center;
         character_Y_Pos <= character_Y_Center;
         character_Y_Vel <= 5'd0;
			character_Size_Y <= 10'd10;
			is_walking <= 1'b0;
			walk_count <= 2'b0;
			direction <= 1'b1;
			on_ground <= on_ground_next;
			transitioning <= 1'b0;
			Respawn <= 1'b0;
			delay <= 10'd0;
		end
		
		//parameters if mario is running
		else if(Run)
		begin
			level_num <= level_sel;
			character_health <= 2'd1;
			life_counter <= life_counter_next;
			character_X_Pos <= character_X_Center;
         character_Y_Pos <= character_Y_Center;
         character_Y_Vel <= 5'd0;
			character_Size_Y <= 10'd10;
			is_walking <= 1'b0;
			walk_count <= 2'b0;
			direction <= 1'b1;
			on_ground <= on_ground_next;
			transitioning <= 1'b0;
			Respawn <= 1'b0;
			delay <= 10'd0;
		end
		
		// if the character has respawned but not transitioning between rooms and they are not yet dead
		else if (Respawn == 1'b1 && transitioning == 1'b0 && life_counter > 0)
		begin
			level_num <= level_num_next;
			character_health <= 2'd1;
			life_counter <= life_counter_next;
			character_X_Pos <= character_X_Center;
         character_Y_Pos <= character_Y_Center;
         character_Y_Vel <= 5'd0;
			character_Size_Y <= 10'd10;
			is_walking <= 1'b0;
			walk_count <= 2'b0;
			direction <= 1'b1;
			on_ground <= on_ground_next;
			transitioning <= 1'b0;
			Respawn <= 1'b0;
			delay <= 10'd0;
		end
		
		// if the both characters are in the middle of transitioning rooms
		// or if only this character is transitioning rooms but the other one is dead
		else if ((othercharacter_transitioning == 1'b1 && transitioning == 1'b1)  || (othercharacter_health == 2'd0 && transitioning == 1'b1)) // level transition
		begin
			level_num <= level_num_next;
			character_health <= character_health_next;
			life_counter <= life_counter_next;
			character_X_Pos <= character_X_Center;
         character_Y_Pos <= character_Y_Center;
         character_Y_Vel <= 5'd0;
			character_Size_Y <= character_Size_Y_next;
			is_walking <= 1'b0;
			walk_count <= 2'b0;
			direction <= 1'b1;
			on_ground <= on_ground_next;
			transitioning <= 1'b0;
			Respawn <= 1'b0;
			delay <= 10'd0;
		end

		// otherwise we can set these
      else
      begin
			level_num <= level_num_next;
			character_health <= character_health_next;
			life_counter <= life_counter_next;
			character_X_Pos <= character_X_Pos_next;
         character_Y_Pos <= character_Y_Pos_next;
			character_Y_Vel <= character_Y_Vel_next;
			character_Size_Y <= character_Size_Y_next;
			is_walking <= is_walking_next;
			walk_count <= walk_count_next;
			direction <= direction_next;
			on_ground <= on_ground_next;
			transitioning <= transitioning_next;
			Respawn <= respawn_next;
			if (delay > 500)   // reset the delay after it gets past a certain point, probably as long as its bigger than 500 
				delay <= 0;      // 500 to be safe
			else
			begin       // otherwise, we can increment it 
				delay <= delay + 1;
			end
		end
	end

   always_comb
   begin
		level_num_next = level_num;
		character_health_next = character_health;
		life_counter_next = life_counter;
		character_X_Pos_next = character_X_Pos;
		character_Y_Pos_next = character_Y_Pos + character_Y_Vel;
		character_X_Pos_next_temp = character_X_Pos;
		character_Y_Pos_next_temp = character_Y_Pos;
		character_Y_Vel_next = character_Y_Vel;
		character_Size_Y_next = character_Size_Y;
		is_walking_next = 1'b0;
		walk_count_next = walk_count;
		direction_next = direction;
		on_ground_next = on_ground;
		transitioning_next = 1'b0;
		respawn_next = 1'b0;
		
		//death animation
		if (character_health == 2'd0)   // if mario health is 0
		begin
			if (delay % 5 == 0)     // cycle of length 5 - make sure we are registering properly his death, giving it enough cycles
			begin
				if (character_Y_Vel == 5'd0)
					character_Y_Vel_next = -5'd5;      // this is the rate we found to be best after some research
				else if (character_Y_Vel == -5'd5)    // and trial and error
					character_Y_Vel_next = -5'd3;
				else if (character_Y_Vel == -5'd3)
					character_Y_Vel_next = -5'd1;
				else if (character_Y_Vel == -5'd1)
					character_Y_Vel_next = 5'd1;
				else if (character_Y_Vel < 5'd4 && character_Y_Vel != 5'd0)
				begin
					character_Y_Vel_next = character_Y_Vel + 5'd2;  // added a little thing so he performs the behavior 
				end																// of doing a small hop before falling down
				else
					character_Y_Vel_next = character_Y_Vel;
			end
			else
			begin
				character_Y_Vel_next = character_Y_Vel;
			end
			
			
			//respawn logic
			if (delay % 250 == 0)    // this many cycles until mario respawns back at the beginning of the screen
			begin
				if (life_counter > 0)
				begin
					life_counter_next = life_counter_next - 1;  // decrement his lives now
					respawn_next = 1'b1;
				end
				else
				begin
					respawn_next = 1'b0;
				end
			end
		end
		
		else if (character_health != 2'd0)  // if the character is still alive 
		begin
			if (delay % 5 == 0)  // cycles this long for smooth animation
			begin
				if (is_walking == 1'b1)
				begin
					if (walk_count < 3'd2)
						walk_count_next = walk_count + 3'd1;     // cycle through all of mario's walking frames
					else if (walk_count == 3'd2)
						walk_count_next = 3'd0;
				end
				else
					walk_count_next = 3'd0;
			end
			
			// this handles the simulated gravity that you can see during a jump
			if (delay % 10 == 0)
			begin
				if (character_Y_Vel < 5'd4)
				begin
					character_Y_Vel_next = character_Y_Vel + 5'd2;  // take mario off the ground 
					on_ground_next = 1'b0;
				end
				else if (character_Y_Vel == -5'd5)  // start the process of rising upwards in a physically realistic manner
					character_Y_Vel_next = -5'd3;
				else if (character_Y_Vel == -5'd3)   // this same progression for natural falling look
					character_Y_Vel_next = -5'd1;
				else if (character_Y_Vel == -5'd1)  // start the progression downwards
					character_Y_Vel_next = 5'd0;
				else
					character_Y_Vel_next = character_Y_Vel;  
			end
			else
			begin
				character_Y_Vel_next = character_Y_Vel;
			end
			
			// make sure that some part of mario's bottom boundary is against a surface he can walk on
			if (bottom_barrier == 1'b1 || bottom_barrier_left == 1'b1 || bottom_barrier_right == 1'b1)  
			begin
				character_Y_Vel_next = 5'd0;  // not moving vertically
				on_ground_next = 1'b1;  // will stay on the ground
				if (a_press == 1'b1 || d_press == 1'b1)  // these keys handle mario running
					is_walking_next = 1'b1;
			end
								
			character_Y_Pos_next_temp = character_Y_Pos + character_Y_Vel; // the next y position is that of his current plus his velocity - easy
			// make sure that some part of mario's top boundary is against a surface - don't want to go through that
			if (top_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || top_barrier_right_collision == 1'b1)
			begin
				// top barrier is given a y value, but it extends downwards
				// we need to make sure that mario's head is hitting and stopping at the bottom of the block
				// the width of the characters and blocks is 20 pixels
				character_Y_Pos_next =  character_Size_Y + character_Y_Pos_next_temp - (character_Y_Pos_next_temp %20); 
				character_Y_Vel_next = 5'd0;
			end
			// same logic but for the bottom of a block that he is standing on 
			else if (bottom_barrier_collision == 1'b1 || bottom_barrier_left_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
			begin
				character_Y_Pos_next = character_Y_Pos_next_temp - character_Size_Y - (character_Y_Pos_next_temp % 20) + 19; 
			end
			
			// if the character position is past the bottom of the screen
			if (character_Y_Pos > 479)
			begin
				character_Y_Vel_next = -5'd5;
				character_health_next = 2'd0;  // he will die
				character_Size_Y_next = 10'd10;  // and shrink back to 21 pixels tall
			end
			
			// ********************************************************
			
			// starting to handle enemy interactions

			
			//enemy interaction
			if (on_ground == 1'b1)  // if we are on the ground
			begin
				if ((((character_X_Pos_next + 10) > (enemy_x - 10) && (character_X_Pos_next + 10) < (enemy_x + 10)) || 
					((character_X_Pos_next - 10) > (enemy_x - 10) && (character_X_Pos_next - 10) < (enemy_x + 10))) &&
					(((character_Y_Pos_next + character_Size_Y) >= (enemy_y) && (character_Y_Pos_next + character_Size_Y) <= (enemy_y + 10)) || 
					((character_Y_Pos_next - character_Size_Y) >= (enemy_y) && (character_Y_Pos_next - character_Size_Y) <= (enemy_y + 10))))
				// if any of mario's edges come in to contact with a enemy edge while he is walking, he will die
					begin
						character_health_next = character_health - 1'b1;
						character_Size_Y_next = 10'd10;  // and shrink back to 20 pixels height if he was in big mode
					end
			end
			
			
			if (on_ground == 1'b0)  // but this time if we are not on the ground
			begin
				// if mario is not on the ground and he is within enemy's x-region, and is above enemy and comes into contact
				// with a top edge, he will bounce off the enemy
				if ((((character_X_Pos_next - 10) > (enemy_x - 10) && character_X_Pos_next < 60 && (character_X_Pos_next - 10) < (enemy_x + 10))|| 
					(character_X_Pos_next < 640 && (character_X_Pos_next + 10) > (enemy_x - 10) && (character_X_Pos_next + 10) < (enemy_x + 10)))  && 
					(character_Y_Pos_next + character_Size_Y) > (enemy_y - 11) && character_Y_Pos_next < 480 && (character_Y_Pos_next + character_Size_Y) < enemy_y )
					begin
						character_Y_Vel_next = -5'd3;
					end
			end
			
			//piranha interaction
			// if our character comes into any edge that is common with the piranha, he will die and shrink
			if ((((character_X_Pos + 10) > (piranha_x - 10) && character_X_Pos_next < 640 && (character_X_Pos + 10) < (piranha_x + 10)) ||  ((character_X_Pos - 10) > (piranha_x - 10) && (character_X_Pos - 10) < (piranha_x + 10))) &&
				(((character_Y_Pos + character_Size_Y) >= (piranha_y - 10) && (character_Y_Pos + character_Size_Y) <= (piranha_y + 10)) || 
				(character_Y_Pos_next < 480 && (character_Y_Pos - character_Size_Y) >= (piranha_y - 10) && (character_Y_Pos - character_Size_Y) <= (piranha_y + 10))) &&
				character_health != 2'd0 )
			begin
				character_health_next = character_health - 1'b1;
				character_Size_Y_next = 10'd10;
			end
			
			//red upgrade interaction
			// if any part of our character comes into contact with any part of the upgrade, then we will get its powers
			if (((character_X_Pos_next < 640 && (character_X_Pos + 10) > (redupgrade_x - 10) && (character_X_Pos + 10) < (redupgrade_x + 10)) || 
				((character_X_Pos - 10) > (redupgrade_x - 10) && (character_X_Pos - 10) < (redupgrade_x + 10))) &&
				(((character_Y_Pos + character_Size_Y) >= (redupgrade_y - 10) && (character_Y_Pos + character_Size_Y) <= (redupgrade_y + 10)) || 
				(character_Y_Pos_next < 480 && (character_Y_Pos - character_Size_Y) >= (redupgrade_y - 10) && (character_Y_Pos - character_Size_Y) <= (redupgrade_y + 10))) && character_health != 2'd0 )
				begin
					character_Size_Y_next = 10'd20;  // for the red upgrade , we will double mario's height
					character_health_next = 2'd2;  // his health is 2
				end
				
			//green upgrade interaction
			// if any part of mario comes into contact with any part of the upgrade, then we get that extra life
			if (((character_X_Pos_next < 640 && (character_X_Pos + 10) > (greenupgrade_x - 10) && (character_X_Pos + 10) < (greenupgrade_x + 10)) || 
				((character_X_Pos - 10) > (greenupgrade_x - 10) && (character_X_Pos - 10) < (greenupgrade_x + 10))) &&
				(((character_Y_Pos + character_Size_Y) >= (greenupgrade_y - 10) && (character_Y_Pos + character_Size_Y) <= (greenupgrade_y + 10)) || 
				(character_Y_Pos_next < 480 && (character_Y_Pos - character_Size_Y) >= (greenupgrade_y - 10) && (character_Y_Pos - character_Size_Y) <= (greenupgrade_y + 10))) && character_health != 2'd0 )
				begin
					life_counter_next = life_counter_next + 1'b1;
				end
			
			//**********************************************************************************************************************************************
			
			// transitioning levels
			if (on_ground == 1'b1)
			begin
				if (character_X_Pos_next >= 600)
				begin
				// no matter what level you are in, your next level is going to be level 0
					if (level_num == 3'b001)  // if we are in level 1, the next level is 0
						begin
							level_num_next = 3'b000;
							transitioning_next = 1'b1;
						end
					else if (level_num == 3'b010)
						begin
							level_num_next = 3'b000;
							transitioning_next = 1'b1;
						end
					else if (level_num == 3'b011)
						begin
							level_num_next = 3'b100;
							transitioning_next = 1'b1;
						end
					else if (level_num == 3'b100)
						begin
							level_num_next = 3'b000;
							transitioning_next = 1'b1;
						end
					else
						begin
							level_num_next = 3'b000;
							transitioning_next = 1'b1;
						end
				end
			end
			
			//if we press the up button
			if (w_press == 1'b1)
			begin
				on_ground_next = 1'b0; // we are no longer on the ground
				// if we are pressing the up arrow while any part of mario's foot is on the ground
				if (bottom_barrier == 1'b1 || bottom_barrier_left == 1'b1 || bottom_barrier_right == 1'b1)
				begin
					character_Y_Vel_next = -5'd5; // then we can jump up
				end
				
				character_Y_Pos_next_temp = character_Y_Pos + character_Y_Vel;
				// don't go through a ceiling if you're pressing an up key
				if (top_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || top_barrier_right_collision == 1'b1)
				begin
					// handle with proper width of a stretch of blocks 
					character_Y_Pos_next =  character_Size_Y + character_Y_Pos_next_temp - (character_Y_Pos_next_temp % 20); 
					character_Y_Vel_next = 5'd0;	
				end
				else if (bottom_barrier_collision == 1'b1 || bottom_barrier_left_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
				begin
					character_Y_Pos_next = character_Y_Pos_next_temp - character_Size_Y - (character_Y_Pos_next_temp % 20) + 19;
				end
			end
			
			if (a_press == 1'b1) // if we press the left key
			begin
				direction_next = 1'b0; // mario will face left now 
				character_X_Pos_next_temp = character_X_Pos - character_X_Step; // move in the left direction
				if (left_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || bottom_barrier_left_collision == 1'b1)
				begin
					// be prepared for any height of barriers
					character_X_Pos_next =  character_X_Pos_next_temp - (character_X_Pos_next_temp % 20) + 10; 
				end
				else
				begin
					character_X_Pos_next = character_X_Pos - character_X_Step;  // if nothing there then we can move
				end
				// realized that you can still be moving vertically even if you are only pressing the left/right keys 
				// so this is how we handle that scenario
				character_Y_Pos_next_temp = character_Y_Pos + character_Y_Vel;
				if (top_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || top_barrier_right_collision == 1'b1)
				begin
					// don't move through a sequence of barriers
					character_Y_Pos_next = character_Size_Y + character_Y_Pos_next_temp - (character_Y_Pos_next_temp % 20); 
					character_Y_Vel_next = 5'd0;
				end
				else if (bottom_barrier_collision == 1'b1 || bottom_barrier_left_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
				begin
				// or ones that are below you
					character_Y_Pos_next =  character_Y_Pos_next_temp - character_Size_Y - (character_Y_Pos_next_temp % 20) + 19; 
				end
			end
			// logic if we press the right key, same as if we pressed the left
			if (d_press == 1'b1)
			begin
				direction_next = 1'b1;
				character_X_Pos_next_temp = character_X_Pos + character_X_Step;  // move right
				if (right_barrier_collision == 1'b1 || top_barrier_right_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
				begin
					character_X_Pos_next = character_X_Pos_next_temp - (character_X_Pos_next_temp %20) + 9; 
				end
				else
				begin
					character_X_Pos_next = character_X_Pos + character_X_Step;
				end
				
				character_Y_Pos_next_temp = character_Y_Pos + character_Y_Vel;
				if (top_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || top_barrier_right_collision == 1'b1)
				begin
					character_Y_Pos_next = character_Size_Y + character_Y_Pos_next_temp - (character_Y_Pos_next_temp % 20);
					character_Y_Vel_next = 5'd0;
				end
				else if (bottom_barrier_collision == 1'b1 || bottom_barrier_left_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
				begin
					character_Y_Pos_next = character_Y_Pos_next_temp - character_Size_Y - (character_Y_Pos_next_temp % 20) + 19; 
				end
			end
		end
	end
    
   int pixel_x, pixel_y;
   assign pixel_x = DrawX - character_X_Pos + 10'd10;  // compute the address of the character
   assign pixel_y = DrawY - character_Y_Pos + character_Size_Y;
	
   always_comb begin
	// figure out which pixel is a background pixel or a character pixel 
		if (pixel_x <= (20) && pixel_y <= (character_Size_Y*2) && pixel_x >= 0 && pixel_y >= 0)
			is_character = 1'b1;
		else
			is_character = 1'b0;
			// check that it is a character
		if (is_character == 1'b1)
		begin
			if (direction == 1'b1)
			// get that character address 
			// use dimensions of the character
				character_address = pixel_x + pixel_y * 21;
			else
			// if the pixel_x is less than 10 
				if (pixel_x < 10)
				// use the x + y * width formula like accessing elements in arrays organized as 1-D
					character_address = (20 - pixel_x) + pixel_y * 21;
				else if (pixel_x > 10)
				// flip the x coord if pixel_x is greater than 10
					character_address = (0 - pixel_x) + pixel_y * 21;
				else
					character_address = pixel_x + pixel_y * 21;
		end
		else
			character_address = 9'b0;
	end 
	
endmodule
