*===============================================================================
;                               MAP EDITOR
*===============================================================================

; ------------------------------------------------------------------------------
EDITINIT
; INITIALIZE EDITOR
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (SELVTX)
            CLR.B   (EDITSTAT)     ; SELECT
            RTS
            
; ------------------------------------------------------------------------------
EDITUPD
; UPDATE EDITOR
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; [CTRL,ALT,SHIFT,DOUBLE,MIDDLE,RIGHT,LEFT]
; ------------------------------------------------------------------------------
            MOVE.L  D0,-(A7)

            ; CALCULATE WHERE THE MOUSE'S SCREEN POSITION FALLS ON THE MAP
            MOVE.W  (CAMPOSX),(MOUSPOSXA)
            MOVE.W  (MOUSPOSX),D0
            ADD.W   D0,(MOUSPOSXA)
            
            MOVE.W  (CAMPOSY),(MOUSPOSYA)
            MOVE.W  (MOUSPOSY),D0
            SUB.W   D0,(MOUSPOSYA)
            
            MOVE.L  (A7)+,D0
            RTS
; ------------------------------------------------------------------------------
PANMAP
; ALLOWS MOVING AROUND THE MAP USING RIGHT CLICK BUTTON
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; [CTRL,ALT,SHIFT,DOUBLE,MIDDLE,RIGHT,LEFT]
; ------------------------------------------------------------------------------
            MOVE.L  D0,-(A7)
            
            TST.B   (MOUSBUSY)
            BEQ     .NOBUSY
            BTST.B  #0,(MOUSBUSY)
            BEQ     .ENDPAN
.NOBUSY:

            BTST.B  #1,(MOUSEDGE)
            BEQ     .NOEDGE
            BTST.B  #1,(MOUSVAL)
            BEQ     .PANBUP
            
.PANBDOWN:                          ; BUTTON WAS JUST PRESSED DOWN
            MOVE.W  (MOUSPOSX),(POINT1X)
            MOVE.W  (MOUSPOSY),(POINT1Y)
            
            MOVE.W  (CAMPOSX),(CAMPOS1X)
            MOVE.W  (CAMPOSY),(CAMPOS1Y)
            BSET.B  #0,(MOUSBUSY)
            BRA     .ENDPAN
.PANBUP:                            ; BUTTON WAS LET GO
            CLR.B   (MOUSBUSY)
            BRA     .ENDPAN
.NOEDGE:
            BTST.B  #1,(MOUSVAL)
            BEQ     .ENDPAN
                                    ; BUTTON WAS ALREADY PRESSED
            MOVE.W  (POINT1X),D0
            SUB.W   (MOUSPOSX),D0
            ADD.W   (CAMPOS1X),D0
            MOVE.W  D0,(CAMPOSX)
            
            MOVE.W  (MOUSPOSY),D0
            SUB.W   (POINT1Y),D0
            ADD.W   (CAMPOS1Y),D0
            MOVE.W  D0,(CAMPOSY)
            
.ENDPAN:
            MOVE.L  (A7)+,D0
            RTS
            
            
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
