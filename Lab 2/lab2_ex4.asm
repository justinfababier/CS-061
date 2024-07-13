;=================================================
; Name: Justin Fababier
; Email:  jfaba001@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG x3000

LD  R0, HEX_61  ; R0 <- MEM[HEX_61]
LD  R1, HEX_1A  ; R1 <- MEM[HEX_1A]

LOOP
OUT             ; i.e., Trap x21 | output R0's value to console
ADD R0, R0, #1  ; R0 <- (R0) + #1
ADD R1, R1, #-1 ; R1 <- (R1) + #-1
BRp LOOP        ; Branch

HALT

; Local Data
HEX_61  .FILL   x61 ; x61, #97, ASCII 'a'
HEX_1A  .FILL   x1A ; x1A, #26, ASCII 'SUB'

.END