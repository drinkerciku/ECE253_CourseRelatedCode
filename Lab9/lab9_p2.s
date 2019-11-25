// The assembly code implements the use of KEYs and LEDRs to show a pattern in LEDRs present in the FPGA board
// NOTE: this approach uses polling where we continuously check if an I/O was pressed in the board
// NOTE: lab10 implements the same functionalities but using interrupts --> more efficient
.text
.global _start
_start:

	LDR R0,=0xff200000	//LEDRs address
	LDR R1,=0xff200050	//KEYs address
	LDR R4,=0xfffec600	//load address for clock
	LDR R3,=50000000	//load value for clock
	
	STR R3,[R4]
	MOV R3,#0b11
	STR R3,[R4,#0x8]
	
	LDR R5,=0x201

DISPLAY_1:
	LDR R3,=0x200
	MOV R2,#0x1
	STR R5,[R0]
WAIT1_DISPLAY:

	LDR R6,[R1]
	CMP R6,#0b1000
	BEQ WAIT3
	LDR R7,[R4,#0xc]
	CMP R7,#0
	BEQ WAIT1_DISPLAY
    
    	MOV R9,#1
    	STR R9,[R4,#0xc]
    
	LSL R2,R2,#1
	LSR R3,R3,#1
	
	EOR R8,R2,R3
	CMP R8,R5
	BEQ DISPLAY_1
	
	STR R8,[R0]
	B WAIT1_DISPLAY
    
WAIT3:
	LDR R6,[R1]
    CMP R6,#0
    BNE WAIT3
       
WAIT2_RESET:
	LDR R6,[R1]
	CMP R6,#0b1000
	BEQ WAIT4
	B WAIT2_RESET
    
WAIT4:
	LDR R6,[R1]
    	CMP R6,#0
    	BNE WAIT4
    	LDR R3,=0x200
	MOV R2,#0x1
	STR R5,[R0]
   	MOV R9,#1
   	STR R9,[R4,#0xc]
    	B WAIT1_DISPLAY
    
.end
