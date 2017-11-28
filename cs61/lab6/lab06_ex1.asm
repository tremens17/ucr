;=================================================
; Name: Moya, Branden
; Username: bmoya001@ucr.edu
; 
; Lab: lab 6.1
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================

.ORIG x3000

;INSTRUCTIONS
LD R3, ONE_CHECK
START

AND R1,R1,#0
AND R5,R5,#0			;RESETS VALUES
AND R6,R6,#0

LEA R0, PROMPT			;OUPUTS PROMPT
PUTS

GET_INPUT				;GETS INPUT AND CONVERTS IT TO A SINGLE NUMBER IN R1
	GETC
	OUT
	
	BR TEST_INPUT
	BACK 
	
	LD R4, NINE
	ADD R6,R1,#0		;SETS R6 TO R0 FOR MULTIPLICATION
	INNER
		ADD R1,R1,R6
		ADD R4,R4,#-1
	BRp INNER
	ADD R0,R0,R3
	ADD R1,R1,R0		;ADDS THE NEXT NUMBER
	
	ADD R6,R6,#2
BR GET_INPUT

TEST_INPUT
	LD R2, ENTER		;CHECKS FOR ENTER BAR
	ADD R2,R2,R0
	BRz LAST_CHECK
	
	ADD R2,R6,#-1
	BRzp NUM_CHECK
	
	LD R2, MINUS		;CHECKS FOR '-'
	ADD R2,R2,R0
	BRz NEGATIVE
	
	LD R2, PLUS			;CHECKS FOR '+'
	ADD R2,R2,R0
	BRz POSITIVE
	
	NUM_CHECK
	LD R2, ONE_CHECK	;CHECKS FOR < 1
	ADD R2,R2,R0
	BRn ERROR
	
	LD R2, NINE_CHECK	;CHECKS FOR > 9
	ADD R2,R2,R0
	BRp ERROR
BR BACK

NEGATIVE				;IF '-'
	ADD R5,R5,#-1
	ADD R6,R6,#1
BR GET_INPUT

POSITIVE				;IF '+'
	ADD R5,R5,#1
	ADD R6,R6,#1
BR GET_INPUT

NEGATE					;NEGATES R1 IF NEGATIVE SIGN WAS ENTERED
NOT R1,R1
ADD R1,R1,#1
BR FINISH

	LAST_CHECK
		ADD R2,R6,#-1
		BRn ERROR
		
		AND R5,R5,R5
		BRnp LAST_LAST_CHECK
		BR FINISH
		
		LAST_LAST_CHECK
			ADD R2,R6,#-2
		BRn ERROR
		
		AND R5,R5,R5
		BRn NEGATE
		BR FINISH

	ERROR				;ERROR OUTPUT/REASK FOR NUMBERS
		LD R2, ENTER
		ADD R2,R2,R0
		BRnp NEW_LINE 
		BACK_TO_ERROR
		LEA R0, WRONG
		PUTS
	BR START
	
	NEW_LINE
		AND R0,R0,#0
		ADD R0,R0,#10
		OUT
	BR BACK_TO_ERROR
	
FINISH

ADD R1,R1,#1
JSR OUTPUT_3200

HALT

;LOCAL DATA
PROMPT .STRINGZ "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
WRONG .STRINGZ "ERROR INVALID INPUT\n"
PLUS .FILL #-43
MINUS .FILL #-45
ENTER .FILL #-10
ONE_CHECK .FILL #-48	;TEST IF CHAR IS POSITIVE AFTER
NINE_CHECK .FILL #-57	;TEST IF CHAR IS NEGATIVE AFTER
ONE .FILL #1
NINE .FILL #9

;=================================================
;subroutine:PRINT IN decinmal
;input:R2 TO BE PRINTED IN decimal
;post condition:OUTPUT
;return values:NONE
.Orig x3200
OUTPUT_3200               ;NAME
ST R7, R7_3200             ;STORES R7,R5,R2 VALUES FOR BACKUP
LD R3, POINTER
LD R4, NUM_TO_CHAR
AND R5,R5,#0
ADD R5,R5,#5                ;COUNTER
AND R6,R6,#0

LOOP1
LDR R2,R3,#0
AND R0,R0,#0


LOOP2
ADD R1,R1,R2
BRn SKIP
ADD R0,R0,#1
ADD R6,R6,#1
BR LOOP2
SKIP
AND R6,R6,R6
BRz SKIP2

ADD R0,R0,R4
OUT

SKIP2

NOT R2,R2
ADD R2,R2,#1
ADD R1,R1,R2

ADD R3,R3,#1

ADD R5,R5,#-1
BRp LOOP1

LD R7, R7_3200              ;RESETS VAULES
RET

;Subroutine data
R7_3200 .FILL #0
NUM_TO_CHAR .FILL x30
POINTER .FILL x3300

.ORIG x3300
TEN_THOUSAND .FILL #-10000
THOUSAND .FILL #-1000
HOUNDRED .FILL #-100
TEN .FILL #-10
SDFSDFS .FILL #-1




.END