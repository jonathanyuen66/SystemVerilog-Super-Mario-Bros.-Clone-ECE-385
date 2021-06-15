module LevelTransition (
								input [2:0] mario_level_num,
												luigi_level_num,
								input [1:0] mario_life_counter,
												luigi_life_counter,
								output [2:0]level_num
								);
					
logic M1, M0, L1, L0, R1, R0;  // these will be both the 1th bit and the 0th bit for mario's level num, 
											// luigi's level num, and the output level num
logic [2:0] M1_temp, L1_temp;

assign M1_temp = mario_level_num & 3'b010;  // use a bit mask to get the 1th bit of mario's level num
assign M1 = M1_temp >> 1;                   // bit shift right so that we can assign it to a one-bit M1
assign M0 = mario_level_num & 3'b001;      // use a bit mask to get the 0th bit of mario's level num
assign L1_temp = luigi_level_num & 3'b010;  // do the same thing for luigi's level num
assign L1 = L1_temp >> 1;
assign L0 = luigi_level_num & 3'b001;

assign R1 = M1 | L1;                // made a k-map for R1 and R0 to decide how to logically express 
assign R0 = M0 | L0;                // the output level number in terms of mario and luigi's level num
always_comb
begin
	if(mario_life_counter > 0 && luigi_life_counter > 0)  // if both of the characters are alive
	begin
		 level_num = {R1, R0};   // then use the value calculated using both of their level numbers
	end
	else if (mario_life_counter == 0 && luigi_life_counter > 0)  // if mario is dead, we don't care what room he is in
	begin
		level_num = luigi_level_num;   // luigi will just progress as normal
	end
	else if (luigi_life_counter == 0 && mario_life_counter > 0)   // same for if luigi is dead
	begin
		level_num = mario_level_num;
	end
	else
	begin
		level_num = 0;  // if both are dead, just go to the loading room
	end
end								
					
endmodule