* ==============================================================================
;                                GAME CONSTANTS
* ==============================================================================

; --- SHIP RELATED CONSTANTS ---------------------------------------------------

; COORDINATES OF THE EDGE POINTS OF THE SHIP RELATIVE TO THE CENTER OF THE SHIP
; WHEN IT IS IN ITS STARTING STATE. USING UP AS THE DIRECTION OF GROWING Y
SHFRONTXC   EQU 0            ; NOSE OF THE SHIP
SHFRONTYC   EQU 16
SHBACKLXC   EQU -10          ; LEFT STERN POINT
SHBACKLYC   EQU -16
SHBACKRXC   EQU 10           ; RIGHT STERN POINT
SHBACKRYC   EQU -16

;SHIPACC    EQU 1           ; ACC = (1PX/FRAME)/2^SHIPACC
SHDECC      EQU 5           ; EVERY FRAME VELCOCITY = PREV_VELOCITY*(1-(2^-SHIPDECC))
; TERMINAL VELOCITY = ACC*2^SHIPDECC

SHPCOL      EQU $00FFFFFF
SHFCOL      EQU $00000000

; --- PROJECTILE RELATED CONSTANTS

PROJVEL     EQU 3           ; PROJECTILE VELOCITY (IN PX/FRAME)
PROJCOL     EQU $00FFFFFF

; --- SCOREBOARD RELATED CONSTANTS ---------------------------------------------

SCOFCOL     EQU $00000000   ; TEXT BACKGROUND COLOR
SCOLINE1    EQU $0101       ; FIRST TEXT LINE COORDINATES
SCOLINE2    EQU $0102       ; SECOND TEXT LINE COORDINATES

; --- MAP RELATED CONSTANTS ----------------------------------------------------
MAPSIZE     EQU $1000       ; Max number of objects (sizeOf = MAPSIZE*(3words/obj))




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
