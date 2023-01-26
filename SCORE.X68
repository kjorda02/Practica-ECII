* ==============================================================================
;                            SCOREBOARD MANAGEMENT
* ==============================================================================

; ------------------------------------------------------------------------------
SCOINIT
; INITIALIZE THE SCOREBOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
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
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D1/A1
; ------------------------------------------------------------------------------
    
            MOVEM.L D0-D1/A1,-(A7)  ; SAVE REGISTER VALUES
    
            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #SCOFCOL,D1
            TRAP    #15
    
            ; SET CURSOR POSITION FOR LINE 1
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE1,D1
            TRAP    #15
    
            ; PRINT FIRST LINE
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.L  (COLCT),D1
            MOVE.W  #16,D0
            ASR.L   D0,D1
            MOVE.B  #17,D0
            TRAP    #15
            CLR.L   D1
    
            ; SET CURSOR POSITION FOR LINE 2
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE2,D1
            TRAP    #15
    
            ; PRINT SECOND LINE
            LEA     .TXT2,A1
            MOVE.W  (TPS),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 3
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE3,D1
            TRAP    #15
            
            ; PRINT THIRD LINE
            LEA     .TXT3,A1
            MOVE.W  (FPS),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 4
            MOVE.B  #11,D0
            MOVE.W  #$0104,D1
            TRAP    #15
            
            ; PRINT FOURTH LINE
            LEA     .TXT4,A1
            CLR.L   D1
            MOVE.W  (SHVELX),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 5
            MOVE.B  #11,D0
            MOVE.W  #$0105,D1
            TRAP    #15
            
            ; PRINT FIFTH LINE
            LEA     .TXT5,A1
            CLR.L   D1
            MOVE.W  (SHVELY),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 6
            MOVE.B  #11,D0
            MOVE.W  #$0106,D1
            TRAP    #15
            
            ; PRINT SIXTH LINE
            LEA     .TXT6,A1
            CLR.L   D1
            MOVE.W  (SHPOSX),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 7
            MOVE.B  #11,D0
            MOVE.W  #$0107,D1
            TRAP    #15
            
            ; PRINT SEVENTH LINE
            LEA     .TXT7,A1
            CLR.L   D1
            MOVE.W  (SHPOSY),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
    
            MOVEM.L (A7)+,D0-D1/A1  ; RESTORE PREVIOUS REGISTER VALUES
    
            RTS

.TXT1       DC.B    'COLLISION COUNTER: ',0
.TXT2       DC.B    'TPS: ',0
.TXT3       DC.B    'FPS: ',0

.TXT4       DC.B    'VELX: ',0
.TXT5       DC.B    'VELY: ',0
.TXT6       DC.B    'POSX: ',0
.TXT7       DC.B    'POSY: ',0




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
