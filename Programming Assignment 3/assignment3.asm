;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 021
; TA: Lisa Chen
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD  R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
;Pseudocode:
;   for(i = 15 down to 0):
;       if (msb = 1):
;           print 1
;       else:
;           print 0
;       shift left

; Init. nibble & total bit counters
LD  R2, DEC_16                  ; R2 <- (DEC_04)    i.e., nibble decrement counter
LD  R3, DEC_04                  ; R2 <- (DEC_16)    i.e., word decrement counter

LOOP        AND R1, R1, R1      ; LOOP label & R1 <- (R1) AND (R1) i.e., read bits
            ;ADD R1, R1, x0
            BRn OUTPUT_1        ; Branch to OUTPUT_1 i.e., (R1) is (-) (MSB is a 1)
            BRp OUTPUT_0        ; Branch to OUTPUT_0 i.e., (R1) is (+) (MSB is a 0)

OUTPUT_0    LD  R0, ASCII_0     ; R0 <- MEM(ASCII_1)
            OUT                 ; Print 0
            BR  SHIFT           ; Branch to SHIFT

OUTPUT_1    LD  R0, ASCII_1     ; R0 <- MEM(ASCII_1)
            OUT                 ; Print 1
            BR  SHIFT           ; Branch to SHIFT

SHIFT       ADD R2, R2, x-01    ; Decrement byte counter
            BRz MULTIPLY        ; If word counter is #0, branch to SHIFT
            ADD R3, R3, x-01    ; Decrement nibble counter; R3 -= -1
            BRp MULTIPLY        ; If nibble counter is (+) branch to SHIFT, nibble counter reset
            LD  R0, ASCII_SP    ; R0 <- (R0) + ASCII_SP
            OUT                 ; Print ' '
            ADD R3, R3, x04     ; R3 <- (R3) + #4 | Nibble counter reset to #4
            MULTIPLY            ; MULTIPLY label
            ADD R1, R1, R1      ; R1 <- (R1) + (R1) i.e., multiply val & shift binary bits left by 1 
            AND R2, R2, R2      ; Read bits
            ;ADD R2, R2, x0
            BRp LOOP

END         LD  R0, ASCII_NL    ; R0 holds x0A
            OUT                 ; print 

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL   xCA01	; The address where value to be displayed is stored
ASCII_0     .FILL   x30
ASCII_1     .FILL   x31
ASCII_SP    .FILL   x20
ASCII_NL    .FILL   x0A
DEC_04      .FILL   #04
DEC_16      .FILL   #16

.END

.ORIG xCA01					; Remote data
Value .FILL xF000			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END