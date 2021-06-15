# SystemVerilog-Super-Mario-Bros.-Clone-ECE-385

This project uses the DE10-Lite FPGA Board, USB Keyboard, and VGA display to make a version of the Super Mario retro game. 

To Get Started:

Download and import the project into Quartus Prime. Once compiled, connect the FPGA board with the USB cable and program the board with the Quartus Prime Programmer.
Connect the VGA display and USB keyboard to the DE10-Lite board. The display should show the first room in the Super Mario game.
Open Eclipse and start the USB controls via the NIOS-II console. Be sure to generate BSP and build the project before running.

KEY0 can be pressed on the FPGA Board to generate the characters, Mario and Luigi on the screen. The WASD and arrow keys can be used to control Mario and Luigi respectively.

To select a level, put 1, 2, or 3 in the switches and press KEY1 (Run) to enter the level. Once a level is completed, the characters will be sent back to the initial room.

To reset the game, press KEY0 (Reset).
