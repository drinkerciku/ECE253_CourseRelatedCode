module l4_p1(SW,HEX0,HEX1);
	
	input [9:0]SW;
	output [6:0]HEX0, HEX1;
	
	wire [3:0]h0, h1;
	reg [3:0]out_0,out_1;
	
	assign h0 = SW[3:0];
	assign h1 = SW[7:4];

	disp_gen n0(h0,HEX0);
	disp_gen n1(h1,HEX1);

endmodule 

module disp_gen(C,Display);

	input [3:0]C;
	output [6:0]Display;
	
	assign Display[0] = (~C[3])&(~C[1])&((C[2]&(~C[0]))|(C[0]&(~C[2])));
	assign Display[1] = ((~C[3])&C[2]&(~C[1])&C[0])|((~C[3])&C[2]&C[1]&(~C[0]));
	assign Display[2] = (~C[3])&(~C[2])&C[1]&(~C[0]);
	assign Display[3] = ((~C[3])&C[2]&(~C[1])&(~C[0]))|((~C[3])&C[2]&C[1]&C[0])|((~C[3])&(~C[2])&(~C[1])&C[0]);
	assign Display[4] = ((~C[3])&C[0])|((~C[3])&C[2]&(~C[1])&(~C[0]))|(C[3]&(~C[2])&(~C[1])&C[0]);
	assign Display[5] = (~C[3])&(~C[2])&(C[1]|C[0])|((~C[3])&C[1]&C[0]);
	assign Display[6] = (~C[3])&(~C[2])&(~C[1])|(~C[3])&C[2]&C[1]&C[0];
	
endmodule 
