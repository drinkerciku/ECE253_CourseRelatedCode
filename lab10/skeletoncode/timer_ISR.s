				.include "address_map_arm.s"
				.extern	LEDR_DIRECTION
				.extern	LEDR_PATTERN

/*****************************************************************************
 * MPCORE Private Timer - Interrupt Service Routine                                
 *                                                                          
 * Shifts the pattern being displayed on the LEDR
 * 
******************************************************************************/
				.global PRIV_TIMER_ISR
PRIV_TIMER_ISR:	
				LDR	R0, =MPCORE_PRIV_TIMER		// base address of timer
				MOV	R1, #1
				STR	R1, [R0, #0xC]				// write 1 to F bit to reset it
												// and clear the interrupt

/* Move the two LEDS to the centre or away from the centre to the outside. */
SWEEP:		
				LDR	R0, =LEDR_DIRECTION			// put shifting direction into R2
				LDR	R2, [R0]
				LDR	R1, =LEDR_PATTERN			// put LEDR pattern into R3
				LDR	R3, [R1]

				AND R7,R3,#0x3E0				//extract the left half of current LEDR values
				AND R8,R3,#0x01F				//extract the right half of current LEDR values
				
				CMP R2,#0
				BNE TOOUTSIDE

TOCENTRE:		

				LSR R7,R7,#1					//shift the upper half by one to the right
				LSL R8,R8,#1					//shift the lower half by one to the left
				EOR R3,R7,R8					//logical XOR them to the same bus 
				CMP R3,#0x030					//check if both lights are in the middle
				BNE DONE_SWEEP

C_O:			
				MOV	R2, #1						// change direction to outside
				B DONE_SWEEP
TOOUTSIDE:		

				LSL R7,R7,#1					//shift the upper half by one to the left
				LSR R8,R8,#1					//shift the lower half by one to the right
				EOR R3,R7,R8					//logical XOR them to the same bus 
				LDR R9,=0x201
				CMP R3,R9					//check if both lights are in the middle
				BNE DONE_SWEEP

O_C:			
				MOV	R2, #0		// change direction to centre
				
DONE_SWEEP:
				STR	R2, [R0]				// put shifting direction back into memory
				STR	R3, [R1]				// put LEDR pattern back onto stack
	
END_TIMER_ISR:
				MOV		PC, LR
