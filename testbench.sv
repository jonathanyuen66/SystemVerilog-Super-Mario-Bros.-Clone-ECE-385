
module testbench();

timeunit 10ns;

timeprecision 1ns;

logic [2:0] mario_level_num, luigi_level_num, level_num;

LevelTransition lt0(.*);


always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
Clk = 0;
end 

initial begin: TEST_VECTORS
mario_level_num = 3'b011;
luigi_level_num = 3'b011;

end
endmodule

