*===============================================================================
;                                   LINES
*===============================================================================

; ------------------------------------------------------------------------------
LININIT
; INITIALIZE LINES
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        

; ------------------------------------------------------------------------------
LINUPD
; UPDATE LINES
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D3/A0
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
LINEPLOT
; PLOT ALL LINES THE CAMERA'S POSITION
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6/A0,-(A7)

            MOVE.W  (NOFLINES),D6
            BEQ     EPLOTLINE   ; If number of lines = 0 we don't enter the loop
            SUBQ.W  #1,D6
            MOVEA.L #0,A0
            MOVE.W  #16,D5
PLOTLINE:
            MOVE.L  LINES(A0),D3    ; FIRST 2 WORDS CONTAINING BGR + CONTROL BITS
            ADDQ.W  #4,A0
            MOVE.L  LINES(A0),D4     ; LAST 2 WORDS CONTAINING X AND Y POSITIONS
            ADDQ.W  #4,A0            ; ABSOLUTE Y POSITION IN D4
            MOVE.W  (CAMPOSY),D2
            SUB.W   D4,D2       ; SCREEN Y POSITION IN D2 (Y0-Y)
            LSR.L   D5,D4      ; ABSOLUTE X POSITION IN D4
            SUB.W   (CAMPOSX),D4   ; SCREEN X POSITION IN D4
            BTST.L  #7,D3
            BNE     DRAW            ; IF BIT D = 1, JUMP TO DRAW
            
            MOVE.B  #86,D0  ; IF NOT DRAWING, MOVE CURSOR
            MOVE.W  D4,D1
            TRAP    #15
            BRA SKIPDRAW
DRAW:
            MOVE.B  #80,D0  ; SET PEN COLOR
            MOVE.L  D3,D1
            LSR.L   #8,D1
            TRAP    #15
            
            MOVE.B  #85,D0  ; DRAW LINE
            MOVE.W  D4,D1
            TRAP    #15
SKIPDRAW:
            DBRA D6,PLOTLINE
EPLOTLINE:
            MOVEM.L (A7)+,D0-D6/A0
            RTS
        
        
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
