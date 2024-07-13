;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG x3000

LD  R3, DEC_65  ; R3 <- MEM[DEC_65]
LD  R4, HEX_41  ; R4 <- MEM[HEX_41]

HALT

;Local Data
DEC_65  .FILL   #65
HEX_41  .FILL   x41

.END