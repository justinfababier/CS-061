;=================================================
; Name: Justin
; Email: Fababier
; 
; Lab: lab 3. ex 3
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG x3000

LD  R5, DATA_PTR    ; R1 <- MEM[DEC_65_PTR] <- x4000
LDR R3, R5, x0      ; R3 <- MEM[(R5) + #0] <- #65
LDR R4, R5, x1      ; R4 <- MEM[(R5) + #1] <- x41
ADD R3, R3, x1      ; R3 <- (R3) + #1 <- #66
ADD R4, R4, x1      ; R4 <- (R4) + #1 <- x42
STR R3, R5, x0      ; x4000 <- MEM[(R5)] <- (R3) <- #66
STR R4, R5, x1      ; x4001 <- MEM[(R4)] <- (R4) <- x42

HALT

;Local Data
DATA_PTR    .FILL   x4000

.END

;Remote Data
.ORIG x4000

NEW_DEC_65  .FILL   #65 ; Init. ASCII 'A'
NEW_HEX_41  .FILL   x41 ; Init. ASCII 'A'

.END