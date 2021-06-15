module finalproject (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);
	 
	logic Reset_h, blank, sync, VGA_Clk, ischaracter1, ischaracter2, isbarrier, isBrick, is_mario_on_ground, is_luigi_on_ground, is_mario_walking, is_luigi_walking, is_enemy, isPipe, is_question_room1, is_question_room3, empty_question_room1, empty_question_room3, is_question, is_question_empty, is_redupgrade, is_greenupgrade;
	logic is_game_over, is_logo;
	logic w_key, a_key, d_key, up_arrow, left_arrow, right_arrow;
	logic [1:0] mario_health, luigi_health, enemy_health, piranha_health;
	logic [1:0] mario_walk_count, luigi_walk_count;
	logic enemy_walk_count;
	logic [2:0] Level_Mux_Out;
	logic [2:0] level_num, mario_level_num, luigi_level_num;
	logic mario_transition, luigi_transition;

//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);
	assign {Run_h}=~ (KEY[1]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
//======================================================================================================================

	 // these are the coordinates of characters so that we know when we run into them
	logic [9:0] mario_x, mario_y, mario_Size_Y;
	logic [9:0] luigi_x, luigi_y, luigi_Size_Y;
	logic [9:0] enemy_x, enemy_y, piranha_x, piranha_y, redupgrade_x, redupgrade_y, greenupgrade_x, greenupgrade_y;
	
	// life counters for mario and luigi - they each start out with two lives and die at zero
	logic [1:0] mario_life_counter1, luigi_life_counter1;

	// these are for the color_mapper - so that we can map out the element's pixels onto the screen
	logic [9:0] mario_address;
	logic [9:0] luigi_address;
	logic [8:0] enemy_address;
	logic [10:0] piranha_address;
	logic [19:0] game_over_address;
	logic [17:0] logo_address;
	logic [10:0] barrier_address;
	logic [8:0] upgrade_address;
	logic [8:0] question_room1_address;
	logic [8:0] question_room3_address;
	logic [8:0] question_address;
	
	lab62soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		
	 );
	 
	 //instantiate vga_controller module
    vga_controller vga_cntrl ( .Clk(MAX10_CLK1_50),
									.Reset(Reset_h),
									.hs(VGA_HS),
									.vs(VGA_VS),
									.pixel_clk(VGA_Clk),
									.blank(blank),
									.sync(sync),
									.DrawX(drawxsig),
									.DrawY(drawysig)
									);
	
	 //instantiate level selection module
	 Level_Mux Level_Mux0(.Sel(SW),
								 .Level_Mux_Out
								);	
    
	 //instantiate mario module
    character2 mario(
							 .Clk(MAX10_CLK1_50),
							 .Reset(Reset_h),
							 .Run(Run_h),
							 .frame_clk(VGA_VS),
							 .level_sel(Level_Mux_Out),
							 .DrawX(drawxsig),
							 .DrawY(drawysig),
							 .w_press(w_key),
							 .a_press(a_key),
							 .d_press(d_key),
							 .enemy_x,
							 .enemy_y,
							 .piranha_x,
							 .piranha_y,
							 .redupgrade_x,
							 .redupgrade_y,
							 .greenupgrade_x,
							 .greenupgrade_y,
							 .othercharacter_transitioning(luigi_transition),
							 .othercharacter_health(luigi_life_counter1),
							 .character_X_Pos(mario_x),
							 .character_Y_Pos(mario_y),
							 .character_Size_Y(mario_Size_Y),
							 .is_character(ischaracter1),
							 .character_address(mario_address),
							 .on_ground(is_mario_on_ground),
							 .is_walking(is_mario_walking),
							 .walk_count(mario_walk_count),
							 .character_health(mario_health),
							 .level_num(mario_level_num),
							 .life_counter(mario_life_counter1),
							 .transitioning(mario_transition)
							 );
	
	// instantiate luigi module
	character2 luigi(
							 .Clk(MAX10_CLK1_50),
							 .Reset(Reset_h),
							 .Run(Run_h),
							 .frame_clk(VGA_VS),
							 .level_sel(Level_Mux_Out),
							 .DrawX(drawxsig),
							 .DrawY(drawysig),
							 .w_press(arrow_up),
							 .a_press(arrow_left),
							 .d_press(arrow_right),
							 .enemy_x,
							 .enemy_y,
							 .piranha_x,
							 .piranha_y,
							 .redupgrade_x,
							 .redupgrade_y,
							 .greenupgrade_x,
							 .greenupgrade_y,
							 .othercharacter_transitioning(mario_transition),
							 .othercharacter_health(mario_life_counter1),
							 .character_X_Pos(luigi_x),
							 .character_Y_Pos(luigi_y),
							 .character_Size_Y(luigi_Size_Y),
							 .is_character(ischaracter2),
							 .character_address(luigi_address),
							 .on_ground(is_luigi_on_ground),
							 .is_walking(is_luigi_walking),
							 .walk_count(luigi_walk_count),
							 .character_health(luigi_health),
							 .level_num(luigi_level_num),
							 .life_counter(luigi_life_counter1),
							 .transitioning(luigi_transition)
							 );
	 
	//instantiate keycode reader module 
	 keycode_reader keycode_reader0(
							.keycode(keycode),
							.w_key,
							.a_key, 
							.d_key,
							.arrow_up,
							.arrow_left, 
							.arrow_right 	
							);
		    // instantiate the game over screen module		
	 game_over_screen game_over0(
										 .DrawX(drawxsig),
										 .DrawY(drawysig),
										 .mario_life_counter(mario_life_counter1),
										 .luigi_life_counter(luigi_life_counter1),
										 .is_game_over,
										 .game_over_address
										 );

	 // instantiate the super mario logo module
    logo logo0(
					.DrawX(drawxsig), 
					.DrawY(drawysig),
					.level_num,
					.is_logo,
					.logo_address
				);
							
	 //instantiate enemy controller module
	 enemy_controller gc(
								.Clk(MAX10_CLK1_50),
								.Reset(Reset_h),
								.frame_clk(VGA_VS),
								.level_num(level_num),
								.DrawX(drawxsig),
								.DrawY(drawysig),
								.mario_x(mario_x),
								.mario_y(mario_y),
								.luigi_x(luigi_x),
								.luigi_y(luigi_y),
								.mario_Size_Y(mario_Size_Y),
								.luigi_Size_Y(luigi_Size_Y),
								.mario_health(mario_health),
								.luigi_health(luigi_health),
								.is_enemy(is_enemy),
								.enemy_walk_count(enemy_walk_count),
								.enemy_health(enemy_health),
								.enemy_address,
								.enemy_x(enemy_x),
								.enemy_y(enemy_y)
								);
								
	// this is our piranha plant controller module right here
	i_am_going_insane insane0(
									.Clk(MAX10_CLK1_50),
									.Reset(Reset_h),
									.frame_clk(VGA_VS),
									.level_num(level_num),
									.DrawX(drawxsig), 
									.DrawY(drawysig),
									.is_piranha(is_piranha),
									.piranha_health(piranha_health),
									.piranha_address(piranha_address),
									.piranha_x(piranha_x),
									.piranha_y(piranha_y)
							);
							
	 // instantiate upgrade_controller module
	 upgrade_controller upgrade_controller0 (
										.Clk(MAX10_CLK1_50),
										.Reset(Reset_h),
										.frame_clk(VGA_VS),
										.DrawX(drawxsig), 
										.DrawY(drawysig),
										.level_num(level_num),
										.is_question_empty_room1(empty_question_room1),
										.is_question_empty_room3(empty_question_room3),
										.mario_x(mario_x), 
										.mario_y(mario_y),	
										.luigi_x(luigi_x), 
										.luigi_y(luigi_y),
										.mario_Size_Y(mario_Size_Y),
										.luigi_Size_Y(luigi_Size_Y),
										.mario_health(mario_health),
										.luigi_health(luigi_health),
										.is_redupgrade(is_redupgrade),
										.is_greenupgrade(is_greenupgrade),
										.redupgrade_x(redupgrade_x), 
										.redupgrade_y(redupgrade_y),
										.greenupgrade_x(greenupgrade_x),
										.greenupgrade_y(greenupgrade_y),
										.upgrade_address(upgrade_address)
              );
	
	 // instantiate question for room1
	 question question_room1(
									.Clk(MAX10_CLK1_50),
									.Reset(Reset_h),
									.frame_clk(VGA_VS),
									.DrawX(drawxsig), 
									.DrawY(drawysig),
									.level_num(level_num),
									.question_level_num(3'b001),
									.block_x(100), 
									.block_y(360),
									.mario_x(mario_x), 
									.mario_y(mario_y),	
									.luigi_x(luigi_x), 
									.luigi_y(luigi_y),
									.mario_Size_Y(mario_Size_Y),
									.luigi_Size_Y(luigi_Size_Y),
									.mario_health(mario_health),
									.luigi_health(luigi_health),
									.is_question(is_question_room1),
									.is_question_empty(empty_question_room1),
									.question_address(question_room1_address)
								);

	 // instantiate question for room 3
	 question question_room3(
									.Clk(MAX10_CLK1_50),
									.Reset(Reset_h),
									.frame_clk(VGA_VS),
									.DrawX(drawxsig), 
									.DrawY(drawysig),
									.level_num(level_num),
									.question_level_num(3'b011),
									.block_x(100), 
									.block_y(360),
									.mario_x(mario_x), 
									.mario_y(mario_y),	
									.luigi_x(luigi_x), 
									.luigi_y(luigi_y),
									.mario_Size_Y(mario_Size_Y),
									.luigi_Size_Y(luigi_Size_Y),
									.mario_health(mario_health),
									.luigi_health(luigi_health),
									.is_question(is_question_room3),
									.is_question_empty(empty_question_room3),
									.question_address(question_room3_address)
								);
	 
	 // instantiate the question level select module							
	 question_level_select question_level_select0 (
															.is_question_room1,
															.is_question_room3,
															.empty_question_room1,
															.empty_question_room3,
															.question_room1_address,
															.question_room3_address,
															.is_question,
															.is_question_empty,
															.question_address
															);
				  
	 // instantiate the rooms module		  
	 rooms rooms0(
								.DrawX(drawxsig),
								.DrawY(drawysig),
								.level_num(level_num),
								.is_barrier(isbarrier),
								.is_brick(isBrick),
								.is_dirt(isDirt),
								.is_pipe(isPipe),
								.barrier_address
							 );
							 
	 // instantiate the level transition module
	 LevelTransition LevelTransition0(
												.mario_level_num,
												.luigi_level_num,
												.mario_life_counter(mario_life_counter1),
												.luigi_life_counter(luigi_life_counter1),
												.level_num
								);
		

				
	 // instantiate the color mapper module
    color_mapper color_instance(
										 .mario_health(mario_health),
										 .luigi_health(luigi_health),
										 .enemy_health(enemy_health),
										 .piranha_health(piranha_health),
										 .is_character1(ischaracter1),
										 .is_character2(ischaracter2),
										 .is_barrier(isbarrier),
										 .is_brick(isBrick),
										 .is_dirt(isDirt),
										 .is_pipe(isPipe),
										 .is_enemy(is_enemy),
										 .is_piranha(is_piranha),
										 .is_redupgrade(is_redupgrade),
										 .is_greenupgrade(is_greenupgrade),
										 .is_question(is_question),
										 .is_question_empty(is_question_empty),
										 .is_mario_on_ground(is_mario_on_ground),
										 .is_luigi_on_ground(is_luigi_on_ground),
										 .is_mario_walking(is_mario_walking),
										 .is_luigi_walking(is_luigi_walking),
										 .is_game_over(is_game_over),
										 .is_logo(is_logo),
										 .mario_walk_count(mario_walk_count),
										 .luigi_walk_count(luigi_walk_count),
										 .enemy_walk_count(enemy_walk_count),
										 .mario_address,
										 .luigi_address,
										 .enemy_address,
										 .piranha_address,
										 .upgrade_address,
										 .question_address,
										 .barrier_address,
										 .game_over_address,
										 .logo_address,
										 .DrawX(drawxsig),
										 .DrawY(drawysig),
										 .Red(Red),
										 .Green(Green),
										 .Blue(Blue)
										 );

		
		
HexDriver HexDriver0 ({2'b00, mario_life_counter1}, HEX0);

HexDriver HexDriver1 ({2'b00, luigi_life_counter1}, HEX1);

HexDriver HexDriver2 ({1'b0, mario_level_num}, HEX3);

HexDriver HexDriver3 ({1'b0, luigi_level_num}, HEX4);

HexDriver HexDriver4 ({1'b0, level_num}, HEX5);

HexDriver HexDriver5 (is_game_over, HEX2);

endmodule
