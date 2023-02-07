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
            CLR.W   (DEBUG)
            CLR.L   (STTIME)
            CLR.W   (TIME)
            CLR.W   (CROSSED)
            CLR.W   (EDITMODE)
            
            RTS
            
; ------------------------------------------------------------------------------
SCOUPD
; UPDATES THE SCOREBOARD
; INPUT    :
; OUTPUT   :
; MODIFIES :
; ------------------------------------------------------------------------------
            ; UPDATE TIME
            TST.L   (STTIME)
            BEQ .NOUTIME        ; IF WE HAVEN'T STARTED COUNTING, TIME= 0
            MOVE.B  #8,D0
            TRAP    #15
            SUB.L   (STTIME),D1
            MOVE.W  D1,(TIME)
            
.NOUTIME:
            ; TOGGLE DEBUG
            BTST.B  #5,(KBDEDGE)
            BEQ     .NOTDEBUG
            BTST.B  #5,(KBDVAL)
            BEQ     .NOTDEBUG
            
            TST.W   (DEBUG)
            BNE     .DEBUG0
            MOVE.W  #1,(DEBUG)
            BRA     .NOTDEBUG
.DEBUG0     CLR.W   (DEBUG)
.NOTDEBUG   

            ; TURN ON EDIT MODE
            BTST.B  #4,(KBDEDGE)
            BEQ .EDIT0
            BTST.B  #4,(KBDVAL)
            BEQ .EDIT0
            MOVE.W  #1,(EDITMODE)
.EDIT0:
            RTS

; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE CURRENT TIME TAKEN AND SOME INFO
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D1/A1
; ------------------------------------------------------------------------------
            ; SET CURSOR POSITION LINE 1
            MOVE.B  #11,D0
            MOVE.W  #$0107,D1
            TRAP    #15
            
            ; PRINT TIME
            LEA     .TIME,A1
            MOVE.W  (TIME),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION LINE 1 COL 32
            MOVE.B  #11,D0
            MOVE.W  #$1401,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .EDIT,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            ; SET CURSOR POSITION LINE 1 COL 32
            MOVE.B  #11,D0
            MOVE.W  #$3001,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .DEBUG,A1
            MOVE.B  #14,D0
            TRAP    #15

            RTS
            
.TIME       DC.B    'TIME: ',0
.EDIT       DC.B    '(t) Toggle editor mode',0
.DEBUG      DC.B    '(x) Toggle debug info',0
            DS.W        0

; ------------------------------------------------------------------------------
FPSPLOT
; PLOT THE FPS AND TPS
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D1/A1
; ------------------------------------------------------------------------------

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #SCOFCOL,D1
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$0101,D1
            TRAP    #15
            
            ; PRINT GOAL TPS
            LEA     .GTPS,A1
            MOVE.W  #UPDTPS,D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$0102,D1
            TRAP    #15
            
            ; PRINT FPS
            LEA     .GFPS,A1
            MOVE.W  #SCRFPS,D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$0104,D1
            TRAP    #15
    
            ; PRINT TPS
            LEA     .TPS,A1
            MOVE.W  (TPS),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$0105,D1
            TRAP    #15
            
            ; PRINT FPS
            LEA     .FPS,A1
            MOVE.W  (FPS),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            RTS

.GTPS       DC.B    'GOAL TPS: ',0
.GFPS       DC.B    'GOAL FPS: ',0
            
.TPS        DC.B    'TPS: ',0
.FPS        DC.B    'FPS: ',0
            DS.W        0
; ------------------------------------------------------------------------------
DEBGPLOT
; DEBUG PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D1/A1
; ------------------------------------------------------------------------------
    
            MOVEM.L D0-D1/A1,-(A7)  ; SAVE REGISTER VALUES
    
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$0109,D1
            TRAP    #15
    
            ; PRINT COLCT
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.W  (COLCT),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$010A,D1
            TRAP    #15
            
            ; PRINT SHVELX
            LEA     .TXT4,A1
            CLR.L   D1
            MOVE.W  (SHVELX),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$010B,D1
            TRAP    #15
            
            ; PRINT SHVELY
            LEA     .TXT5,A1
            CLR.L   D1
            MOVE.W  (SHVELY),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$010C,D1
            TRAP    #15
            
            ; PRINT SHPOSX
            LEA     .TXT6,A1
            CLR.L   D1
            MOVE.W  (SHPOSX),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$010D,D1
            TRAP    #15
            
            ; PRINT SHPOSY
            LEA     .TXT7,A1
            CLR.L   D1
            MOVE.W  (SHPOSY),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION
            MOVE.B  #11,D0
            MOVE.W  #$010E,D1
            TRAP    #15
            
            ; PRINT SHPOSY
            LEA     .TXT8,A1
            CLR.L   D1
            MOVE.W  (CROSSED),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
    
            MOVEM.L (A7)+,D0-D1/A1  ; RESTORE PREVIOUS REGISTER VALUES
    
            RTS

.TXT1       DC.B    'COLLISION COUNTER: ',0
.TXT4       DC.B    'VELX: ',0
.TXT5       DC.B    'VELY: ',0
.TXT6       DC.B    'POSX: ',0
.TXT7       DC.B    'POSY: ',0
.TXT8       DC.B    'CROSSED: ',0







*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
