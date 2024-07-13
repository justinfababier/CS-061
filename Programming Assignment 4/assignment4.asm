;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: A21
; TA: Lisa Chen
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================
.ORIG x3000
;--------------
; Instructions
;--------------
; (1)   Set up flags, counters, accumulators as needed
; (2)   Get first character, test for '\n', '+', '-', digit/non-digit 	
; (3)   is very first character = '\n'? if so, just quit (no message)!
; (4)   is it = '+'? if so, ignore it, go get digits
; (5)   is it = '-'? if so, set neg flag, go get digits
; (6)   is it < '0'? if so, it is not a digit	- o/p error message, start over
; (7)   is it > '9'? if so, it is not a digit	- o/p error message, start over
; (8)   if none of the above, first character is first numeric digit - convert it to number & store in target register!
; (9)   Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, 
;       and build up number in accumulator
; (10)  remember to end with a newline!

START   LD  R0, INTRO_PTR   ; Load the address of the intro prompt message
        PUTS                ; Display the intro prompt to the user

AND R0, R0, #0              ; Clear R0 to store user input character
AND R1, R1, #0              ; R1 used for character comparisons
ADD R2, R2, #5              ; R2 holds digit counter, used to limit input to 5 digs.
AND R3, R3, #0              ; R3 holds flag, if (-) then the user-entered decimal number is negative
AND R4, R4, #0              ; R4*** will hold the binary representation of the user-entered decimal number

GETC
OUT

CHECK_\n    LD  R1, CHAR_NEWL
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, R0
            BRz EXIT                    ; Go to EXIT if newline detected

CHECK_+     LD  R1, CHAR_+
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, R0
            BRz GET_DIGITS              ; Go to GET_DIGITS if plus sign

CHECK_-     LD  R1, CHAR_-
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, R0
            BRz FLAG                    ; Go to FLAG if minus sign

CHECK_IF_DIGIT  LD  R1, CHAR_0
                NOT R1, R1
                ADD R1, R1, #1
                ADD R1, R1, R0
                BRn RESTART             ; Go to RESTART if the first character is not a digit (<'0')
                LD  R1, CHAR_9
                ADD R1, R1, R0
                NOT R1, R1
                ADD R1, R1, #1
                BRnz    VALID_DIGIT     ; Go to VALID_DIGIT if the first character is a valid digit
                BRp     RESTART         ; Go to RESTART if the first character is not a digit (>'0')

VALID_DIGIT     LD  R1, CHAR_0          ; ASCII value of '0'
                NOT R1, R1
                ADD R1, R1, #1
                ADD R0, R0, R1          ; '0' -> 0
                ADD R1, R4, #0          ; R1 will be used to calculate the binary representation
                ADD R6, R6, #9          ; Sets the loop to 10 iterations (R6 will be used as a loop counter)
                MLTPLY  ADD R4, R4, R1  ; Multiply (R4) by 10
                        ADD R6, R6, #-1 ; Decrement loop counter
                        BRp MLTPLY      ; Repeat the loop until R6 becomes non-negative
                ADD R4, R4, R0          ; Add the new digit (converted to binary) to the binary representation
                ADD R2, R2, #-1         ; Decrement digit counter
                BRz INPUT_END           ; If the digit counter reaches 0, exit


GET_DIGITS  GETC
            OUT
            LD  R1, CHAR_NEWL           ; Check if input is a newline
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, R0
            BRz INPUT_END               ; Go to INPUT_END if newline
            LD  R1, CHAR_+              ; Check if CHAR_PLUS
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, R0
            BRz RESTART                 ; Go to RESTART if plus sign
            LD  R1, CHAR_-              ; Check if CHAR_MINUS
            ADD R1, R1, R0
            BRz RESTART                 ; Go to RESTART if minus sign
            LD  R1, CHAR_0              ; Check if valid digit
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, R0
            BRn RESTART                 ; Go to RESTART char. is not a digit
            BRz VALID_DIGIT             ; Go to VALID_DIGIT if char. is a valid digit
            BRp CHECK_IF_DIGIT          ; Go to CHECK_IF_DIGIT if char. is 0 or +digit

;---------------------
; End of Input Branch
;---------------------
INPUT_END   ADD R3, R3, #0          ; Check flag register
            BRnz EXIT               ; Go to EXIT if the number is pos or zero
            NOT R4, R4              ; If number is negative, negate the binary representation
            ADD R4, R4, #1          ; 2's complement negation
            BR EXIT
            
;-------------
; Flag branch
;-------------
FLAG        ADD R3, R3, #1          ; Set the negative flag (R3 holds 1)
            BR GET_DIGITS

;----------------
; Restart Branch 
;----------------
RESTART     AND R2, R2, #0          ; Clear the digit counter
            LD  R0, CHAR_NEWL
            OUT
            LD  R0, ERROR_PTR
            PUTS
            BR  START



;-------------------
; Exit branch (EOP)
;-------------------
EXIT        HALT

; ---------------
; Program Data
; ---------------
INTRO_PTR   .FILL xB000              ; Address of the intro prompt message
ERROR_PTR   .FILL xB200              ; Address of the error message
CHAR_NEWL   .FILL x0A                ; ASCII value of '/n'
CHAR_+      .FILL x2B                ; ASCII value of '+'
CHAR_-      .FILL x2D                ; ASCII value of '-'
CHAR_0      .FILL x30                ; ASCII value of '0'
CHAR_9      .FILL x39                ; ASCII value of '9'

;-------------------
; End of local code
;-------------------
.END

;------------
; Remote data
;------------
.ORIG xB000     ; intro prompt
.STRINGZ        "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200     ; error message
.STRINGZ        "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END