module question_level_select (
									input is_question_room1,
											is_question_room3,
											empty_question_room1,
											empty_question_room3,
									input [8:0] question_room1_address,
													question_room3_address,
									output is_question,
											 is_question_empty,
									output [8:0] question_address
									);
		// this is the question level select module 							
	always_comb
	begin
			if (is_question_room1)  // if the question is in room 1 
			begin
				is_question = is_question_room1;
				is_question_empty = empty_question_room1;  // get the corresponding empty signal 
				question_address = question_room1_address;  // get the corresponding address
			end  
			else if (is_question_room3)  // else if it is in room 3 
			begin
				is_question = is_question_room3;
				is_question_empty = empty_question_room3;  // get the corresponding empty signals and address 
				question_address = question_room3_address;
			end
			else
			begin
				is_question = 1'b0;
				is_question_empty = 1'b0;
				question_address = 8'd0;
			end
	end
	
endmodule