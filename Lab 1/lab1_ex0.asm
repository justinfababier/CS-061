;=================================================
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: A21
; TA: Lisa Chen
; 
;=================================================

.ORIG x3000

LEA R0, MSG_TO_PRINT    ; Label addr. "MSG_TO_PRINT" is loaded into R0
PUTS                    ; Prints string in R0

HALT                    ; Ends code instruction

; Local Data
MSG_TO_PRINT    .STRINGZ    "Hello world!!!\n"

.END