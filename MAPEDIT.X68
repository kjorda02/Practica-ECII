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
            CLR.W   (EDITSTAT)     ; SELECT
            CLR.W   (MOUSPOS1X)
            CLR.W   (MOUSPOS1Y)
            RTS
            
; ------------------------------------------------------------------------------
EDITUPD
; UPDATE EDITOR
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; [CTRL,ALT,SHIFT,DOUBLE,MIDDLE,RIGHT,LEFT]
; ------------------------------------------------------------------------------
            
            RTS
            
; ------------------------------------------------------------------------------
PANMAP
; ALLOWS MOVING AROUND THE MAP USING RIGHT CLICK BUTTON
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; [CTRL,ALT,SHIFT,DOUBLE,MIDDLE,RIGHT,LEFT]
; ------------------------------------------------------------------------------
            BTST.B  #1,(MOUSEDGE)
            BEQ     .ENDPAN
            BTST.B  #1,(MOUSVAL)
            BEQ     .PANBUP
.PANBDOWN:                          ; BUTTON WAS PRESSED DOWN
            MOVE.W  (MOUSPOSX),(MOUSPOS1X)
            MOVE.W  (MOUSPOSY),(MOUSPOS1Y)
            BRA     .ENDPAN
.PANBUP:                            ; BUTTON WAS LET GO
    
.ENDPAN:
            RTS
            
            
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
