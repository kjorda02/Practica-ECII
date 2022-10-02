* ==============================================================================
;                            SCOREBOARD MANAGEMENT
* ==============================================================================

; ------------------------------------------------------------------------------
SCOINIT
; INITIALIZE THE SCOREBOARD
; INPUT    :
; OUTPUT   :
; MODIFIES :
; ------------------------------------------------------------------------------
    CLR.W   (PLASCORE)
    MOVE.W  #100,(SHIPHLTH)
    RTS
            
; ------------------------------------------------------------------------------
SCOUPD
; UPDATES THE SCOREBOARD
; INPUT    :
; OUTPUT   :
; MODIFIES :
; ------------------------------------------------------------------------------
    RTS

; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE SCOREBOARD
; INPUT    :
; OUTPUT   :
; MODIFIES :
; ------------------------------------------------------------------------------
    
    MOVEM.L D0-D1/A1,-(A7)  ; SAVE REGISTER VALUES
    
    ; SET BACKGROUND COLOR
    MOVE.B  #81,D0
    MOVE.W  #SCOFCOL,D1
    TRAP    #15
    
    ; SET CURSOR POSITION FOR LINE 1
    MOVE.B  #11,D0
    MOVE.W  #SCOLINE1,D1
    TRAP    #15
    
    ; PRINT FIRST LINE
    LEA     .TXT1,A1
    CLR.L   D1
    MOVE.W  (PLASCORE),D1
    MOVE.B  #17,D0
    TRAP    #15
    
    ; SET CURSOR POSITION FOR LINE 1
    MOVE.B  #11,D0
    MOVE.W  #SCOLINE2,D1
    TRAP    #15
    
    ; PRINT SECOND LINE
    LEA     .TXT2,A1
    CLR.L   D1
    MOVE.W  (SHIPHLTH),D1
    MOVE.B  #17,D0
    TRAP    #15
    
    MOVEM.L (A7)+,D0-D1/A1  ; RESTORE PREVIOUS REGISTER VALUES
    
    RTS

.TXT1   DC.B    'SCORE: ',0
.TXT2   DC.B    'HEALTH: ',0

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
