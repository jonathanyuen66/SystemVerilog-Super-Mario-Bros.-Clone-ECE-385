
module  mario_sprite_still
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_still_right.txt", ram);
end

endmodule



module  mario_sprite_death
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_dead.txt", ram);
end

endmodule



module  mario_sprite_walk1
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_walk_right_1.txt", ram);
end

endmodule



module  mario_sprite_walk2
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_walk_right_2.txt", ram);
end

endmodule



module  mario_sprite_walk3
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_walk_right_3.txt", ram);
end

endmodule



module  mario_sprite_jump
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_jump_right.txt", ram);
end

endmodule



module  big_mario_sprite_walk1
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_big_walk_right_1.txt", ram);
end

endmodule



module  big_mario_sprite_walk2
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_big_walk_right_2.txt", ram);
end

endmodule



module  big_mario_sprite_walk3
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_big_walk_right_3.txt", ram);
end

endmodule



module  big_mario_sprite_still
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_big_still_right.txt", ram);
end

endmodule



module  big_mario_sprite_jump
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hF83800;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_big_jump_right.txt", ram);
end

endmodule



module  luigi_sprite_still
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/luigi_still.txt", ram);
end

endmodule



module  luigi_sprite_death
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/luigi_death.txt", ram);
end

endmodule



module  luigi_sprite_walk1
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/luigi_walk1.txt", ram);
end

endmodule



module  luigi_sprite_walk2
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/luigi_walk2.txt", ram);
end

endmodule



module  luigi_sprite_walk3
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/luigi_walk3.txt", ram);
end

endmodule



module  luigi_sprite_jump
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:511];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/luigi_jump.txt", ram);
end

endmodule



module  big_luigi_sprite_still
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/big_luigi_still.txt", ram);
end

endmodule



module  big_luigi_sprite_jump
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/big_luigi_jump.txt", ram);
end

endmodule



module  big_luigi_sprite_walk1
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/big_luigi_walk1.txt", ram);
end

endmodule



module  big_luigi_sprite_walk2
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/big_luigi_walk2.txt", ram);
end

endmodule



