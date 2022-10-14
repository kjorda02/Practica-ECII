* ==============================================================================
;                                GAME CONSTANTS
* ==============================================================================

; --- SHIP RELATED CONSTANTS ---------------------------------------------------

; COORDINATES OF THE EDGE POINTS OF THE SHIP RELATIVE TO THE CENTER OF THE SHIP
; WHEN IT IS IN ITS STARTING STATE. USING UP AS THE DIRECTION OF GROWING Y
SHIPFROX    EQU 0            ; NOSE OF THE SHIP
SHIPFROY    EQU 16
SHIPBALX    EQU -10          ; LEFT STERN POINT
SHIPBALY    EQU -16
SHIPBARX    EQU 10           ; RIGHT STERN POINT
SHIPBARY    EQU -16

SHIPACC     EQU 2           ; ACC = (1PX/FRAME)/2^SHIPACC
SHIPDECC    EQU 4            ; EVERY FRAME VELCOCITY = PREV_VELOCITY/2^SHIPDECC

SHIPPCOL    EQU $00FFFFFF
SHIPFCOL    EQU $00000000

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
