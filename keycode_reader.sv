
module keycode_reader(
							input [47:0] keycode,
							output logic w_key, a_key, d_key, arrow_up, arrow_left, arrow_right 
							);
	assign w_key = (keycode[47:40] == 8'h1A || keycode[39:32] == 8'h1A || keycode[31:24] == 8'h1A || keycode[23:16] == 8'h1A || keycode[15:7] == 8'h1A || keycode[7:0] == 8'h1A);
	assign a_key = (keycode[47:40] == 8'h04 || keycode[39:32] == 8'h04 || keycode[31:24] == 8'h04 || keycode[23:16] == 8'h04 || keycode[15:7] == 8'h04 || keycode[7:0] == 8'h04);
	assign d_key = (keycode[47:40] == 8'h07 || keycode[39:32] == 8'h07 || keycode[31:24] == 8'h07 || keycode[23:16] == 8'h07 || keycode[15:7] == 8'h07 || keycode[7:0] == 8'h07);
	assign arrow_up = (keycode[47:40] == 8'h52 || keycode[39:32] == 8'h52 || keycode[31:24] == 8'h52 || keycode[23:16] == 8'h52 || keycode[15:7] == 8'h52 || keycode[7:0] == 8'h52);
	assign arrow_left = (keycode[47:40] == 8'h50 || keycode[39:32] == 8'h50 || keycode[31:24] == 8'h50 || keycode[23:16] == 8'h50|| keycode[15:7] == 8'h50 || keycode[7:0] == 8'h50);
	assign arrow_right = (keycode[47:40] == 8'h4f || keycode[39:32] == 8'h4f || keycode[31:24] == 8'h4f || keycode[23:16] == 8'h4f || keycode[15:7] == 8'h4f || keycode[7:0] == 8'h4f);
endmodule