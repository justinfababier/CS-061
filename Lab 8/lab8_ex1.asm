;=================================================
; Name: 
; Email: 
; 
; Lab: lab 8, ex 1
; Lab section: 
; TA: 
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LD  R2, LOAD_FILL_VALUE_3200
JSRR    R2
ADD R3, R3, #1
LD  R2, OUTPUT_AS_DECIMAL_3400
JSRR    R2

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
LOAD_FILL_VALUE_3200    .fill x3200
OUTPUT_AS_DECIMAL_3400  .fill x3400

.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: N/A
; Postcondition: Load a fixed value into register 1
; Return Value (R3): R3 <- (LABEL_3200)
;=================================================

.orig x3200

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R6, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0

; Code
LD  R3, LABEL_3200

; Restore registers
LDR R2, R6, #0
ADD R6, R6, #1
LDR R6, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET

LABEL_3200  .FILL   x0F00

.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: // Fixme
; Postcondition: // Fixme
; Return Value: // Fixme
;=================================================

.orig x3400

; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R6, R6, #0
;ADD R6, R6, #-1
;STR R3, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0

; Code
LOOP_3400
ADD R3, R3, #-10
BRn EXIT_LOOP_3400
BR  LOOP_3400
EXIT_LOOP_3400
ADD R3, R3, #10

; Restore registers
LDR R2, R6, #0
ADD R6, R6, #1
;LDR R3, R6, #0
;ADD R6, R6, #1
LDR R6, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET

.end