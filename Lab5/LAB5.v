//Part 1

module l5_p1(D_in,clock,Q);

	input D_in,clock;
	output reg [5:0]Q;
	
	always @(clock or D_in)
	begin
		if (clock)
			begin
			Q[0] = D_in;
			Q[1] = ~D_in;
			end
	end
	
	always @(posedge clock)
	begin
		Q[2]<= D_in;
		Q[3] <= ~D_in;
	end
	
		always @(negedge clock)
	begin
		Q[4] <= D_in;
		Q[5] <= ~D_in;
	end

endmodule
//----------------------------------------------------
//Part 2

module l5_p2(SW,LEDR,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);

	input [9:0]SW;
	input [1:0]KEY;
	output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	output [9:0]LEDR;
	wire [7:0]A,B;
	wire [8:0]S;
	
	assign B = SW[7:0];
	register_8bit step_1(B,KEY[1],KEY[0],A);
	assign S = A + B;
	
	bit8_display(A,HEX2,HEX3);
	bit8_display(B,HEX0,HEX1);
	bit8_display(S,HEX4,HEX5);

	assign LEDR[9:1] = 1'b0;
	assign LEDR[0] = S[8];
	
endmodule

module bit8_display(C,Display0,Display1);

	input [7:0]C;
	output reg [6:0]Display0, Display1;

	
	always @(C)
		case((C%16))
			0: Display0 = 7'b1000000;
			1: Display0 = 7'b1111001;
			2: Display0 = 7'b0100100;
			3: Display0 = 7'b0110000;
			4: Display0 = 7'b0011001;
			5: Display0 = 7'b0010010;
			6: Display0 = 7'b0000010;
			7: Display0 = 7'b1111000;
			8: Display0 = 7'b0000000;
			9: Display0 = 7'b0010000;
			10:Display0 = 7'b0001000;
			11:Display0 = 7'b0000011;
			12:Display0 = 7'b1000110;
			13:Display0 = 7'b0100001;
			14:Display0 = 7'b0000110;
			15:Display0 = 7'b0001110;
		endcase


	always @(C)
		case((C/16))
			0: Display1 = 7'b1000000;
			1: Display1 = 7'b1111001;
			2: Display1 = 7'b0100100;
			3: Display1 = 7'b0110000;
			4: Display1 = 7'b0011001;
			5: Display1 = 7'b0010010;
			6: Display1 = 7'b0000010;
			7: Display1 = 7'b1111000;
			8: Display1 = 7'b0000000;
			9: Display1 = 7'b0010000;
			10: Display1 = 7'b0001000;
			11: Display1 = 7'b0000011;
			12: Display1 = 7'b1000110;
			13: Display1 = 7'b0100001;
			14: Display1 = 7'b0000110;
			15: Display1 = 7'b0001110;
		endcase

endmodule

