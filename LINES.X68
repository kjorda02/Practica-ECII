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
LINPLOT
; PLOT ALL LINES THE CAMERA'S POSITION
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D2
; ------------------------------------------------------------------------------
            MOVE.W  (NOFLINES),D7
            BEQ     EPLOTLINE   ; If number of lines = 0 we don't enter the loop
            SUBQ.W  #1,D7
            MOVEA.L #LINES,A0
PLOTLINE:
            


            DBRA D7,PLOTLINE
EPLOTLINE:
        
        
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
