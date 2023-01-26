* ==============================================================================
;                                GAME CONSTANTS
* ==============================================================================

; --- SHIP RELATED CONSTANTS ---------------------------------------------------

; COORDINATES OF THE EDGE POINTS OF THE SHIP RELATIVE TO THE CENTER OF THE SHIP
; WHEN IT IS IN ITS STARTING STATE. USING UP AS THE DIRECTION OF GROWING Y
SHFRONTXC   EQU 0           ; NOSE OF THE SHIP
SHFRONTYC   EQU 20
SHBACKLXC   EQU -10         ; LEFT STERN POINT
SHBACKLYC   EQU -12
SHBACKRXC   EQU 10          ; RIGHT STERN POINT
SHBACKRYC   EQU -12

SHIPACC     EQU 7           ; ACC=2^(SHIPACC-8) PX/TICK
SHAVEL      EQU 5           ; ANGULAR VELOCITY WHEN KEY PRESSED=SHAVEL*(360/255)
SHDECC      EQU 5           ; EVERY TICK VELOCITY = PREV_VELOCITY*(1-(2^-SHIPDECC))
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
SCOLINE3    EQU $0103       ; THIRD TEXT LINE COORDINATES

; --- COLLISION RELATED CONSTANTS ----------------------------------------------
CRADSQ      EQU 25          ; CORNER RADIUS SQUARED: CORNER RADIUS IS THE MAXIMUM 
                            ; DISTANCE FROM AN EDGEPOINT THAT WILL RESULT IN A COLLISION
                            ; INVERTING THE VELOCITY INSTEAD OF REFLECTING IT ON THE LINE






*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
