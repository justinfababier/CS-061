;=================================================
; Name: 
; Email: 
; 
; Lab: lab 4, ex 1
; Lab section: 
; TA: 
; 
;=================================================
.ORIG   x3000
; Main Program
LEA R1, ARRAY
LD  R5, SUB_FILL_ARRAY
JSRR R5

HALT

; Local Data
ARRAY   .BLKW   #10
SUB_FILL_ARRAY  .FILL   x3200

.END

;===========================================================================================================
; Subroutine:       SUB_FILL_ARRAY
; Parameter (R1):   The starting address of the array. This should be unchanged at the end of the subroutine!
; Post-condition:   The array has values from 0 through 9.
; Return Value:     None
;===========================================================================================================
.ORIG   x3200

; Subroutine code
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