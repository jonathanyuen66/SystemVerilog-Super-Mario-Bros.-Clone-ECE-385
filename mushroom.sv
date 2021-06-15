module upgrade (  input         Clk,
                             Reset,
                             frame_clk,
               input [9:0]   DrawX, DrawY,
					input [2:0]   level_num, upgrade_level_num,
					input 		  is_qblock_empty,
					input [9:0]   start_x, start_y,
					input [9:0]	  mario_x, mario_y,
									  luigi_x, luigi_y,
					input [9:0]	  mario_Size_Y,
									  luigi_Size_Y,
					input [1:0]	  mario_health,
									  luigi_health,
               output logic  is_upgrade,
					output logic  [9:0] upgrade_X_Pos, upgrade_Y_Pos,
					output logic  [8:0] upgrade_address 
              );
				  
		// get the boundary values of the upgrade 
	parameter [9:0] upgrade_X_Min = 10'd0;
   parameter [9:0] upgrade_X_Max = 10'd639;
   parameter [9:0] upgrade_Y_Min = 10'd0;
   parameter [9:0] upgrade_Y_Max = 10'd479;
    
	logic [4:0] upgrade_X_Vel, upgrade_Y_Vel;
	logic transitioning;
	logic acquired;
	
	logic [9:0] upgrade_X_Pos_next, upgrade_Y_Pos_next;
	logic [4:0] upgrade_X_Vel_next, upgrade_Y_Vel_next;
	logic acquired_next;
	
	logic [9:0] upgrade_X_Pos_next_temp, upgrade_Y_Pos_next_temp;
	logic [9:0] delay;
	
	// get all the logic for the barriers on every side of the upgrade
	logic bottom_barrier, bottom_barrier_left, bottom_barrier_right, right_barrier_collision, left_barrier_collision, bottom_barrier_collision, top_barrier_collision, top_barrier_left_collision, top_barrier_right_collision, bottom_barrier_left_collision, bottom_barrier_right_collision;
	
	rooms barrier0(
					.DrawX(upgrade_X_Pos_next_temp - 9), 
					.DrawY(upgrade_Y_Pos_next_temp - 9), 
					.level_num(upgrade_level_num), 
					.is_barrier(top_barrier_left_collision)  // handle if at a corner
					);
	rooms barrier1(
					.DrawX(upgrade_X_Pos_next - 7), 
					.DrawY(upgrade_Y_Pos_next + 10), 
					.level_num(upgrade_level_num), 
					.is_barrier(bottom_barrier_left)
					);
	rooms barrier2(
					.DrawX(upgrade_X_Pos_next), 
					.DrawY(upgrade_Y_Pos_next + 10), 
					.level_num(upgrade_level_num), 
					.is_barrier(bottom_barrier)
					);
			// make sure he can't move down through a barrier or up through a barrier 

	rooms barrier3(
					.DrawX(upgrade_X_Pos_next_temp - 9), 
					.DrawY(upgrade_Y_Pos), 
					.level_num(upgrade_level_num), 
					.is_barrier(left_barrier_collision)
					);
	rooms barrier4(
					.DrawX(upgrade_X_Pos_next_temp + 9), 
					.DrawY(upgrade_Y_Pos_next_temp + 9), 
					.level_num(upgrade_level_num), 
					.is_barrier(bottom_barrier_right_collision)
					);
	rooms barrier5(
					.DrawX(upgrade_X_Pos), 
					.DrawY(upgrade_Y_Pos_next_temp - 9),   // don't want to move up through a barrier 
					.level_num(upgrade_level_num), 
					.is_barrier(top_barrier_collision)
					);
	rooms barrier6(
					.DrawX(upgrade_X_Pos_next_temp + 9), 
					.DrawY(upgrade_Y_Pos_next_temp - 9), 
					.level_num(upgrade_level_num), 
					.is_barrier(top_barrier_right_collision)
					);
	rooms barrier7(
					.DrawX(upgrade_X_Pos), 
					.DrawY(upgrade_Y_Pos_next_temp + 9),   // or down through a barier 
					.level_num(upgrade_level_num), 
					.is_barrier(bottom_barrier_collision)
					);
	rooms barrier8(
					.DrawX(upgrade_X_Pos_next_temp + 9), 
					.DrawY(upgrade_Y_Pos), 
					.level_num(upgrade_level_num), 
					.is_barrier(right_barrier_collision)
					);
					// go through the other edges below 
	rooms barrier9(
					.DrawX(upgrade_X_Pos_next_temp - 9), 
					.DrawY(upgrade_Y_Pos_next_temp + 9), 
					.level_num(upgrade_level_num), 
					.is_barrier(bottom_barrier_left_collision)
					);
	rooms barrier10(
					.DrawX(upgrade_X_Pos_next + 7),
					.DrawY(upgrade_Y_Pos_next + 10), 
					.level_num(upgrade_level_num), 
					.is_barrier(bottom_barrier_right)
					);

	 
   always_ff @ (posedge Reset or posedge frame_clk)
   begin
		if (Reset)  // if we reset, these are the parameters 
      begin
			upgrade_X_Pos <= 800;
         upgrade_Y_Pos <= 10'd0;
			upgrade_X_Vel <= 5'd0;
         upgrade_Y_Vel <= 5'd0;
			acquired <= 1'b0;
			transitioning <= 1'b1;
			delay <= 10'd0;
		end
		// if the upgrade is in our current level, and its q block is empty, and we are not transitioning
		// and the upgrade has not been grabbed by a character 
		else if (level_num == upgrade_level_num && is_qblock_empty && transitioning == 1'b0 && acquired != 1'b1)
		begin
			upgrade_X_Pos <= upgrade_X_Pos_next;
         upgrade_Y_Pos <= upgrade_Y_Pos_next;
			upgrade_Y_Vel <= upgrade_Y_Vel_next;  // get the proper velocity 
			upgrade_X_Vel <= upgrade_X_Vel_next;
			acquired <= acquired_next;
			transitioning <= 1'b0;
			if (delay > 500)   // wait for 500 should be good 
				delay <= 0;
			else
				delay <= delay + 1;
		end
		// if the upgrade is in our current level and the block is empty and has not been acquired 
		else if (level_num == upgrade_level_num && is_qblock_empty && acquired != 1'b1)
		begin
			upgrade_X_Pos <= start_x;
         upgrade_Y_Pos <= start_y;
			upgrade_X_Vel <= -5'b1; // start his velocity moving in the left direction 
         upgrade_Y_Vel <= 5'd0;
			acquired <= 1'b0;
			transitioning <= 1'b0;
			delay <= 10'd0;
		end
      else
      begin
			upgrade_X_Pos <= 800;
         upgrade_Y_Pos <= 10'd0;
			upgrade_X_Vel <= 5'd0;  // otherwise the upgrade is not moving 
			upgrade_Y_Vel <= 5'd0;
			acquired <= acquired_next;
			transitioning <= 1'b1;
			if (delay > 500)  // make a constant delay loop 
				delay <= 0;
			else
				delay <= delay + 1;
		end
	end
	
   always_comb
   begin
		upgrade_X_Pos_next = upgrade_X_Pos + upgrade_X_Vel;
		upgrade_Y_Pos_next = upgrade_Y_Pos + upgrade_Y_Vel;
		upgrade_X_Pos_next_temp = upgrade_X_Pos;
		upgrade_Y_Pos_next_temp = upgrade_Y_Pos;
		upgrade_X_Vel_next = upgrade_X_Vel;
		upgrade_Y_Vel_next = upgrade_Y_Vel;
		acquired_next = acquired;	
		// if the upgrade has not been gathered
		if (acquired == 1'b0)
		begin	
			if (delay % 10 == 0)  // and we have waited 10 cycles 
			begin
				if (upgrade_Y_Vel < 5'd4)   // start falling 
				begin
					upgrade_Y_Vel_next = upgrade_Y_Vel + 5'd2;
				end
				else
					upgrade_Y_Vel_next = upgrade_Y_Vel;
			end
			else
			begin
				upgrade_Y_Vel_next = upgrade_Y_Vel;
			end
			
			// if any part of the upgrade comes into contact with any part of mario
			if (((upgrade_X_Pos < 640 && (mario_x + 10) > (upgrade_X_Pos - 9) && (mario_x + 10) < (upgrade_X_Pos + 9)) || 
			   ((mario_x - 10) > (upgrade_X_Pos - 9) && (mario_x - 10) < (upgrade_X_Pos + 9))) &&
				(((mario_y + mario_Size_Y) >= (upgrade_Y_Pos - 9) && (mario_y + mario_Size_Y) <= (upgrade_Y_Pos + 9)) || 
			   ((mario_y - mario_Size_Y) >= (upgrade_Y_Pos - 9) && (mario_y - mario_Size_Y) <= (upgrade_Y_Pos + 9))) && mario_health != 2'd0 )
				begin
					upgrade_X_Vel_next = 5'd0; // it will stop moving 
					acquired_next = 1'b1;  // and be flagged as acquired 
				end
				
			// if any part of the upgrade comes into contact with any part of luigi
			if (((upgrade_X_Pos < 640 && (luigi_x + 10) > (upgrade_X_Pos - 9) && (luigi_x + 10) < (upgrade_X_Pos + 9)) || 
				((luigi_x - 10) > (upgrade_X_Pos - 9) && (luigi_x - 10) < (upgrade_X_Pos + 9))) &&
				(((luigi_y + luigi_Size_Y) >= (upgrade_Y_Pos - 9) && (luigi_y + luigi_Size_Y) <= (upgrade_Y_Pos + 9)) || 
				((luigi_y - luigi_Size_Y) >= (upgrade_Y_Pos - 9) && (luigi_y - luigi_Size_Y) <= (upgrade_Y_Pos + 9))) && luigi_health != 2'd0 )
				begin
					upgrade_X_Vel_next = 5'd0;  // it will stop moving 
					acquired_next = 1'b1;  // and it will be marked as acquired 
				end
			
			// if it has a bottom barrier 
			if (bottom_barrier == 1'b1 || bottom_barrier_left == 1'b1 || bottom_barrier_right == 1'b1)
			begin
				upgrade_Y_Vel_next = 5'd0; // stop moving in the y direciton 
			end
			upgrade_Y_Pos_next_temp = upgrade_Y_Pos + upgrade_Y_Vel; // update its position
			// if it hits a top barrier 
			if (top_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || top_barrier_right_collision == 1'b1)
			begin
				// make sure it will travel along as many as it needs to 
				upgrade_Y_Pos_next = upgrade_Y_Pos_next_temp - (upgrade_Y_Pos_next_temp % 20) + 9;
				upgrade_Y_Vel_next = 5'd0;  // will not be falling anymore 
			end
			// if it his a bottom barrier in its travels 
			else if (bottom_barrier_collision == 1'b1 || bottom_barrier_left_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
			begin
				// make sure it travels along as many as it needs to 
				upgrade_Y_Pos_next = upgrade_Y_Pos_next_temp - (upgrade_Y_Pos_next_temp % 20) + 10;
			end
			
			// if the upgrade is moving left 
			if (upgrade_X_Vel == -5'd1);
			begin
				upgrade_X_Pos_next_temp = upgrade_X_Pos + upgrade_X_Vel;  // update its position
				// if it hits any part of his left barrier 
				if (left_barrier_collision == 1'b1 || top_barrier_left_collision == 1'b1 || bottom_barrier_left_collision == 1'b1)
				begin
					// allow collisions and updates with a combination of barriers 
					upgrade_X_Pos_next = upgrade_X_Pos_next_temp - (upgrade_X_Pos_next_temp % 20) + 9;
					upgrade_X_Vel_next = ~(upgrade_X_Vel) + 1'b1;  // send it the other way 
				end
				else
				begin
					upgrade_X_Pos_next = upgrade_X_Pos + upgrade_X_Vel; // update its position 
				end
			end
			// it he is moving right, replicate that logic 
			if (upgrade_X_Vel == 5'd1)
			begin
				upgrade_X_Pos_next_temp = upgrade_X_Pos + upgrade_X_Vel;
				// if any part of his right boundary hits a barrier 
				if (right_barrier_collision == 1'b1 || top_barrier_right_collision == 1'b1 || bottom_barrier_right_collision == 1'b1)
				begin
				// handle the same way as other directions 
					upgrade_X_Pos_next = upgrade_X_Pos_next_temp - (upgrade_X_Pos_next_temp % 20) + 10;
					upgrade_X_Vel_next = ~(upgrade_X_Vel) + 1'b1; // and send him the other way 
				end
				else
				begin
					upgrade_X_Pos_next = upgrade_X_Pos + upgrade_X_Vel;  // update his position 
				end
			end
			
			if (upgrade_Y_Pos > 479) // if the upgrade falls off a clipp, 
			begin
				acquired_next = 1'b1;  // just mark it as acquired 
			end
		end
	end
    
   int pixel_x, pixel_y;  // get his pixels 
   assign pixel_x = DrawX - upgrade_X_Pos + 9;
   assign pixel_y = DrawY - upgrade_Y_Pos + 9;
	
   always_comb begin
		if (pixel_x <= 18 && pixel_y <= 18 && pixel_x >= 10'd0 && pixel_y >= 10'd0)
			is_upgrade = 1'b1; // confirm that it is a upgrade by checking the range 
		else
			is_upgrade = 1'b0;  // other wise it is not a upgrade 
		if (is_upgrade == 1'b1)
		begin
			upgrade_address = pixel_x + pixel_y * 18; // use the x * y * width formula 
		end
		else
			upgrade_address = 9'b0;
	end 
	
endmodule