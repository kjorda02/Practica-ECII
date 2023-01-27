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
            MOVE.B  #8,D0
            TRAP    #15
            MOVE.L  D1,(STTIME)
            
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

            RTS

; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE FPS AND TPS
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D1/A1
; ------------------------------------------------------------------------------
            ; SET CURSOR POSITION LINE 1
            MOVE.B  #11,D0
            MOVE.W  #$0104,D1
            TRAP    #15
            
            ; PRINT TIME
            LEA     .TIME,A1
            MOVE.W  (TIME),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION LINE 1 COL 32
            MOVE.B  #11,D0
            MOVE.W  #$2001,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .EDIT,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            ; SET CURSOR POSITION LINE 1 COL 32
            MOVE.B  #11,D0
            MOVE.W  #$2002,D1
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
            
            ; SET CURSOR POSITION LINE 1
            MOVE.B  #11,D0
            MOVE.W  #$0101,D1
            TRAP    #15
    
            ; PRINT FPS
            LEA     .TPS,A1
            MOVE.W  (TPS),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 2
            MOVE.B  #11,D0
            MOVE.W  #$0102,D1
            TRAP    #15
            
            ; PRINT TPS
            LEA     .FPS,A1
            MOVE.W  (FPS),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            RTS
            
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
    
            ; SET CURSOR POSITION FOR LINE 6
            MOVE.B  #11,D0
            MOVE.W  #$0106,D1
            TRAP    #15
    
            ; PRINT COLCT
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.W  (COLCT),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 7
            MOVE.B  #11,D0
            MOVE.W  #$0107,D1
            TRAP    #15
            
            ; PRINT SHVELX
            LEA     .TXT4,A1
            CLR.L   D1
            MOVE.W  (SHVELX),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 8
            MOVE.B  #11,D0
            MOVE.W  #$0108,D1
            TRAP    #15
            
            ; PRINT SHVELY
            LEA     .TXT5,A1
            CLR.L   D1
            MOVE.W  (SHVELY),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 9
            MOVE.B  #11,D0
            MOVE.W  #$0109,D1
            TRAP    #15
            
            ; PRINT SHPOSX
            LEA     .TXT6,A1
            CLR.L   D1
            MOVE.W  (SHPOSX),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET CURSOR POSITION FOR LINE 10
            MOVE.B  #11,D0
            MOVE.W  #$010A,D1
            TRAP    #15
            
            ; PRINT SHPOSY
            LEA     .TXT7,A1
            CLR.L   D1
            MOVE.W  (SHPOSY),D1
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






*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
