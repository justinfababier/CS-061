;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 2. ex 3
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG x3000

LD  R5, DEC_65_PTR  ; R1 <- MEM[DEC_65_PTR] <- x4000
LD  R6, HEX_41_PTR  ; R2 <- MEM[HEX_41_PTR] <- x4001
LDR R3, R5, #0      ; R3 <- MEM[(R5) + #0] <- #65
LDR R4, R6, #0      ; R4 <- MEM[(R6) + #0] <- x41
ADD R3, R3, #1      ; R3 <- (R3) + #1
ADD R4, R4, #1      ; R4 <- (R4) + #1
STR R3, R5, #0      ; x4000 <- MEM[(R5)] <- (R3)
STR R4, R6, #0      ; x4001 <- MEM[(R4)] <- (R4)

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