;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================

.ORIG x3000
;------------------
; Instructions
;------------------
AND R1, R1, #0  ; R1 <-- (R1) AND #0 | Initializes R1 to #0 via AND operator
LD  R2, DEC_12  ; R2 <-- #12
LD  R3, DEC_6   ; R3 <-- #6

DO_WHILE_LOOP           ; Label
    ADD R1, R1, R2      ; R1 <-- R1 + R2
    ADD R3, R3, #-1     ; R3 <-- R3 + #-1
    BRp DO_WHILE_LOOP   ; Branch to DO_WHILE_LOOP if prev. instr. is (+)
;END_DO_WHILE_LOOP (label)

HALT

;------------------
; Local Data
;------------------
;DEC_0   .FILL   #0
DEC_12  .FILL   #12
DEC_6   .FILL   #6
    
.END
    