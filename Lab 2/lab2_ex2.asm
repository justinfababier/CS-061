;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 2. ex 2
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG x3000

LDI  R3, DEC_65_PTR ;   R3 <- MEM[DEC_65_PTR] <- x4000
LDI  R4, HEX_41_PTR ;   R4 <- MEM[HEX_41_PTR] <- x4001
ADD R3, R3, #01     ;   R3 <- (R3) + #1 | #66, ASCII 'B'
ADD R4, R4, x01     ;   R4 <- (R4) + #1 | x42, ASCII 'B'
STI R3, DEC_65_PTR  ;   MEM[MEM[DEC_65_PTR]] <- (R3)
STI R4, HEX_41_PTR  ;   MEM[MEM[HEX_41_PTR]] <- (R4)

HALT

;Local Data
DEC_65_PTR  .FILL   x4000   ; Addr. of NEW_DEC_65
HEX_41_PTR  .FILL   x4001   ; Addr. of NEW_HEX_41

.END

;Remote Data
.ORIG x4000

NEW_DEC_65  .FILL   #65 ; Init. ASCII 'A'
NEW_HEX_41  .FILL   x41 ; Init. ASCII 'A'

.END