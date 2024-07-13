; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: A21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;outputs prompt
;----------------------------------------------
LEA R0, INTRO   ; R0 <- MEM[INTR0]
PUTS            ; Invokes BIOS routine to output string

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
;AND R1, R1, x00 ; Init. R1 to x0, R1 holds first input
;AND R2, R2, x00 ; Init. R2 to x0, R2 holds second input
;AND R3, R3, x00 ; Init. R3 to x0, R3 is a loop counter

; Lines 30-48: take inputs, echo inputs to console
GETC            ; Obtain first user input
OUT             ; Output R0
ADD R1, R1, R0  ; R1 has first input as ASCII char.
LD  R0, NEWLINE ; R0 has NEWLINE
OUT             ; Output R0
GETC            ; Obtain second user input
OUT             ; Output R0
ADD R2, R2, R0  ; R2 has second input as ASCII char.

; Lines 39-48: output to console the operation being performed
LD  R0, NEWLINE ; R0 has NEWLINE
OUT             ; Output R0
ADD R0, R1, x00 ; R0 <- (R1) + x00
OUT             ; Output R0
LEA R0, DASH    ; R0 <- MEM[DASH]
PUTS            ; Output R0
ADD R0, R2, x00 ; R0 <- (R2) + x00
OUT             ; Output R0
LEA R0, EQUAL   ; R0 <- MEM[EQUAL]
PUTS            ; Output R0

; Lines 52-60: convert ASCII characters to equivalent numbers, perform operation, store sum in another reg.
ADD R3, R3, x03     ; R3 <- (R3) + x03
DO_WHILE_1          ; Branch label
ADD R1, R1, x-10    ; R1 <- (R1) + x-10
ADD R2, R2, x-10    ; R2 <- (R2) + x-10
ADD R3, R3, x-01    ; R3 <- (R3) + x-01
BRp DO_WHILE_1
NOT R2, R2          ; R2 <- NOT(R2)
ADD R2, R2, x01     ; R2 <- (R2) + x01
ADD R4, R1, R2      ; R4 <- (R1) + (R2)

; Lines 62-63: if (R4) is (-), obtain the magnitude & output '-' sign
BRn SIGN            ; Go to SIGN if (R4) is (-)
SIGN_RETURN         ; Return from SIGN

; Lines 66-75: convert (R4) from numeric value to ASCII value, output value followed by a newline
ADD R3, R3, x04     ; R3 <- (R3) + x04
DO_WHILE_2          ; Branch label
ADD R4, R4, x0C     ; R4 <- (R4) + x0C
ADD R3, R3, x-01    ; R3 <- (R3) + x-01
BRp DO_WHILE_2
ADD R0, R4, x00     ; R0 <- (R4) + x00
OUT
LD  R0, NEWLINE
OUT

BR  EXIT            ; Branch to EXIT

; Sign branch, do 2's complement on R4 if it holds (-) value
SIGN
LD  R0, NEGATIVE
OUT                 ; Output (R0)
NOT R4, R4          ; R4 <- NOT(R4)
ADD R4, R4, x01     ; R4 <- (R4) + x01
BR  SIGN_RETURN

EXIT                ; End of program

HALT

;------
;Data
;------
INTRO       .STRINGZ "ENTER two numbers (i.e '0'....'9')\n" 
NEWLINE     .STRINGZ "\n"; String that holds the newline character
EQUAL       .STRINGZ " = "
DASH        .STRINGZ " - "
NEGATIVE    .STRINGZ "-"

;---------------
;END of PROGRAM
;---------------
.END
