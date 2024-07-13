;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG   x3000

LEA R1, ARRAY       ; R1 <- ADDR(R1)
LD  R2, ARRAY_SIZE  ; R2 <- (ARRAY) | decrementing counter
LEA R0, PROMPT      ; R0 <- ADDR(PROMPT)
PUTS                ; Output R0

LOOP                ; LOOP label
GETC                ; Read user input
OUT
STR R0, R1, x00     ; R1 <- (R0) + #0   i.e., store user input into ARRAY's address
ADD R1, R1, x01     ; R1 <- (R1) + #1   i.e., increment ARRAY's address by #1
ADD R2, R2, x-01    ; Decrement ARRAY_SIZE by #-1
BRp LOOP            ; Branch to LOOP if prev. instr. is (+)

HALT

;-----------
;Local Data
;-----------
ASCII_NL    .STRINGZ    "\n"
PROMPT      .STRINGZ    "Enter 10 characters to store into ARRAY\n"
ARRAY_SIZE  .FILL       x0A
ARRAY       .BLKW       x0A

.END