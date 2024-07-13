;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Justin Fababier
; Email: jfaba001@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: A21
; TA: Lisa Chen
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

;------------------------------------------------------
;REG VALUES     R0  R1      R2  R3  R4  R5  R6      R7
;------------------------------------------------------
;Pre-loop       0   6       12  12  0   0   0       0
;Iteration 1    0   5       12  24  0   0   0       0
;Iteration 2    0   4       12  36  0   0   0       0
;Iteration 3    0   3       12  48  0   0   0       0
;Iteration 4    0   2       12  60  0   0   0       0
;Iteration 5    0   1       12  72  0   0   0       0
;Iteration 6    0   0       12  72  0   0   0       0
;EOP            0   x7FFF   12  72  0   0   x2FFE   0

;------
;Notes:
;------
;For pre-loop, register values are the initalized values on Lines 40-42
;Following pre-loop, the code branches to DO_WHILE six times
;After the last iteration when the 6 loop completes, the code does not branch and LC-3 is halted


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------
LD  R1, DEC_6   ; R1 <-- #6         | Load DEC_6's val into R1
LD  R2, DEC_12  ; R2 <-- #12        | Load DEC_12's val into R2
AND R3, R3, #0  ; R3 <-- R3 AND #0  | R3's value is initialized to #0 via AND

DO_WHILE
    ADD R3, R3, R2
    ADD R1, R1, #-1
    BRp DO_WHILE

HALT
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
DEC_6   .FILL   #6
DEC_12  .FILL   #12
DEC_0   .FILL   #0



;---------------	
;END of PROGRAM
;---------------	
.END


