module logo (
					input [9:0]   DrawX, DrawY,  
					input [2:0]   level_num,		
					output  is_logo,		
					output [17:0] logo_address 
				);
	always_comb
	begin
		case (level_num)
		// if we are in the loading room, we want to get the logo out 
			2'd0: 
				begin
					if ( (DrawX >= 80) && (DrawX < 560) && (DrawY >= 60) && (DrawY < 300) )
						is_logo = 1'b1; // it is a logo if we are in this region 
					else
						is_logo = 1'b0;  // otherwise it is the background 
				end
			default:
				is_logo = 1'b0;  
		endcase
		
		if (is_logo == 1'b1)
			logo_address = (DrawX - 80) + (DrawY - 60) * 480;  // if it is a logo, center it down to that spot on teh screen
		else   // set the logo_address 
			logo_address = 18'd0; 
	end
			
endmodule
