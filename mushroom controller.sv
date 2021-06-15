module upgrade_controller (  
					input         	Clk,
										Reset,
										frame_clk,
               input [9:0]   	DrawX, DrawY,
					input [2:0]   	level_num,
					input 		  	is_qblock_empty_room1,
										is_qblock_empty_room3,
					input [9:0]	  	mario_x, mario_y,
										luigi_x, luigi_y,
					input [9:0]	  	mario_Size_Y,
										luigi_Size_Y,
					input [1:0]	  	mario_health,
										luigi_health,
               output logic  	is_redupgrade,
										is_greenupgrade,
					output logic  	[9:0] redupgrade_x, redupgrade_y,
												greenupgrade_x, greenupgrade_y,
					output logic  	[8:0] upgrade_address 
              );
			
			//this is the upgrade controller that instantiates all of the upgrades 
	logic is_redupgrade_temp, is_greenupgrade_temp;
	logic [8:0] redupgrade_address, greenupgrade_address;
	
	// instantiate the red upgrade 
	 upgrade redupgrade (
										.Clk(MAX10_CLK1_50),
										.Reset(Reset_h),
										.frame_clk(VGA_VS),
										.DrawX(drawxsig), 
										.DrawY(drawysig),
										.level_num(level_num),
										.upgrade_level_num(3'b001),
										.is_qblock_empty(empty_qblock_room1),
										.start_x(100), 
										.start_y(342),
										.mario_x(mario_x), 
										.mario_y(mario_y),	
										.luigi_x(luigi_x), 
										.luigi_y(luigi_y),
										.mario_Size_Y(mario_Size_Y),
										.luigi_Size_Y(luigi_Size_Y),
										.mario_health(mario_health),
										.luigi_health(luigi_health),
										.is_upgrade(is_redupgrade_temp),
										.upgrade_X_Pos(redupgrade_x), 
										.upgrade_Y_Pos(redupgrade_y),
										.upgrade_address(redupgrade_address)
              );
	
 	// instantiate the green upgrade 
	 upgrade greenupgrade (
										.Clk(MAX10_CLK1_50),
										.Reset(Reset_h),
										.frame_clk(VGA_VS),
										.DrawX(drawxsig), 
										.DrawY(drawysig),
										.level_num(level_num),
										.upgrade_level_num(3'b011),
										.is_qblock_empty(empty_qblock_room3),
										.start_x(100), 
										.start_y(342),
										.mario_x(mario_x), 
										.mario_y(mario_y),	
										.luigi_x(luigi_x), 
										.luigi_y(luigi_y),
										.mario_Size_Y(mario_Size_Y),
										.luigi_Size_Y(luigi_Size_Y),
										.mario_health(mario_health),
										.luigi_health(luigi_health),
										.is_upgrade(is_greenupgrade_temp),
										.upgrade_X_Pos(greenupgrade_x), 
										.upgrade_Y_Pos(greenupgrade_y),
										.upgrade_address(greenupgrade_address)
              );
				  
	always_comb
	begin
		case(level_num)
			3'b001:
				begin
					if(is_redupgrade_temp == 1'b1)  // if we are in room 1, we need the red upgrade 
					begin
						is_redupgrade = 1'b1;
						is_greenupgrade = 1'b0;
						upgrade_address = redupgrade_address;  // set the address 
					end 
					else if (is_greenupgrade_temp == 1'b1)  // if we need a green upgraderooom 
					begin
						is_redupgrade = 1'b0;
						is_greenupgrade = 1'b1;
						upgrade_address = greenupgrade_address; // set the address 
					end
					else
					begin
						is_redupgrade = 1'b0;
						is_greenupgrade = 1'b0;
						upgrade_address = 9'b0;
					end
				end
			3'b011:  // handle everything for a upgrade in room 3 
				begin
					if(is_redupgrade_temp == 1'b1)
					begin
						is_redupgrade = 1'b1;
						is_greenupgrade = 1'b0;
						upgrade_address = redupgrade_address;
					end
					else if (is_greenupgrade_temp == 1'b1)
					begin
						is_redupgrade = 1'b0;
						is_greenupgrade = 1'b1;
						upgrade_address = greenupgrade_address;
					end
					else
					begin
						is_redupgrade = 1'b0;
						is_greenupgrade = 1'b0;
						upgrade_address = 9'b0;
					end
				end
			default:
				begin
					is_redupgrade = 1'b0;
					is_greenupgrade = 1'b0;
					upgrade_address = 9'b0;
				end
		endcase
	end
endmodule