* ==============================================================================
;                                SYSTEM VARIABLES
* ==============================================================================

; --- KEYBOARD RELATED VARIABLES -----------------------------------------------
; [e|a|x|t|DOWN|RIGHT|UP|LEFT]

KBDVAL      DS.B    1   ; KEY STATE
KBDEDGE     DS.B    1   ; KEY EDGE

; --- MOUSE REALTED VARIABLES

MOUSVAL     DS.B    1 
MOUSEDGE    DS.B    1
MOUSPOSX    DS.W    1
MOUSPOSY    DS.W    1

; --- SCREEN INTERRUPT RELATED VARIABLES ---------------------------------------
;[CTRL,ALT,SHIFT,DOUBLE,MIDDLE,RIGHT,LEFT]
SCRINTCT    DS.W    1   ; SCREEN INTERRUPT COUNTER
SCRCYCCT    DS.W    1   ; SCREEN CYCLE COUNTER

UPDINTCT    DS.W    1   ; UPDATE INTERRUPT COUNTER
UPDCYCCT    DS.W    1   ; UPDATE CYCLE COUNTER

UPDATED     DS.W    1   ; AVOIDS DRAWING 2 FRAMES WITHOUT UPDATE


*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
