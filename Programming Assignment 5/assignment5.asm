; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: A21
; TA: Lisa Chen
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stack
LD      R6, STACK_ADDR

; call main subroutine
LEA     R5, MAIN
JSRR    R5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
MAIN
; get a string from the user
LEA     R1, USER_PROMPT                 ; Load the address of the user prompt string into R1.
LEA     R2, USER_STRING                 ; Load the address where the user string should be stored into R2.
LD      R5, GET_USER_STRING_ADDR        ; Get user input.
JSRR    R5

; find size of input string
LD      R5, STRLEN_ADDR                 ; Find the size of the input string.
JSRR    R5

; call palindrome method
LEA     R1, USER_STRING                 ; Load the address of the user string into R1.
LD      R5, PALINDROME_ADDR             ; Check if the string is a palindrome.
JSRR    R5

; determine if the string is a palindrome
ADD     R0, R0, #0                      ; Copy the return value of the palindrome-checking subroutine to R0.
BRp     TRUE                            ; If return value is positive, jump to "TRUE" label.
BRz     FALSE                           ; If return value is zero, jump to "FALSE" label.

; print the result to the screen
TRUE        LEA     R0, RESULT_STRING   ; Load the address of the palindrome result message into R0.
            PUTS                        ; Print the message indicating that the string is a palindrome.
            LEA     R0, FINAL_STRING    ; Load the address of the final message into R0.
            PUTS                        ; Print the final message indicating the end of the program.
            BR      EXIT_MAIN           ; Exit the main subroutine.

FALSE       LEA     R0, RESULT_STRING   ; Load the address of the palindrome result message into R0.
            PUTS                        ; Print the message indicating that the string is not a palindrome.
            LEA     R0, NOT_STRING      ; Load the address of the "not" message into R0.
            PUTS                        ; Print the "not" message.
            LEA     R0, FINAL_STRING    ; Load the address of the final message into R0.
            PUTS                        ; Print the final message indicating the end of the program.
            BR      EXIT_MAIN           ; Exit the main subroutine.

EXIT_MAIN   HALT                        ; Halt the program.

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

STACK_ADDR           .FILL    xFE00
GET_USER_STRING_ADDR .FILL    x3200
STRLEN_ADDR          .FILL    x3300
PALINDROME_ADDR      .FILL    x3400

USER_PROMPT          .STRINGZ  "Enter a string: "
RESULT_STRING        .STRINGZ  "The string is "
NOT_STRING           .STRINGZ  "not "
FINAL_STRING         .STRINGZ  "a palindrome\n"

USER_STRING          .BLKW    #100

.END

;---------------------------------------------------------------------------------
; SUBROUTINE    : GET_USER_STRING
; PARAMETER (R1): THE ADDRESS OF THE USER PROMPT STRING
;           (R2): THE ADDRESS WHERE THE USER STRING SHOULD BE STORED
; RETURN VALUE  : N/A
;---------------------------------------------------------------------------------
.ORIG x3200
GET_USER_STRING

; Backup used registers
BACKUP_3200     ADD     R6, R6, #-1
                STR     R7, R6, #0
                ADD     R6, R6, #-1
                STR     R3, R6, #0
                ADD     R6, R6, #-1
                STR     R1, R6, #0

OUTPUT_3200     ADD     R0, R1, #0      ; Load the address of the user prompt string into R0.
                PUTS                    ; Print the user prompt.

LOOP_3200       GETC                    ; Read a character from the console and store it in R0.
                OUT                     ; Echo the character to the console.
                ADD     R3, R0, x-0A    ; Check if the input character is the newline character '\n'.
                BRz     RESTORE_3200    ; If the character is a newline, exit the loop.
                STR     R0, R2, #0      ; Store the input character in memory at the address in R2.
                ADD     R2, R2, #1      ; Increment the address in R2 to store the next character.
                BR      LOOP_3200       ; Repeat the loop to get the next character.

RESTORE_3200    LDR     R1, R6, #0      ; Restore the registers.
                ADD     R6, R6, #1
                LDR     R3, R6, #0
                ADD     R6, R6, #1
                LDR     R7, R6, #0
                ADD     R6, R6, #1

EXIT_3200       RET                     ; Return from the subroutine.

.END

;---------------------------------------------------------------------------------
; SUBROUTINE        : STRLEN
; PARAMETER     (R2): ADDR. WHERE THE USER STRING IS STORED
; RETURN VALUE  (R4): COUNTS THE NUMBER OF CHARACTERS IN THE STRING
;---------------------------------------------------------------------------------
.ORIG x3300
STRLEN

