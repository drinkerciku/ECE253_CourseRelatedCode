Part 5

module l4_p5(SW,HEX0,HEX1,HEX4,HEX5);

	input [9:0]SW;
	output [6:0]HEX0,HEX1,HEX4,HEX5;
	wire [3:0]A,B;
	wire c_in;
	reg [4:0]T0,Z0,c1,S1,S0;

	assign A = SW[7:4];
	assign B = SW[3:0];
	assign c_in = SW[9];
	
	always @(A,B,c_in)
	begin
		T0 = A + B + c_in;
		if (T0 > 5'd9)
			begin
			Z0 = 5'hA;
			c1 = 5'h1;
			end
		else
			begin
			Z0 = 5'h0;
			c1 = 5'h0;
			end
		S0 = T0 - Z0;
		S1 = c1;
	end
	
	disp_gen h0(S0,HEX0);		
	disp_gen h1(S1,HEX1);
	disp_gen h2(A,HEX5);
	disp_gen h3(B,HEX4);	
		
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
