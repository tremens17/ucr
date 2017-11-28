;=================================================
; Name: Moya, Branden
; Username: bmoya001@ucr.edu
; 
; Lab: lab 5
; Lab section: 021
; TA: Bryan Marsh
; 
;=================================================
.Orig x3000

;Instructions
LEA R0, PROMPT
PUTS

JSR GET_INPUT_3200
JSR PRINT_IN_BINARY_3400

HALT

;Local data
PROMPT .STRINGZ "ENTER a 16 bit 2's compliment number starting with 'b':\n"

;====================
;subroutine:GET INPUT AND CONVERT FROM BINARY TO DECIMAL
;input:NONE
;post condition:R2 HOLDS THE NEW NUMBER
;return values:R2
.Orig x3200
GET_INPUT_3200
ST R1, R1_3200
ST R7, R7_3200
ST R3, R3_3200

RE_GET_INPUT_3200
LD R1, COUNTER_3200
AND R2,R2,#0

GETC
OUT
LD R3, B_3200
ADD R7,R0,R3
BRnp ERROR

GET_INPUT
GETC
OUT

BR ERROR_CHECK_3200
BACK_3200

LD R7, ZERO_3200
ADD R2,R2,R2
ADD R0,R0,R7
BRz SKIP_3200           ;SKIP IF A '0' IS ENTERED

ADD R2,R2,#1

SKIP_3200

ADD R1,R1,#1
BRn GET_INPUT

LD R1, R1_3200
LD R3, R3_3200
LD R7, R7_3200
RET

ERROR_CHECK_3200
LD R3, ONE_3200
ADD R7,R0,R3
BRz BACK_3200

LD R3, ZERO_3200
ADD R7,R0,R3
BRz BACK_3200

LD R3, SPACE_3200
ADD R7,R0,R3
BRz GET_INPUT

ERROR
LEA R0, ERROR_PROMPT_3200
PUTS
BR RE_GET_INPUT_3200


;Subroutine data
ERROR_PROMPT_3200 .STRINGZ "\nERROR!!!\nENTER a 16 bit 2's compliment number starting with 'b':\n"
R1_3200 .FILL #0
R3_3200 .FILL #0
R7_3200 .FILL #0
COUNTER_3200 .FILL #-16
ZERO_3200 .FILL #-48
ONE_3200 .FILL #-49
SPACE_3200 .FILL #-32
B_3200 .FILL #-98


;====================
;subroutine:PRINT IN BINARY
;input:R2 TO BE PRINTED IN BINARY
;post condition:OUTPUT
;return values:NONE
.Orig x3400
PRINT_IN_BINARY_3400
ST R2, R2_3400
ST R7, R7_3400             ;STORES R7,R5,R2 VALUES FOR BACKUP
ST R5, R5_3400
LD R5, COUNTER_3400         ;SETS R5 AS COUNTER FOR OUTPUT

LEA R0, B                   ;OUTPUTS "b"
PUTS

LOOP_3400
AND R2,R2,R2
BRn NEGATIVE
    
;POSITIVE
LEA R0, ZERO
PUTS
BR NEXT

NEGATIVE
LEA R0, ONE
PUTS

NEXT

ADD R2,R2,R2
ADD R5,R5,#-1
BRp LOOP_3400

LD R2, R2_3400
LD R7, R7_3400              ;RESETS VAULES
LD R5, R5_3400
RET

;Subroutine data
R2_3400 .FILL #0
R7_3400 .FILL #0
R5_3400 .FILL #0
COUNTER_3400 .FILL #16
B .STRINGZ "\nb"
ZERO .STRINGZ "0"
ONE .STRINGZ "1"

.END