; Backup used registers
BACKUP_3300     ADD     R6, R6, #-1
                STR     R7, R6, #0
                ADD     R6, R6, #-1
                STR     R2, R6, #0
                ADD     R6, R6, #-1
                STR     R1, R6, #0

LOOP_3300       LDR     R1, R2, #0      ; Load a character from the memory location pointed to by R2 into R1.
                BRz     RESTORE_3300    ; If the character is null (0), the end of the string is reached.
                ADD     R4, R4, #1      ; Increment the character count (R4) by 1.
                ADD     R2, R2, #1      ; Move to the next character in the string.
                BR      LOOP_3300       ; Repeat the loop to process the next character.

RESTORE_3300    LDR     R1, R6, #0      ; Restore the registers.
                ADD     R6, R6, #1
                LDR     R2, R6, #0
                ADD     R6, R6, #1
                LDR     R7, R6, #0
                ADD     R6, R6, #1

EXIT_3300       RET                     ; Return from the subroutine.

.END

;-------------------------------------------------------------------------------------
; SUBROUTINE        :   PALINDROME
; PARAMETER     (R1):   ADDRESS OF THE FIRST LETTER OF THE STRING
;               (R2):   ADDRESS OF THE LAST CHARACTER OF THE STRING + x0001
; RETURN VALUE  (R0):   RETURN 1 IF THE PASSED STRING IS PALINDROME, RETURN 0 IF NOT.
;                       STORE IN R0.
;-------------------------------------------------------------------------------------
.ORIG x3400

ADD R2, R2, x-01
; Backup used registers
BACKUP_3400     ADD     R6, R6, #-1
                STR     R7, R6, #0
                ADD     R6, R6, #-1
                STR     R5, R6, #0
                ADD     R6, R6, #-1
                STR     R4, R6, #0
                ADD     R6, R6, #-1
                STR     R3, R6, #0
                ADD     R6, R6, #-1
                STR     R2, R6, #0
                ADD     R6, R6, #-1
                STR     R1, R6, #0

PALINDROME ; Recursive label

CHECK_ADDR      ADD     R3, R1, #0      ; Load the address of the string into R3.
                ADD     R4, R2, #0      ; Load the address of the string into R4.
                NOT     R4, R4          ; Invert the bits of R4 to get the complement of the last address.
                ADD     R4, R4, #1      ; Increment R4 to get the 2's complemented address.
                ADD     R5, R3, R4      ; Add the values of R3 and R4
                BRzp    IS_PALINDROME   ; If the sum is zero or positive, the addresses are same, & branch out.

CHECK_CHAR      LDR     R3, R1, #0      ; Load the value of the character at the start of the string into R3.
                LDR     R4, R2, #0      ; Load the value of the character at the end of the string into R4.
                NOT     R4, R4          ; Invert the bits of R4 to get the complement of the last character's ASCII value.
                ADD     R4, R4, #1      ; Increment R4 to get the ASCII value of the character after the last one.
                ADD     R5, R3, R4      ; Add the ASCII value of the first and last characters.
                BRnp    NOT_PALINDROME  ; If the sum is negative or pos., the characters are not equal, and we stop.
                ADD     R1, R1, #1      ; Move to the next character in the string.
                ADD     R2, R2, #-1     ; Move to the previous character in the string.
                JSR     PALINDROME      ; Recursively call the PALINDROME subroutine.***

NOT_PALINDROME  AND     R0, R0, #0      ; Set the return value to 0 (not a palindrome).
                BR      RESTORE_3400    ; Restore the registers and return.

IS_PALINDROME   AND     R0, R0, #0      ; Set the return value to 1 (is a palindrome).
                ADD     R0, R0, #1
                BR      RESTORE_3400    ; Restore the registers and return.

RESTORE_3400    LDR     R1, R6, #0
                ADD     R6, R6, #1
                LDR     R2, R6, #0
                ADD     R6, R6, #1
                LDR     R3, R6, #0
                ADD     R6, R6, #1
                LDR     R4, R6, #0
                ADD     R6, R6, #1
                LDR     R5, R6, #0
                ADD     R6, R6, #1
                LDR     R7, R6, #0
                ADD     R6, R6, #1

EXIT_3400       RET                     ; Return from the subroutine.

.END
