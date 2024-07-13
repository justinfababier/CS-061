;=================================================
; Name: 
; Email: 
; 
; Lab: lab 4, ex 2
; Lab section: 
; TA: 
; 
;=================================================
.ORIG   x3000
; Main Program
LEA R1, ARRAY
LD  R5, SUB_FILL_ARRAY
JSRR    R5
LD  R5, SUB_CONVERT_ARRAY
JSRR    R5
LD  R5, SUB_PRINT_ARRAY
JSRR    R5

HALT

; Local Data
ARRAY   .BLKW   #10
SUB_FILL_ARRAY      .FILL   x3200
SUB_CONVERT_ARRAY   .FILL   x3400
SUB_PRINT_ARRAY     .FILL   x3600

.END

;===========================================================================================================
; Subroutine:       SUB_FILL_ARRAY
; Parameter (R1):   The starting address of the array. This should be unchanged at the end of the subroutine!
; Post-condition:   The array has values from 0 through 9.
; Return Value:     None
;===========================================================================================================
.ORIG   x3200

LD  R2, ARRAY_SIZE
ADD R3, R1, x0
LOOP
STR R2, R3, x09
ADD R3, R3, x-1
ADD R2, R2, x-1
BRp LOOP

RET

; Subroutine Data
ARRAY_SIZE  .FILL   #9

.END

;===========================================================================================================
; Subroutine:       SUB_CONVERT_ARRAY
; Parameter (R1):   The starting address of the array. This should be unchanged at the end of the subroutine
; Post-condition:   Each element (number) in the array should be represented as a character. E.g. 0 -> ‘0’
; Return Value:     None
;===========================================================================================================
.ORIG   x3400

AND R2, R2, x0
AND R3, R3, x0
LD  R3, SUB_CONVERT_ARRAY_COUNTER
LOOP_CONVERT
LDR R2, R1, x0
ADD R2, R2, x0C
ADD R2, R2, x0C
ADD R2, R2, x0C
ADD R2, R2, x0C
STR R2, R1, x0
ADD R1, R1, x01
ADD R3, R3, x-01
BRp LOOP_CONVERT
ADD  R1, R1, x-0A

RET

; Subroutine Data
SUB_CONVERT_ARRAY_COUNTER   .FILL   x0A

.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (character) in the array is printed out to the console.
; Return Value (None)
;-----------------------------------------------------------------------
.ORIG   x3600

AND R2, R2, x0
AND R3, R3, x0
LD  R3, SUB_PRINT_ARRAY_COUNTER
LOOP_PRINT
LDR R0, R1, x0
OUT
ADD R1, R1, x01
ADD R3, R3, x-01
BRp LOOP_PRINT

RET

; Subroutine Data
SUB_PRINT_ARRAY_COUNTER .FILL   x0A

.END