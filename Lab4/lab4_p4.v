//Part 4

module lab4_p4(SW,LEDR,HEX0,HEX1);

	input [9:0]SW;
	output [9:0]LEDR;
	output [6:0]HEX0,HEX1;

	wire [3:0]X,Y,c_sum,disp1,new_v,new_v2,M0,M1;
	wire c_c,compare_f,t_in;
	
	assign Y = SW[3:0];
	assign X = SW[7:4];
	assign t_in = SW[8];

	ripple_carry_adder step_1(X,Y,t_in,c_sum,c_c);
	compare step_2(c_sum,compare_f);
	assign disp1 = {1'b0,1'b0,1'b0,(compare_f|c_c)};
	
	cctA step_3(c_sum,new_v);
	b4_2to1mux step_4(c_sum,new_v,compare_f,M0);
	cctB step_5(c_sum[1:0],new_v2);
	b4_2to1mux step_6(M0,new_v2,c_c,M1);

	disp_gen final_1(M1,HEX0);
	disp_gen final_2(disp1,HEX1);	
	
	assign LEDR[3:0] = c_sum;
	assign LEDR[4] = c_c;

endmodule

module ripple_carry_adder(A,B,toggle,out_sum,out_carry);

	input [3:0]A,B;
	input toggle;
	output out_carry;
	output [3:0]out_sum;
	wire [3:0]s_0;
	wire [4:0]C;

	assign C[0] = toggle;
	
	fulladder_unit fa1(A[0],B[0],C[0],s_0[0],C[1]);
	fulladder_unit fa2(A[1],B[1],C[1],s_0[1],C[2]);
	fulladder_unit fa3(A[2],B[2],C[2],s_0[2],C[3]);
	fulladder_unit fa4(A[3],B[3],C[3],s_0[3],C[4]);
	
	assign out_sum = s_0;
	assign out_carry = C[4];

endmodule

module fulladder_unit(in_1,in_2,c_in,s0,c_out);

	input in_1, in_2, c_in;
	output s0, c_out;

	assign s0 = in_1^in_2^c_in ;
	assign c_out = (in_1&in_2)|(in_1&c_in)|(in_2&c_in);
	
endmodule

module compare(V_arg,Z);

	input [3:0]V_arg;
	output Z;

	assign Z = V_arg[3]&(V_arg[2]|V_arg[1]);

endmodule

module b4_2to1mux(in_0,in_1,S,out_0);

	input [3:0]in_0, in_1;
	input S;
	output [3:0]out_0;

	assign out_0[0] = ((~S)&in_0[0])|(S&in_1[0]);
	assign out_0[1] = ((~S)&in_0[1])|(S&in_1[1]);
	assign out_0[2] = ((~S)&in_0[2])|(S&in_1[2]);
	assign out_0[3] = ((~S)&in_0[3])|(S&in_1[3]);

endmodule

module cctA(large_in,out_1);

	input [3:0]large_in;
	output [3:0]out_1;
	
	assign out_1[0] = large_in[0];
	assign out_1[1] = ~large_in[1];
	assign out_1[2] = large_in[2]&large_in[1];
	assign out_1[3] = ~large_in[3];

endmodule

module cctB(small_in,out_2);

	input [1:0]small_in;
	output [3:0]out_2;

	assign out_2[0] = small_in[0];
	assign out_2[1] = ~small_in[1];
	assign out_2[2] = ~small_in[1];
	assign out_2[3] = small_in[1];

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
