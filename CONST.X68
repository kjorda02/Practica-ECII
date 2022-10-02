* ==============================================================================
;                                GAME CONSTANTS
* ==============================================================================

; --- SHIP RELATED CONSTANTS ---------------------------------------------------

; THE SHIP WILL BE A TRIANGLE, THE SHAPE OF THE TRIANGLE WILL BE DEFINED BY THE
; FOLLOWING CONSTANTS
SHIPNOSE    EQU 8           ; DISTANCE FROM THE CENTER TO THE NOSE
SHIPTAIL    EQU 8           ; DISTANCE FROM THE CENTER TO THE TAIL
SHIPWIDT    EQU 3           ; HORIZONTAL DISTANCE FROM CENTER TO BASE VERTEX

SHIPPCOL    EQU $00FFFFFF
SHIPFCOL    EQU $00000000

SHIPACC     EQU 1           ; SHIP ACCELERATION IF KEY PRESSED (IN PX/(FRAME^2))

; --- PROJECTILE RELATED CONSTANTS

PROJVEL     EQU 3           ; PROJECTILE VELOCITY (IN PX/FRAME)
PROJCOL     EQU $00FFFFFF

; --- SCOREBOARD RELATED CONSTANTS ---------------------------------------------

SCOFCOL     EQU $00000000   ; TEXT BACKGROUND COLOR
SCOLINE1    EQU $0101       ; FIRST TEXT LINE COORDINATES
SCOLINE2    EQU $0102       ; SECOND TEXT LINE COORDINATES

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
