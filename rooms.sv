module rooms (
            input [9:0]   DrawX, DrawY,
				input [2:0]   level_num,
				output logic [10:0] barrier_address,
            output logic  is_barrier,
				output logic  is_brick,
				output logic  is_dirt,
				output logic  is_pipe
				);
	// in this module we design all of the levels
	always_comb 
	begin
		case (level_num)
			3'b000: 
				begin
					// this is us drawing the ground tiles
						if ( (DrawX >= 0) && (DrawX < 640) && (DrawY >= 460) && (DrawY < 480) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b1;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 0) && (DrawX < 640) && (DrawY >= 440) && (DrawY < 460) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else
						begin
							is_barrier = 1'b0;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
				end
				3'b001: 
				begin
					//here we make a brick platform above the ground
						if ( (DrawX >= 80) && (DrawX < 140) && (DrawY >= 360) && (DrawY < 380) )
						begin
							is_barrier = 1'b1;
							is_brick = 1'b1;
							is_dirt = 1'b0;
							is_pipe = 1'b0;
						end
					// making the ground tiles
						else if ( (DrawX >= 0) && (DrawX < 320) && (DrawY >= 460) && (DrawY < 480) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b1;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 320) && (DrawX < 480) && (DrawY >= 460) && (DrawY < 480) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 480) && (DrawX < 640) && (DrawY >= 460) && (DrawY < 480) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b1;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 0) && (DrawX < 320) && (DrawY >= 440) && (DrawY < 460) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end

						else if ( (DrawX >= 480) && (DrawX < 640) && (DrawY >= 440) && (DrawY < 460) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else
						begin
							is_barrier = 1'b0;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
				end
				3'b010: 
				begin
					// ground 
						if ( (DrawX >= 0) && (DrawX < 200) && (DrawY >= 460) && (DrawY < 480) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b1;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 0) && (DrawX < 200) && (DrawY >= 440) && (DrawY < 460) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 540) && (DrawX < 640) && (DrawY >= 460) && (DrawY < 480) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b1;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 540) && (DrawX - 0 < 640) && (DrawY >= 440) && (DrawY < 460) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 240) && (DrawX < 300) && (DrawY >= 380) && (DrawY < 400) )
						begin
							is_barrier = 1'b1;
							is_brick = 1'b1;
							is_dirt = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 340) && (DrawX < 400) && (DrawY >= 320) && (DrawY < 340) )
						begin
							is_barrier = 1'b1;
							is_brick = 1'b1;
							is_dirt = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 440) && (DrawX < 500) && (DrawY >= 380) && (DrawY < 400) )
						begin
							is_barrier = 1'b1;
							is_brick = 1'b1;
							is_dirt = 1'b0;
							is_pipe = 1'b0;
						end
						else
						begin
							is_barrier = 1'b0;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
				end
				3'b011: 
				begin
					// brick platform
						if ( (DrawX >= 80) && (DrawX < 140) && (DrawY >= 360) && (DrawY < 380) )
						begin
							is_barrier = 1'b1;
							is_brick = 1'b1;
							is_dirt = 1'b0;
							is_pipe = 1'b0;
						end
					// ground tiles
						else if ( (DrawX >= 0) && (DrawX < 640) && (DrawY >= 460) && (DrawY < 480) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b1;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
						else if ( (DrawX >= 0) && (DrawX < 640) && (DrawY >= 440) && (DrawY < 460) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
							
						end
						else if ((DrawX >= 485) && (DrawX < 515) && (DrawY >= 400 ) && (DrawY < 440) )
						begin
							is_barrier = 1'b1;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b1;
						end
						else
						begin
							is_barrier = 1'b0;
							is_dirt = 1'b0;
							is_brick = 1'b0;
							is_pipe = 1'b0;
						end
				end
			default: 
				begin
					is_barrier = 1'b0;
					is_brick = 1'b0;
					is_dirt = 1'b0;
					is_pipe = 1'b0;
				end
		endcase
		
		if (is_barrier == 1'b1)
		begin
			if (is_pipe == 1'b1)
			begin
				barrier_address = (DrawX % 30 - 5) + (DrawY % 40) * 30;
			end
			else
			begin
				barrier_address = (DrawX % 20) + (DrawY % 20) * 20;
			end
		end
		else
		begin
			barrier_address = 9'b0;
		end
	end
endmodule
