//Part 1a
module lab6_p1(SW,LEDR,KEY);
	
	input [1:0]SW;
	input [0:0]KEY;
	output [9:0]LEDR;
	wire w, R, CLCK;
	wire [8:0]y, Y;
	
	assign R = SW[0];
	assign w = SW[1];
	assign CLCK = KEY[0];
	
	assign Y[0] = ~R;
	assign Y[1] = (~w)&(y[0]|y[5]|y[6]|y[7]|y[8]);
	assign Y[2] = (~w)&y[1];
	assign Y[3] = (~w)&y[2];
	assign Y[4] = (~w)&(y[3]|y[4]);
	assign Y[5] = w&(y[0]|y[1]|y[2]|y[3]|y[4]);
	assign Y[6] = w&y[5];
	assign Y[7] = w&y[6];
	assign Y[8] = w&(y[7]|y[8]);
	
	ff_reg U0(Y[0],CLCK,R,1'b1,y[0]);
	ff_reg U1(Y[1],CLCK,R,1'b0,y[1]);
	ff_reg U2(Y[2],CLCK,R,1'b0,y[2]);
	ff_reg U3(Y[3],CLCK,R,1'b0,y[3]);
	ff_reg U4(Y[4],CLCK,R,1'b0,y[4]);
	ff_reg U5(Y[5],CLCK,R,1'b0,y[5]);
	ff_reg U6(Y[6],CLCK,R,1'b0,y[6]);
	ff_reg U7(Y[7],CLCK,R,1'b0,y[7]);
	ff_reg U8(Y[8],CLCK,R,1'b0,y[8]);
	
	assign LEDR[9] = y[4]|y[8];
	
	assign LEDR[8:0] = y;
	
	
endmodule 

module ff_reg(D,clock,resetn,temp,Q);
	
	input D,clock,resetn,temp;
	output reg Q;
	
	always @ (posedge clock)
	begin
		if (resetn == 0)
			begin
			Q <= temp;
			end
		else 
			begin
			Q <= D;
			end
	end
	
endmodule 

//----------------------------------------------
//Part 1b

module l6p1(SW,LEDR,KEY);
	
	input [1:0]SW;
	input [0:0]KEY;
	output [9:0]LEDR;
	wire w, R, CLCK;
	wire [8:0]y, Y;
	
	assign R = SW[0];
	assign w = SW[1];
	assign CLCK = KEY[0];
	
	assign Y[0] = R; <--- (~R)
	assign Y[1] = ~w&((~y[0])|y[5]|y[6]|y[7]|y[8]); <---- (y[0])
	assign Y[2] = (~w)&y[1];
	assign Y[3] = (~w)&y[2];
	assign Y[4] = (~w)&(y[3]|y[4]);
	assign Y[5] = w&(y[1]|y[2]|y[3]|y[4]); <---- (add y[0])
	assign Y[6] = w&y[5];
	assign Y[7] = w&y[6];
	assign Y[8] = w&(y[7]|y[8]);
	
	ff_reg U0(Y[0],CLCK,R,1'b0,y[0]); <--- (1'b1)
	ff_reg U1(Y[1],CLCK,R,1'b0,y[1]);
	ff_reg U2(Y[2],CLCK,R,1'b0,y[2]);
	ff_reg U3(Y[3],CLCK,R,1'b0,y[3]);
	ff_reg U4(Y[4],CLCK,R,1'b0,y[4]);
	ff_reg U5(Y[5],CLCK,R,1'b0,y[5]);
	ff_reg U6(Y[6],CLCK,R,1'b0,y[6]);
	ff_reg U7(Y[7],CLCK,R,1'b0,y[7]);
	ff_reg U8(Y[8],CLCK,R,1'b0,y[8]);
	
	assign LEDR[9] = y[4]|y[8];
	
	assign LEDR[8:0] = y;
	
	
endmodule 

module ff_reg(D,clock,resetn,temp,Q);
	
	input D,clock,resetn,temp;
	output reg Q;
	
	always @ (posedge clock)
	begin
		if (resetn == 0)
			begin
			Q <= temp;
			end
		else 
			begin
			Q <= D;
			end
	end
	
endmodule 

//----------------------------------------------
//Part 2
module lab6_p2(SW,KEY,LEDR);
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
  
	reg [3:0] y_Q, Y_D; 
	wire z,w,clock;
  //reg [3:0] y_qq;// y_Q represents current state, Y_D represents next state
	parameter A = 4'b0000;
	parameter B = 4'b0001;
	parameter C = 4'b0010;
	parameter D = 4'b0011;
	parameter E = 4'b0100;
	parameter F = 4'b0101;
	parameter G = 4'b0110;
	parameter H = 4'b0111; 
	parameter I = 4'b1000;
	assign w = SW[1];
	assign clock = KEY[0];
	always @(w, y_Q)
	begin
		case (y_Q)
			A: if (!w) Y_D = B;
				else Y_D = F;
			B: if (!w) Y_D = C;
				else Y_D = F;
			C: if (!w) Y_D = D;
				else Y_D = F;
			D: if (!w) Y_D = E;
				else Y_D = F;
			E: if (!w) Y_D = E ;
				else Y_D = F;
			F: if (!w) Y_D = B;
				else Y_D = G;
			G: if (!w) Y_D = B;
				else Y_D = H;
			H: if (!w) Y_D = B;
				else Y_D = I;
			I: if (!w) Y_D = B;
				else Y_D = I;
		default: Y_D = 4'bxxxx;
		endcase
  end 
	always @(posedge clock)
	begin
		if (SW[0]==0)
			begin
			y_Q <= A;
			end
		else
			begin
			y_Q <= Y_D;
			end
	end // state_FFS
	
   assign z = (y_Q==I|y_Q==E);
   assign LEDR[9] = z;
   assign LEDR[4:0] = y_Q;
	
endmodule

//----------------------------------------------
//Part 3
module morseDec(SW, KEY, CLOCK_50, LEDR);

	input [2:0]SW;
	input [1:0]KEY;
	input CLOCK_50;

	output reg [1:0]LEDR = 1'b0;
	wire [15:0]morseCode;
	wire display;

	ALU alu(.switch(SW[2:0]), .out(morseCode[15:0])); //Choose the output
	shiftRegister shift(.D(morseCode[15:0]), .clock(CLOCK_50), .reset(KEY[0]), .load(~KEY[1]), .Q(display)); //shift register

	//LEDR output

	always@ (posedge CLOCK_50) begin
	begin
		if (display)
			LEDR[0] <= 1'b1;
		else
			LEDR[0] <= 1'b0;
	end
endmodule

module ALU(switch, out);

	input [2:0]switch;
	output reg [15:0]out;

	always@(*) 
	begin

		case(switch[2:0])
		begin

			3'b001: out = 16'b1011101110111000; //j

			3'b010: out = 16'b1110101110000000; //k

			3'b011: out = 16'b1011101010000000; //l

			3'b100: out = 16'b1110111000000000; //m

			3'b101: out = 16'b1110100000000000; //n

			3'b110: out = 16'b1110111011100000; //o

			3'b111: out = 16'b1011101110100000; //p

			3'b000: out = 16'b1110111010111000; //q

		endcase
	end
	
endmodule

module timer(clock, enable);

	input clock;
	output enable;
	reg [25:0]loadn = 26'b0;
	
	always@ (posedge clock) begin
	begin	
		if (loadn == 26'b0)
			loadn <= 26'b01011111010111100000111111; //24,999,999 0.5 seconds
		else
			loadn <= loadn - 1;
	end

	assign enable = (loadn == 26'b0)?1:0;
endmodule




module shiftRegister(D, clock, reset, load, Q);

	input [15:0]D;
	input clock;
	input reset;
	input load;
	output Q;
	wire enable;
	reg [15:0]bits;
	
	timer t(.clock(clock), .enable(enable));
	always@ (posedge clock, negedge reset, posedge load) begin
	begin
		if (load)
			bits <= D;

		else if (!reset)

			bits <= 16'b0;

		else if (enable == 1'b1)

			bits <= bits << 1'b1; //shifts the bits left

	end
	
	assign Q = bits[15];

endmodule
