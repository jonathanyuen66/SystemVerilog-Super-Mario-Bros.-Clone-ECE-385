module insane (
					input         Clk,
                             Reset,
                             frame_clk,
               input [9:0]   DrawX, DrawY,
					input [9:0]   start_x, start_y,
					input [2:0]   level_num, piranha_level_num,
               output logic  is_piranha,
					output logic  [10:0] piranha_address,
					output logic  [9:0] piranha_X_Pos, piranha_Y_Pos,
					output logic  piranha_health
					);
					
					// get the values of piranhas boundaries 
	parameter [9:0] piranha_X_Min = 10'd0;
   parameter [9:0] piranha_X_Max = 10'd639;
   parameter [9:0] piranha_Y_Min = 10'd0;
   parameter [9:0] piranha_Y_Max = 10'd479;
    
	logic [4:0] piranha_Y_Vel;
	logic transitioning;
	
	logic [9:0] piranha_X_Pos_next, piranha_Y_Pos_next;
	logic [4:0] piranha_Y_Vel_next;
	
	logic [9:0] delay;
	 
   always_ff @ (posedge Reset or posedge frame_clk)
   begin
	// if we reset, these are the parameters
		if (Reset)
      begin
			piranha_X_Pos <= 800;
         piranha_Y_Pos <= 10'd0;
			piranha_Y_Vel <= 5'd0;
			transitioning <= 1'b1;
			delay <= 10'd0;
		end
		// if the piranha plant is in our room and we are not transitioning 
		else if (level_num == piranha_level_num && transitioning == 1'b0)
		begin
			piranha_X_Pos <= piranha_X_Pos_next;
         piranha_Y_Pos <= piranha_Y_Pos_next;
			piranha_Y_Vel <= piranha_Y_Vel_next;  // just set his x pos, y pos, and velocity
			transitioning <= 1'b0;
			if (delay > 500)  // 500 to be safe to wait to reset delay
				delay <= 0;
			else
				delay <= delay + 1;
		end
		// if plant is in our room and we are transitioning 
		else if (level_num == piranha_level_num)
		begin
			piranha_X_Pos <= start_x;
         piranha_Y_Pos <= start_y;
			piranha_Y_Vel <= 5'd0;  // set his velocity to 0 
			transitioning <= 1'b0;  // not transitioning is 0
			delay <= 10'd0;
		end
      else
      begin
			piranha_X_Pos <= 800;
         piranha_Y_Pos <= 10'd0;
			piranha_Y_Vel <= 5'd0;
			transitioning <= 1'b1;
			if (delay > 500)
				delay <= 0;
			else
				delay <= delay + 1;  // increment the delay 
		end
	end

   always_comb
   begin
		piranha_X_Pos_next = piranha_X_Pos;
		piranha_Y_Pos_next = piranha_Y_Pos + piranha_Y_Vel;
		piranha_Y_Vel_next = piranha_Y_Vel;
		piranha_health = 1'b1;
		
		// using boundaries on screen as basis for his movement logic in terms of starting and stopping
		// was extremely glitchy.  made it based off of his velocity instead
		if (delay % 50 == 0)   // if we can establish that the piranha plant is moving 
		begin
			if (piranha_Y_Vel == -5'd1)  // have him start moving up, if he is at -1 velocity, start going down at 
			begin									// same velocity
				piranha_Y_Vel_next = 5'd1;
			end
			else if (piranha_Y_Vel == 5'd1)  // else if he is at velocity of 1
			begin
				piranha_Y_Vel_next = 5'd0;  // he will pause 
				piranha_Y_Pos_next = 435;  // make sure this is his stopping point
			end
			else if (piranha_Y_Vel == 5'd0)
			begin
				piranha_Y_Vel_next = -5'd1;  // after pause, start moving back up
			end
		end
	end
    
   int pixel_x, pixel_y;  // get the pixel x and y values of the plant 
   assign pixel_x = DrawX - piranha_X_Pos + 9;  // using his dimensions
   assign pixel_y = DrawY - piranha_Y_Pos + 18;
	
   always_comb begin
		if (pixel_x <= 18 && pixel_y <= 36 && pixel_x >= 10'd0 && pixel_y >= 10'd0)
			is_piranha = 1'b1;  // if within this range, it is a piranha sprite that we should see
		else
			is_piranha = 1'b0;  // other wise its the background
		if (is_piranha == 1'b1)
		begin
			piranha_address = pixel_x + pixel_y * 18;  // use x + y * width formula 
		end
		else
			piranha_address = 9'b0;
	end 
	
endmodule

