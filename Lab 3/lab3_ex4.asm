;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================
.ORIG   x3000

LEA R0, PROMPT_SEN  ; R0 <- ADDR(PROMPT_SEN)
PUTS                ; Output R0
GETC                ; Read user input
OUT                 ; Output R0
AND R3, R0, R0      ; R3 <- (R0) AND (R0)
NOT R3, R3          ; R3 <- NOT(R3)
ADD R3, R3, x1      ; R3 <- (R3) + #1   i.e., 2's complement of user-inputted sentinel val.
LD  R1, ARRAY_PTR   ; R1 <- ADDR(R1)
LEA R0, PROMPT_ARR  ; R0 <- ADDR(PROMPT_ARR)
PUTS                ; Output R0
LOOP                ; LOOP label
AND R4, R4, x0      ; R4 <- (R4) + #0   i.e., init. (R4) to #0
GETC                ; Read user input
OUT                 ; Output R0
STR R0, R1, x0      ; R1 <- (R0) + #0   i.e., store user input into ARRAY's address
ADD R1, R1, x01     ; R1 <- (R1) + #1   i.e., increment ARRAY's address by #1
ADD R4, R0, R3      ; Check if sentinel character is inputted
BRnp LOOP           ; Branch to LOOP if prev. instr. is (+/-)
AND R0, R0, x0
STR R0, R1, x-01
LD  R1, ARRAY_PTR   ; See Line 19
LOOP_2              ; LOOP_2 label
LDR R0, R1, x0      ; R0 <- MEM(R1) + #0
OUT                 ; Output R0
ADD R1, R1, x01     ; R1 <- (R1) + #1       i.e., increment ARRAY's address by #1
;ADD R4, R0, R3      ; Check if sentinel character is outputted
ADD R0, R0, x0
BRnp LOOP_2         ; Branch to LOOP_2 if prev. instr. is (+/-)

HALT

;-----------
;Local Data
;-----------
ASCII_NL    .STRINGZ    "\n"
PROMPT_ARR  .STRINGZ    "\nEnter 10 characters to store into ARRAY: \n"
PROMPT_SEN  .STRINGZ    "Enter a sentinel character: "
ARRAY_SIZE  .FILL       x0A
ARRAY_PTR   .FILL       x4000

.END