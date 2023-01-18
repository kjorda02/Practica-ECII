* ==============================================================================
;                                SYSTEM VARIABLES
* ==============================================================================

; --- KEYBOARD RELATED VARIABLES -----------------------------------------------
; [PAUSE|FIRE3|FIRE2|FIRE1|DOWN|RIGHT|UP|LEFT]

KBDVAL      DS.B    1   ; KEY STATE
KBDEDGE     DS.B    1   ; KEY EDGE

; --- SCREEN INTERRUPT RELATED VARIABLES ---------------------------------------

SCRINTCT    DS.W    1   ; SCREEN INTERRUPT COUNTER
SCRCYCCT    DS.W    1   ; SCREEN CYCLE COUNTER

UPDINTCT    DS.W    1   ; UPDATE INTERRUPT COUNTER
UPDCYCCT    DS.W    1   ; UPDATE CYCLE COUNTER
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
