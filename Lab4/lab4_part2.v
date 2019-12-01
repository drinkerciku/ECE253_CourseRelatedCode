//Part2

module l4_p2(SW,LEDR,HEX0,HEX1);

	input [9:0]SW;
	output [9:0]LEDR;
	output [6:0]HEX0, HEX1;
	wire [3:0]V0,V1,V2,V3;
	wire Z0;

	assign V0 = SW[3:0];
	assign LEDR[3:0] = V0;
	assign LEDR[9:4] = 1'b0;

	compare step1(V0,Z0);
	cctA step2(V0,V1);
	b4_2to1mux step3(V0,V1,Z0,V2);
	assign V3 = {1'b0,1'b0,1'b0,Z0};

	disp_gen final_0(V2,HEX0);	
	disp_gen final_1(V3,HEX1);
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
