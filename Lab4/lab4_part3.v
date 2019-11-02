Part 3

module ripple_carry_adder(SW,LEDR);

	input [9:0]SW;
	output [9:0]LEDR;
	wire [3:0]A,B,S;
	wire [4:0]C;
	
	assign A = SW[3:0];
	assign B = SW[7:4];
	assign LEDR[9:5] = 1'b0;
	assign C[0] = SW[8];
	

	fulladder_unit fa1(A[0],B[0],C[0],S[0],C[1]);
	fulladder_unit fa2(A[1],B[1],C[1],S[1],C[2]);
	fulladder_unit fa3(A[2],B[2],C[2],S[2],C[3]);
	fulladder_unit fa4(A[3],B[3],C[3],S[3],C[4]);
	
	assign LEDR[3:0] = S;
	assign LEDR[4] = C[4];

endmodule

module fulladder_unit(in_1,in_2,c_in,s0,c_out);

	input in_1, in_2, c_in;
	output s0, c_out;

	assign s0 = in_1^in_2^c_in ;
	assign c_out = (in_1&in_2)|(in_1&c_in)|(in_2&c_in);
	
endmodule