module  big_luigi_sprite_walk3
(
		input [9:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1023];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h00FF00;
assign palette[2] = 24'hEA9A30;
assign palette[3] = 24'hEF9D34;
assign palette[4] = 24'h227DBB;
assign palette[5] = 24'hFFA440;
assign palette[6] = 24'hAC7C00;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/big_luigi_walk3.txt", ram);
end

endmodule



module  logo_sprite
(
		input [17:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:115200];

logic [23:0] palette [5:0];
assign palette[0] = 24'h00ffcc;
assign palette[1] = 24'h000000;
assign palette[2] = 24'h009BD9;
assign palette[3] = 24'hE62310;
assign palette[4] = 24'hFCCF00;
assign palette[5] = 24'h44AF35;


assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_logo.txt", ram);
end

endmodule



module  enemy_sprite_walk1
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:440];

logic [23:0] palette [4:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h202020;
assign palette[2] = 24'hE45810;
assign palette[3] = 24'hF4D4B4;
assign palette[4] = 24'h000000;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/enemy_walk_1.txt", ram);
end

endmodule



module  enemy_sprite_walk2
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:440];

logic [23:0] palette [4:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h202020;
assign palette[2] = 24'hE45810;
assign palette[3] = 24'hF4D4B4;
assign palette[4] = 24'h000000;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/enemy_walk_2.txt", ram);
end

endmodule



module  enemy_sprite_squished
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:440];

logic [23:0] palette [4:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'hE45810;
assign palette[2] = 24'hF4D4B4;
assign palette[3] = 24'h000000;
assign palette[4] = 24'h202020;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/enemy_squished.txt", ram);
end

endmodule

module  red_upgrade_sprite
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:324];

logic [23:0] palette [4:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h000000;
assign palette[2] = 24'hFEFEFE;
assign palette[3] = 24'hE43834;
assign palette[4] = 24'hFEEBB1;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_red_upgrade.txt", ram);
end

endmodule



module  green_upgrade_sprite
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:324];

logic [23:0] palette [4:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h000000;
assign palette[2] = 24'hFEFEFE;
assign palette[3] = 24'h2CC010;
assign palette[4] = 24'hFEEBB1;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_green_upgrade.txt", ram);
end

endmodule



module  piranha_sprite
(
		input [10:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:630];

logic [23:0] palette [5:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h000000;
assign palette[2] = 24'hFEFEFE;
assign palette[3] = 24'hE43834;
assign palette[4] = 24'h66E64E;
assign palette[5] = 24'h16C910;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_piranha1.txt", ram);
end

endmodule


module  mario_pipe_sprite
(
		input [10:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:1200];

logic [23:0] palette [5:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h000000;
assign palette[2] = 24'h4AE22D;
assign palette[3] = 24'hBEFBAE;
assign palette[4] = 24'h66E64E;
assign palette[5] = 24'h16C910;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_pipe.txt", ram);
end

endmodule


module  mario_brick_sprite
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:399];

logic [23:0] palette [6:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h000000;
assign palette[2] = 24'h6E2601;
assign palette[3] = 24'hB24204;
assign palette[4] = 24'hE85C0C;
assign palette[5] = 24'hFF6F0B;
assign palette[6] = 24'hFFE7C8;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/tile_brick.txt", ram);
end

endmodule



//module  mario_ground_sprite
//(
//		input [8:0] read_address,
//		output logic [23:0] pixel_color
//);
//
//// ram has width of 3 bits and a total of 400 addresses
//logic [3:0] ram [0:399];
//
//logic [23:0] palette [8:0];
//assign palette[0] = 24'h00FFCC;
//assign palette[1] = 24'h888173;
//assign palette[2] = 24'h0A0000;
//assign palette[3] = 24'hFFFFEF;
//assign palette[4] = 24'hFFC89C;
//assign palette[5] = 24'hE6570C;
//assign palette[6] = 24'hAB3A00;
//assign palette[7] = 24'h756C5F;
//assign palette[8] = 24'hE33F00;
//
//assign pixel_color = palette[ram[read_address]];
//
//initial
//begin
//	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/tile_ground.txt", ram);
//end
//
//endmodule


module  question_sprite
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:399];

logic [23:0] palette [4:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h000000;
assign palette[2] = 24'hE75A10;
assign palette[3] = 24'hFFA542;
assign palette[4] = 24'h8C1000;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/question_blink_1.txt", ram);
end

endmodule



module  question_empty_sprite
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:399];

logic [23:0] palette [4:0];
assign palette[0] = 24'h00FFCC;
assign palette[1] = 24'h000000;
assign palette[2] = 24'hE75A10;
assign palette[3] = 24'hFFA542;
assign palette[4] = 24'h8C1000;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/question_empty.txt", ram);
end

endmodule



module  mario_grass_sprite
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:440];

logic [23:0] palette [3:0];
assign palette[0] = 24'h3EB70B;
assign palette[1] = 24'h50a92b;
assign palette[2] = 24'h964b00;
assign palette[3] = 24'hc26406;


assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_grass.txt", ram);
end

endmodule

module  mario_dirt_sprite
(
		input [8:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:440];

logic [23:0] palette [1:0];
assign palette[0] = 24'h964b00;
assign palette[1] = 24'hc26406;

assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_dirt.txt", ram);
end

endmodule

module  game_over_sprite
(
		input [17:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:307199];

logic [23:0] palette [1:0];
assign palette[0] = 24'h000000;
assign palette[1] = 24'hffffff;


assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/game_over.txt", ram);
end

endmodule




module  background_sprite
(
		input [17:0] read_address,
		output logic [23:0] pixel_color
);

// ram has width of 3 bits and a total of 400 addresses
logic [3:0] ram [0:307199];

logic [23:0] palette [2:0];
assign palette[0] = 24'h00B0FF;
assign palette[1] = 24'h95D2F0;
assign palette[2] = 24'hFEFEFE;


assign pixel_color = palette[ram[read_address]];

initial
begin
	 $readmemh("C:/intelFPGA_lite/18.1/finalproject/ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/mario_background.txt", ram);
end

endmodule