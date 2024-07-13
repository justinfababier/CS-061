;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG   x3000

LEA R1, ARRAY       ; R1 <- ADDR(R1)
LD  R2, ARRAY_SIZE  ; R2 <- (ARRAY) | decrementing counter using ARRAY's size #10
LEA R0, PROMPT      ; R0 <- ADDR(PROMPT)
PUTS                ; Output R0

LOOP                ; LOOP label
GETC                ; Read user input
ADD R1, R1, x1      ; R1 <- (R1) + #1   i.e., increment ARRAY's address by #1
STR R0, R1, x0      ; R1 <- (R0) + #0   i.e., store user input into ARRAY's address
ADD R2, R2, x-1     ; Decrement ARRAY_SIZE by #-1
BRp LOOP            ; Branch to LOOP if prev. instr. is (+)

LEA R1, ARRAY       ; See Line 12
LD  R2, ARRAY_SIZE  ; See Line 13
LOOP_2              ; LOOP_2 label
LDR R0, R1, x0      ; R0 <- MEM(R1) + #0
OUT                 ; Output R0
ADD R1, R1, x1      ; R1 <- (R1) + #1       i.e., increment ARRAY's address by #1
LD  R0, ASCII_NL    ; R0 <- (ASCII_NL)
OUT                 ; Output R0
ADD R2, R2, x-1     ; Decrement ARRAY_SIZE by #-1
BRp LOOP_2          ; Branch to LOOP_2 if prev. instr. is (+)

HALT

;-----------
;Local Data
;-----------
ASCII_NL    .STRINGZ    "\n"
PROMPT      .STRINGZ    "Enter 10 characters to store into ARRAY\n"
ARRAY_SIZE  .FILL       #10
ARRAY       .BLKW       #10

.END