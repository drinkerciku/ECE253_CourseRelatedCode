	.include "address_map_arm.s"
/* 
 * This program demonstrates the use of interrupts using the KEY and timer ports. It
 * 	1. displays a sweeping red light on LEDR, which moves left and right
 * 	2. stops/starts the sweeping motion if KEY3 is pressed
 * Both the timer and KEYs are handled via interrupts
*/
			.text
			.global	_start
_start:
			MOV R1,#0b10010		//setup stack pointer for IRQ mode on the processor
			MSR CPSR, R1
			LDR SP, =0x20000
			
			MOV R1,#0b10011		//setup stack pointer for SVC mode on the processor 
			MSR CPSR, R1
			LDR SP, =0x40000

			BL CONFIG_GIC					// configure the ARM generic interrupt controller
			BL CONFIG_PRIV_TIMER			// configure the MPCore private timer
			BL CONFIG_KEYS					// configure the pushbutton KEYs
			
			MSR CPSR,#0b00010011

			LDR	R6, =0xFF200000 			// red LED base address
MAIN:
			LDR R4, LEDR_PATTERN			// LEDR pattern; modified by timer ISR
			STR R4, [R6] 					// write to red LEDs
			B MAIN

/* Configure the MPCore private timer to create interrupts every 1/10 second */
CONFIG_PRIV_TIMER:
			LDR	R0, =0xFFFEC600 			// Timer base address
			LDR R1, =20000000				//for 200MHz clock it takes 0.1 secs
			STR R1, [R0]					//store the count value in the clock
			
			MOV R1, #0b111
			STR R1,[R0,#0x8]				//set E and A to 1 in the control clock address
			
			MOV PC, LR 						// return

/* Configure the KEYS to generate an interrupt */
CONFIG_KEYS:
			LDR R0, =0xFF200050 		// KEYs base address
			
			MOV	R1,#0x8					//set enable interrupts code --> only KEY3
			STR R1,[R0,#0x8]
			
			MOV PC, LR 					// return

			.global	LEDR_DIRECTION
LEDR_DIRECTION:
			.word 	0							// 0 means means moving to centre; 1 means moving to outside

			.global	LEDR_PATTERN
LEDR_PATTERN:
			.word 	0x201	// 1000000001
