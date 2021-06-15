module enemy ( input        Clk,
                             Reset,
                             frame_clk,
               input [9:0]   DrawX, DrawY,
					input [9:0]   start_x, start_y,
					input [1:0]   level_num, enemy_level_num,
					input [9:0]	  mario_x, mario_y,
									  luigi_x, luigi_y,
					input [9:0]	  mario_Size_Y,
									  luigi_Size_Y,
					input [1:0]	  mario_health,
									  luigi_health,
               output logic  is_enemy,
					output logic  enemy_walk_count,
					output logic  [8:0] enemy_address,
					output logic  [9:0] enemy_X_Pos, enemy_Y_Pos,
					output logic  enemy_health
              );

		// get all of enemy's boundary values
	parameter [9:0] enemy_X_Min = 10'd0;
   parameter [9:0] enemy_X_Max = 10'd639;
   parameter [9:0] enemy_Y_Min = 10'd0;
   parameter [9:0] enemy_Y_Max = 10'd479;
   
	logic [4:0] enemy_X_Vel, enemy_Y_Vel;
   logic [1:0] enemy_death_frame;   // the frames that we cycle through when enemy is dying 
	logic transitioning;
	
	logic [9:0] enemy_X_Pos_next, enemy_Y_Pos_next;
	logic [4:0] enemy_X_Vel_next, enemy_Y_Vel_next;
	logic	enemy_walk_count_next;
	logic enemy_health_next;
	logic [1:0] enemy_death_frame_next;
	
	logic [9:0] enemy_X_Pos_next_temp, enemy_Y_Pos_next_temp;
	logic [9:0] delay;
	
	logic bottom_barrier, bottom_barrier_left, bottom_barrier_right, right_barrier_collision, left_barrier_collision, bottom_barrier_collision, top_barrier_collision, top_barrier_left_collision, top_barrier_right_collision, bottom_barrier_left_collision, bottom_barrier_right_collision;
	
	
	// instantiate barriers
	// instantiations of the rooms module
   // entering the enemy's position and seeing if at a barrier	

	rooms barrier0(
					.DrawX(enemy_X_Pos_next_temp - 10), 
					.DrawY(enemy_Y_Pos_next_temp + 10), 
					.level_num(enemy_level_num), 
					.is_barrier(bottom_barrier_left_collision)
					);
									// adding correct y buffer
	rooms barrier1(
					.DrawX(enemy_X_Pos_next - 6), 
					.DrawY(enemy_Y_Pos_next + 11), 
					.level_num(enemy_level_num), 
					.is_barrier(bottom_barrier_left)
					);
	rooms barrier2(
					.DrawX(enemy_X_Pos_next + 8), 
					.DrawY(enemy_Y_Pos_next + 11), 
					.level_num(enemy_level_num), 
					.is_barrier(bottom_barrier_right)
					);
	rooms barrier3(
					.DrawX(enemy_X_Pos_next_temp + 10), 
					.DrawY(enemy_Y_Pos), 
					.level_num(enemy_level_num), 
					.is_barrier(right_barrier_collision)
					);
				 // making sure that enemy doesn't move right through a wall
	rooms barrier4(
					.DrawX(enemy_X_Pos_next_temp + 10), 
					.DrawY(enemy_Y_Pos_next_temp + 10), 
					.level_num(enemy_level_num), 
					.is_barrier(bottom_barrier_right_collision)
					);
	rooms barrier5(
					.DrawX(enemy_X_Pos_next_temp - 10),
					.DrawY(enemy_Y_Pos), 
					.level_num(enemy_level_num), 
					.is_barrier(left_barrier_collision)
					);
			// making sure that mario doesn't move left through a wall
	rooms barrier6(
					.DrawX(enemy_X_Pos_next),
					.DrawY(enemy_Y_Pos_next + 11), 
					.level_num(enemy_level_num), 
					.is_barrier(bottom_barrier)
					);
	rooms barrier7(
					.DrawX(enemy_X_Pos), 
					.DrawY(enemy_Y_Pos_next_temp - 10), 
					.level_num(enemy_level_num), 
					.is_barrier(top_barrier_collision)
					);
	rooms barrier8(
					.DrawX(enemy_X_Pos_next_temp - 10), 
					.DrawY(enemy_Y_Pos_next_temp - 10), 
					.level_num(enemy_level_num), 
					.is_barrier(top_barrier_left_collision)
					);
	rooms barrier9(
					.DrawX(enemy_X_Pos), 
					.DrawY(enemy_Y_Pos_next_temp + 10), 
					.level_num(enemy_level_num), 
					.is_barrier(bottom_barrier_collision)
					);

			// going to need all of these instantiations since it has to essentially
			// interact the same way as the characters

	rooms barrier10(
					.DrawX(enemy_X_Pos_next_temp + 10), 
					.DrawY(enemy_Y_Pos_next_temp - 10), 
					.level_num(enemy_level_num), 
					.is_barrier(top_barrier_right_collision)
					);

	 
   always_ff @ (posedge Reset or posedge frame_clk)
   begin
		if (Reset)  // if we reset, these are the parameters that we use
      begin
			enemy_health <= 1'b1;
			enemy_X_Pos <= 800;
         enemy_Y_Pos <= 10'd0;
			enemy_X_Vel <= 5'd0;
         enemy_Y_Vel <= 5'd0;
			enemy_walk_count <= 1'b0;
			enemy_death_frame <= 2'b00;
			transitioning <= 1'b1;
			delay <= 10'd0;
		end
		// if the enemy is in our current level and we are not transitioning between levels
		else if (level_num == enemy_level_num && transitioning == 1'b0)
		begin
			enemy_health <= enemy_health_next;
			enemy_X_Pos <= enemy_X_Pos_next;
         enemy_Y_Pos <= enemy_Y_Pos_next;
			enemy_Y_Vel <= enemy_Y_Vel_next;
			enemy_X_Vel <= enemy_X_Vel_next;
			enemy_walk_count <= enemy_walk_count_next;
			enemy_death_frame <= enemy_death_frame_next;
			transitioning <= 1'b0;
			if (delay > 500)    // if the delay is less than 500, then reset it
				delay <= 0;
			else
				delay <= delay + 1; // otherwise we can increment
		end
		else if (level_num == enemy_level_num)  // if our enemy is in our level and we are transitioning into the level
		begin
			enemy_health <= 1'b1; // enemy is alive 
			enemy_X_Pos <= start_x;
         enemy_Y_Pos <= start_y;
			enemy_X_Vel <= 5'b1;
         enemy_Y_Vel <= 5'd0;
			enemy_walk_count <= 1'b0;  // reset the enemy walk count 
			enemy_death_frame <= 2'b00; // set the death frame to 0
			transitioning <= 1'b0;  // transitioning will then get 0 
			delay <= 10'd0;
		end
      else
      begin
			enemy_health <= enemy_health_next;
			enemy_X_Pos <= 800;
         enemy_Y_Pos <= 10'd0;     // enemy functionality by mid point check point 
			enemy_X_Vel <= 10'd0;
			enemy_Y_Vel <= 10'd0;
			enemy_walk_count <= enemy_walk_count_next;
			enemy_death_frame <= enemy_death_frame_next;
			transitioning <= 1'b1;
			if (delay > 500)   // again, 500 to be safe
				delay <= 0;
			else
				delay <= delay + 1;
		end
	end
   always_comb
   begin
		enemy_health_next = enemy_health;
		enemy_X_Pos_next = enemy_X_Pos + enemy_X_Vel;  // set the enemy position equal to his current plus his velocity
		enemy_Y_Pos_next = enemy_Y_Pos + enemy_Y_Vel;  // in case he ever needs to fall off a ledge 
		enemy_X_Pos_next_temp = enemy_X_Pos;
		enemy_Y_Pos_next_temp = enemy_Y_Pos;
		enemy_X_Vel_next = enemy_X_Vel;
		enemy_Y_Vel_next = enemy_Y_Vel;
		enemy_walk_count_next = enemy_walk_count;
		enemy_death_frame_next = enemy_death_frame;
		
		// if enemy is dead
		if (enemy_health == 1'b0)
		begin
			if (delay % 3 == 0)  
			begin
				if (enemy_death_frame < 2'd2)  // if he has frames to cycle throguh
					enemy_death_frame_next = enemy_death_frame + 1'b1;  // increment them 
				else
				begin
					enemy_X_Pos_next = 10'd1000;
					enemy_Y_Pos_next = 10'd1000;   // otherwise store enemy in some place off screen once he is dead
					enemy_X_Vel_next = 5'd0;   // set his velocity to 0 
					enemy_Y_Vel_next = 5'd0;
				end
			end
		end
		
		// if enemy's health is still 1 and he is alive
		else if (enemy_health == 1'b1)
		begin
			if (delay % 10 == 0) // if delay has gone through a multiple of 10 cycles
			begin
				if (enemy_walk_count == 3'd0)  
					enemy_walk_count_next = 3'd1;  // increment his walk count
				else
					enemy_walk_count_next = 3'd0;
			end
			
			if (delay % 10 == 0)   // if delay has gone through 10 - make sure that we can tell if he is walking or not
			begin
				if (enemy_Y_Vel < 5'd4)  // enemy falling down
					enemy_Y_Vel_next = enemy_Y_Vel + 5'd2;
				else
				// else just keep his velocity
					enemy_Y_Vel_next = enemy_Y_Vel;
			end
			else
			begin
				enemy_Y_Vel_next = enemy_Y_Vel;
			end

			// if the enemy comes into contact with a barrier beneath him
			if (bottom_barrier == 1'b1 || bottom_barrier_left == 1'b1 || bottom_barrier_right == 1'b1)
			begin
				// well he can't jump, so this is 0
				enemy_Y_Vel_next = 5'd0; 
			end
								
			enemy_Y_Pos_next_temp = enemy_Y_Pos + enemy_Y_Vel; // update position with his velocity
			// if enemy comes into contact with a barrier above him
			if (top_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || top_barrier_right_collision == 1'b1)
			begin
				// make sure that he is able to handle interaction with a cluster of those barriers
				enemy_Y_Pos_next = enemy_Y_Pos_next_temp - (enemy_Y_Pos_next_temp % 20) + 10; //(enemy_Y_Pos_next_temp + (20 - (enemy_Y_Pos_next_temp % 20)) + 10) - 20;
				enemy_Y_Vel_next = 5'd0;
			end
			else if (bottom_barrier_collision == 1'b1 || bottom_barrier_left_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
			begin
				// same thing with his bottom barriers, if there are multiple 
				enemy_Y_Pos_next = enemy_Y_Pos_next_temp - (enemy_Y_Pos_next_temp % 20) + 9;
			end
			
			// handle his interaction with mario or luigi now 
			// if he comes into contact with any part of mario's bottom boundary 
			if ((((enemy_X_Pos_next < 640 && (mario_x + 10) > (enemy_X_Pos_next - 10) && (mario_x + 10) < (enemy_X_Pos_next + 10)) || 
				((mario_x - 10) > (enemy_X_Pos_next - 10) && (mario_x - 10) < (enemy_X_Pos_next + 10))) && (mario_y + mario_Size_Y) > (enemy_Y_Pos_next - 11) && 
				(mario_y + mario_Size_Y) < enemy_Y_Pos_next && mario_health != 2'd0))
				begin
					enemy_X_Vel_next = 5'd0; // then he will stop moving
					enemy_health_next = 1'b0; // and will be dead 
				end
				
				// if he comes into contact with any part of luigi's bottom boundary while being in the 
				// correct x region
			if ((((enemy_X_Pos_next < 640 && (luigi_x + 10) > (enemy_X_Pos_next - 10) && (luigi_x + 10) < (enemy_X_Pos_next + 10)) || 
				((luigi_x - 10) > (enemy_X_Pos_next - 10) && (luigi_x - 10) < (enemy_X_Pos_next + 10))) &&
				(luigi_y + luigi_Size_Y) > (enemy_Y_Pos_next - 11) && (luigi_y + luigi_Size_Y) < enemy_Y_Pos_next && luigi_health != 2'd0))
				begin
					enemy_X_Vel_next = 5'd0;
					enemy_health_next = 1'b0; // he will die
				end
				
			if (enemy_Y_Pos > 479)
			begin
				enemy_health_next = 1'b0;  // if he falls off a cliff, he will not survive
			end
			
			if (enemy_X_Vel == 5'd1);  // if his velocity is 1
			begin
				enemy_X_Pos_next_temp = enemy_X_Pos + enemy_X_Vel; // update his position
				// if any part of enemy comes into contact with a left barrier
				if (left_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || bottom_barrier_left_collision == 1'b1)
				begin
					// handle for any combo of left barriers
					enemy_X_Pos_next =  enemy_X_Pos_next_temp - (enemy_X_Pos_next_temp % 20) + 10;
					// rebound and start going the other way
					enemy_X_Vel_next = (~(enemy_X_Vel) + 1'b1);
				end
				// same for a right barrier
				else if (right_barrier_collision == 1'b1 || top_barrier_right_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
				begin
					enemy_X_Pos_next = enemy_X_Pos_next_temp - (enemy_X_Pos_next_temp % 20) + 9;
					// start heading left now 
					enemy_X_Vel_next = (~(enemy_X_Vel) + 1'b1);
				end
				else
				begin
					enemy_X_Pos_next = enemy_X_Pos + enemy_X_Vel; // update his posiiton
				end
			end
		end
	end
    
   int pixel_x, pixel_y;  // assign pixel values 
   assign pixel_x = DrawX - enemy_X_Pos + 10;
   assign pixel_y = DrawY - enemy_Y_Pos + 10;
	// make sure pixels are associated with enemy and not a background
   always_comb begin
		if (pixel_x <= 20 && pixel_y <= 20 && pixel_x >= 10'd0 && pixel_y >= 10'd0)
			is_enemy = 1'b1;  // in this case, it is a enemy
		else
			is_enemy = 1'b0;
		if (is_enemy == 1'b1)
		begin
			enemy_address = pixel_x + pixel_y * 21;  // if it is a enemy, use that x + y * width formula from 220
		end
		else
			enemy_address = 9'b0;
	end 
	
endmodule
