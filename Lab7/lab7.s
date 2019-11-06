//sum only positive elements of the list NUM_TEST
//element must be the only -1 in the list as it indicates its end

.text
.global _start
_start:

	LDR R0,=NUM_TEST
	LDR R4,[R0],#4
	CMP R4,#-1
	BEQ END
	MOV R7,#0
	MOV R8,#0
    
LOOP_2:

	CMP R4,#0
    	BGT ADDIN
    	BLE CHECK
    
ADDIN:

	ADD R7,R4,R7
	ADD R8,R8,#1
    
CHECK:
	
    	LDR R4,[R0],#4
    	CMP R4,#-1
	BNE LOOP_2
    
END: B END

NUM_TEST:
	.word 1,2,3,0,5,-2,0xA,-1
.end
