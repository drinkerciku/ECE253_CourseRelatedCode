
.text
.global _start
_start:

	LDR R0,=NUM_TEST
   	LDR R4,[R0],#4
    	MOV R7,#0
	MOV R8,#0

LOOP_2:

	ADD R8,R8,#1
    	ADD R7,R4,R7
    	LDR R4,[R0],#4
    	CMP R0,#FIN
    	BNE LOOP_2
    
END: B END

NUM_TEST:
	.word 1,2,3,5,0xA,-0x1
FIN:
	.word -0x1
    .end
