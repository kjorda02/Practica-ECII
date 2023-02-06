*===============================================================================
;                               EDITOR MENU
*===============================================================================

; ------------------------------------------------------------------------------
MENUINIT
; INITIALIZE EDITOR MENU
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        
            RTS
        
; ------------------------------------------------------------------------------
MENUUPD
; UPDATE EDITOR MENU
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ; TURN ON EDIT MODE
            BTST.B  #4,(KBDEDGE)
            BEQ .EDIT1
            BTST.B  #4,(KBDVAL)
            BEQ .EDIT1
            MOVE.W  #0,(EDITMODE)
.EDIT1: 
            RTS
            
; ------------------------------------------------------------------------------
MENUPLOT
; UPDATE EDITOR MENU
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ; DRAW BACKGROUND RECTANGLE
            MOVE.W  #120,D1
            MOVE.W  #10,D2
            MOVE.W  #1000,D3
            MOVE.W  #100,D4
            MOVE.W  #87,D0
            TRAP    #15
            
            ; MOVE CURSOR
            MOVE.B  #11,D0
            MOVE.W  #$1401,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .INFO1,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            ; MOVE CURSOR
            MOVE.B  #11,D0
            MOVE.W  #$3001,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .INFO2,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            ; MOVE CURSOR
            MOVE.B  #11,D0
            MOVE.W  #$4C01,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .INFO3,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            ; MOVE CURSOR
            MOVE.B  #11,D0
            MOVE.W  #$6001,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .INFO4,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            ; MOVE CURSOR
            MOVE.B  #11,D0
            MOVE.W  #$1005,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .INFO5,A1
            MOVE.W  (MOUSPOSXA),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; MOVE CURSOR
            MOVE.B  #11,D0
            MOVE.W  #$1A05,D1
            TRAP    #15
            
            ; PRINT INFO
            LEA     .INFO6,A1
            MOVE.W  (MOUSPOSYA),D1
            EXT.L   D1
            MOVE.B  #17,D0
            TRAP    #15

            RTS

.INFO1      DC.B    '(t) Toggle editor mode',0
.INFO2      DC.B    '(x) Delete last vertex',0
.INFO3      DC.B    '(a) New vertex',0
.INFO4      DC.B    '(e) Move selected vertex',0
.INFO5      DC.B    'X: ',0
.INFO6      DC.B    'Y: ',0
            DS.W    1
            
            
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