module register_8bit(D,e_input,r_input,Q);

	input [7:0]D;
	input e_input,r_input;
	output reg [7:0]Q;

	always @(posedge e_input or negedge r_input)
	begin
		if(r_input == 1'b0)
			begin
			Q <= 8'b00000000;
			end
		else
			begin
			Q <= D;
			end
	end

endmodule
//----------------------------------------------------
//Part 3
// 30.0 ALMs
module l5_p3(SW,KEY,HEX0,HEX1,HEX2,HEX3);

	input [1:0]SW;
	input [0:0]KEY;
	output [6:0]HEX0,HEX1,HEX2,HEX3;
	wire [15:0]Q;
	wire [14:0]inter;
	
	T_counter_reset_ff U1(SW[1],KEY[0],SW[0],Q[0]);
	
	assign inter[0] = SW[1]&Q[0];
	
	T_counter_reset_ff U2(inter[0],KEY[0],SW[0],Q[1]);
	
	assign inter[1] = inter[0]&Q[1];
	
	T_counter_reset_ff U3(inter[1],KEY[0],SW[0],Q[2]);
	
	assign inter[2] = inter[1]&Q[2];
	
	T_counter_reset_ff U4(inter[2],KEY[0],SW[0],Q[3]);
	
	assign inter[3] = inter[2]&Q[3];
	
	T_counter_reset_ff U5(inter[3],KEY[0],SW[0],Q[4]);
	
	assign inter[4] = inter[3]&Q[4];
	
	T_counter_reset_ff U6(inter[4],KEY[0],SW[0],Q[5]);
	
	assign inter[5] = inter[4]&Q[5];
	
	T_counter_reset_ff U7(inter[5],KEY[0],SW[0],Q[6]);
	
	assign inter[6] = inter[5]&Q[6];
	
	T_counter_reset_ff U8(inter[6],KEY[0],SW[0],Q[7]);
	
	assign inter[7] = inter[6]&Q[7];
	
	T_counter_reset_ff U9(inter[7],KEY[0],SW[0],Q[8]);
	
	assign inter[8] = inter[7]&Q[8];
	
	T_counter_reset_ff U10(inter[8],KEY[0],SW[0],Q[9]);
	
	assign inter[9] = inter[8]&Q[9];
	
	T_counter_reset_ff U11(inter[9],KEY[0],SW[0],Q[10]);
	
	assign inter[10] = inter[9]&Q[10];
	
	T_counter_reset_ff U12(inter[10],KEY[0],SW[0],Q[11]);
	
	assign inter[11] = inter[10]&Q[11];
	
	T_counter_reset_ff U13(inter[11],KEY[0],SW[0],Q[12]);
	
	assign inter[12] = inter[11]&Q[12];
	
	T_counter_reset_ff U14(inter[12],KEY[0],SW[0],Q[13]);
	
	assign inter[13] = inter[12]&Q[13];
	
	T_counter_reset_ff U15(inter[13],KEY[0],SW[0],Q[14]);
	
	assign inter[14] = inter[13]&Q[14];
	
	T_counter_reset_ff U16(inter[14],KEY[0],SW[0],Q[15]);
	
	display_gen final1(Q[3:0],HEX0);
	display_gen final2(Q[7:4],HEX1);
	display_gen final3(Q[11:8],HEX2);
	display_gen final4(Q[15:12],HEX3);

endmodule

module T_counter_reset_ff(T_in,clock,r_in,Q);

	input T_in,clock,r_in;
	output reg Q;
	
	always @(posedge clock or negedge r_in)
		begin
		if (r_in == 1'b0)
			begin
			Q <= 1'b0;
			end
		else if (T_in == 1'b1)
			begin
			Q <= !Q;
			end
		end
		
endmodule


module display_gen(C,Display0);

	input [15:0]C;
	output reg [6:0]Display0;
	
	always @(C)
	begin
		case((C%16))
			0: Display0 = 7'b1000000;
			1: Display0 = 7'b1111001;
			2: Display0 = 7'b0100100;
			3: Display0 = 7'b0110000;
			4: Display0 = 7'b0011001;
			5: Display0 = 7'b0010010;
			6: Display0 = 7'b0000010;
			7: Display0 = 7'b1111000;
			8: Display0 = 7'b0000000;
			9: Display0 = 7'b0010000;
			10:Display0 = 7'b0001000;
			11:Display0 = 7'b0000011;
			12:Display0 = 7'b1000110;
			13:Display0 = 7'b0100001;
			14:Display0 = 7'b0000110;
			15:Display0 = 7'b0001110;
		endcase
	end

endmodule
//----------------------------------------------------
//Part 4
// 22.5 ALMs
module l5_p4(SW,KEY,HEX0,HEX1,HEX2,HEX3);

	input [1:0]SW;
	input [0:0]KEY;
	output [6:0]HEX0,HEX1,HEX2,HEX3;
	wire [15:0]Q;


	reg_add1 U1(SW[1],KEY[0],SW[0],Q);

	
	display_gen final1(Q[3:0],HEX0);
	display_gen final2(Q[7:4],HEX1);
	display_gen final3(Q[11:8],HEX2);
	display_gen final4(Q[15:12],HEX3);

endmodule 

module reg_add1(T_in,clock,r_in,Q);
	
	input T_in,clock,r_in;
	output reg [15:0]Q;
	
	always @(posedge clock or negedge r_in)
		begin
		if (r_in == 1'b0)
			begin
			Q <= 16'h0000;
			end
		else if (T_in == 1'b1)
			begin
			Q <= Q + 1;
			end
		end
		
endmodule

module display_gen(C,Display0);

	input [3:0]C;
	output reg [6:0]Display0;
	
	always @(C)
	begin
		case((C%16))
			0: Display0 = 7'b1000000;
			1: Display0 = 7'b1111001;
			2: Display0 = 7'b0100100;
			3: Display0 = 7'b0110000;
			4: Display0 = 7'b0011001;
			5: Display0 = 7'b0010010;
			6: Display0 = 7'b0000010;
			7: Display0 = 7'b1111000;
			8: Display0 = 7'b0000000;
			9: Display0 = 7'b0010000;
			10:Display0 = 7'b0001000;
			11:Display0 = 7'b0000011;
			12:Display0 = 7'b1000110;
			13:Display0 = 7'b0100001;
			14:Display0 = 7'b0000110;
			15:Display0 = 7'b0001110;
		endcase
	end

endmodule
//----------------------------------------------------
//Part 5
 
 module l5_p5(CLOCK_50,HEX0);
	
	input CLOCK_50;
	output [6:0]HEX0;
	reg check_s;
	reg [25:0]Q;
	reg [3:0]D;
	
	always @(posedge CLOCK_50)
	begin
		Q <= Q + 1;
		if (Q == 26'h2ffffff)
			begin
			check_s <= 1'b1;
			Q <= 26'h0000000;
			end
		else
			begin
			check_s <= 1'b0;
			end
		if (check_s == 1)
			begin
			if (D == 4'd9)
				begin
				D <= 4'b0000;
				end
			else
				begin
				D <= D + 1;
				end
			end
	end
	
	display_gen final(D,HEX0);
	
endmodule

module display_gen(C,Display0);
	
	input [3:0]C;
	output reg[6:0]Display0;
	
	always @(C)
	
		case((C%10))
		
			0: Display0 = 7'b1000000;
			1: Display0 = 7'b1111001;
			2: Display0 = 7'b0100100;
			3: Display0 = 7'b0110000;
			4: Display0 = 7'b0011001;
			5: Display0 = 7'b0010010;
			6: Display0 = 7'b0000010;
			7: Display0 = 7'b1111000;
			8: Display0 = 7'b0000000;
			9: Display0 = 7'b0010000;
			
		endcase
		
endmodule 
//----------------------------------------------------
//Part 6

module l5_p6(CLOCK_50,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);

	input CLOCK_50;
	output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	reg [2:0]cnt;
	reg [25:0]Q;

	
	always @(posedge CLOCK_50)
	begin
		Q <= Q + 1;
		if (Q == 26'h2ffffff)
			begin
			Q <= 26'h0000000;
			cnt <= cnt + 1;
			end
		if (cnt == 3'b110)
			begin 
			cnt <= 3'b000;
			end
	end
	
	disp_gen U1(cnt,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	
endmodule 

module disp_gen(C,d0,d1,d2,d3,d4,d5);
	
	input [2:0]C;
	output reg [6:0]d0,d1,d2,d3,d4,d5;
	
	always @(C)
	begin
		if (C == 0)
			begin
			d0 = 7'b1111001;
			d1 = 7'b0000110;
			d2 = 7'b0100001;
			d3 = 7'b1111111;
			d4 = 7'b1111111;
			d5 = 7'b1111111;
			end
		else if (C == 1)
			begin
			d0 = 7'b1111111;
			d1 = 7'b1111001;
			d2 = 7'b0000110;
			d3 = 7'b0100001;
			d4 = 7'b1111111;
			d5 = 7'b1111111;
			end
		else if (C == 2)
			begin
			d0 = 7'b1111111;
			d1 = 7'b1111111;
			d2 = 7'b1111001;
			d3 = 7'b0000110;
			d4 = 7'b0100001;
			d5 = 7'b1111111;
			end
		else if (C == 3)
			begin
			d0 = 7'b1111111;
			d1 = 7'b1111111;
			d2 = 7'b1111111;
			d3 = 7'b1111001;
			d4 = 7'b0000110;
			d5 = 7'b0100001;
			end
		else if (C == 4)
			begin
			d0 = 7'b0100001;
			d1 = 7'b1111111;
			d2 = 7'b1111111;
			d3 = 7'b1111111;
			d4 = 7'b1111001;
			d5 = 7'b0000110;
			end
		else if (C == 5)
			begin
			d0 = 7'b0000110;
			d1 = 7'b0100001;
			d2 = 7'b1111111;
			d3 = 7'b1111111;
			d4 = 7'b1111111;
			d5 = 7'b1111001;
			end
	end
	
endmodule
