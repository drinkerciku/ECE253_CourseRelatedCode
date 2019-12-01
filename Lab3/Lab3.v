//PART 4
module part4(SW,HEX0);
	input [9:0]SW;
	output [6:0]HEX0;
	wire [1:0]c;
	assign c = SW[1:0];

	assign HEX0[0] = c[0]&c[1];
	assign HEX0[1] = c[0];
	assign HEX0[2] = ~(c[0]^c[1]);
	assign HEX0[3] = c[0]&c[1];
	assign HEX0[4] = c[0]|c[1];
	assign HEX0[5] = (~c[0])|c[1];
	assign HEX0[6] = c[0]&c[1];
endmodule

//PART 5
module part5(SW,LEDR,HEX0,HEX1,HEX2);
	input [9:0]SW;
	output [9:0]LEDR;
	output [6:0]HEX0,HEX1,HEX2;

	wire [1:0]M0,S0,U0,V0,W0;
	assign S0 = SW[9:8];
	assign U0 = SW[5:4];
	assign V0 = SW[3:2];
	assign W0 = SW[1:0];

	assign LEDR[9:8] = S;
	assign LEDR[5:0] = SW[5:0];
	assign LEDR[7:6] = 1'b0;

	mux_2bit_3to1 mod0(S0,U0,V0,W0,M0);	
	char_7seg H012(M0,HEX0,HEX1,HEX2);

endmodule

module mux_2bit_3to1(S,U,V,W,M);
	input [1:0]S,U,V,W;
	output [1:0]M;
	
	wire [1:0]I;

	assign I[0] = (~S[1]&U[0])|(S[1]&V[0]);
	assign M[0] = (~S[0]&I[0])|(S[0]&W[0]);
	
 	assign I[1] = (~S[1]&U[1])|(S[1]&V[1]);
	assign M[1] = (~S[0]&I[1])|(S[0]&W[1]);

endmodule

module char_7seg(C,Display0,Display1,Display2);
	input [1:0]C;
	output [6:0]Display0,Display1,Display2;

	//right most hex_display
	assign Display2[0] = C[0]&C[1];
	assign Display2[1] = C[0];
	assign Display2[2] = ~(C[0]^C[1]);
	assign Display2[3] = C[0]&C[1];
	assign Display2[4] = C[0]|C[1];
	assign Display2[5] = (~C[0])|C[1];
	assign Display2[6] = C[0]&C[1];

	//middle hex_display
	assign Display1[0] = C[0]&C[1];
	assign Display1[1] = (~C[0])&(~C[1]);
	assign Display1[2] = C[1];
	assign Display1[3] = C[0]&C[1];
	assign Display1[4] = C[0]|(~C[1]);
	assign Display1[5] = C[0]|C[1];
	assign Display1[6] = C[0]&C[1];

	//left most hex_display
	assign Display0[0] = C[0]&C[1];
	assign Display0[1] = C[1];
	assign Display0[2] = C[0]&(~C[1]);
	assign Display0[3] = C[0]&C[1];
	assign Display0[4] = (~C[0])|C[1];
	assign Display0[5] = C[0]|(~C[1]);
	assign Display0[6] = C[0]&C[1];

endmodule

