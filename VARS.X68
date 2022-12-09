* ==============================================================================
;                              GAME VARIABLES
* ==============================================================================

;--- SHIP RELATED VARIABLES ----------------------------------------------------

SHPOSX      DS.L    1   ; SHIP X COORDINATE [FIXED POINT BB.BB]
SHPOSY      DS.L    1   ; SHIP Y COORDINATE
SHVELX      DS.L    1   ; SHIP X VELOCITY (IN PX/FRAME) [FIXED POINT B.B]
SHVELY      DS.L    1   ; SHIP Y VELOCITY (IN PX/FRAME)
SHANGL      DS.B    1   ; SHIP HEADING (O-255)
            DS.W    0

; THE FOLLOWING SHIP VARIABLES ARE NOT REQUIRED SINCE THEY CAN BE CALCULATED
; FROM EXISTING VARIABLES AND CONSTANTS, BUT SINCE WE'LL NEED TO USE THEM
; OFTEN WE CAN AVOID DOING THE CALCULATIONS MORE THAN ONCE THIS WAY
SHFRONTX    DS.W    1   ; SHIP NOSE 
SHFRONTY    DS.W    1

SHBACKLX    DS.W    1   ; SHIP TAIL LEFT POINT
SHBACKLY    DS.W    1

SHBACKRX    DS.W    1   ; SHIP TAIL RIGHT POINT
SHBACKRY    DS.W    1

PROJPOSX    DS.W    1   ; PROJECTILE X COORDINATE
PROJPOSY    DS.W    1   ; PROJECTILE Y COORDINATE

CAMPOSX     DS.W    1   ; CAMERA POSITION
CAMPOSY     DS.W    1

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SHIPHLTH    DS.W    1   ; SHIP HEALTH
PLASCORE    DS.W    1   ; PLAYER SCORE

; --- MAP RELATED VARIABLES ----------------------------------------------------

MAP         DS.W    MAPSIZE    ; HOLDS POSITION, VELOCITY AND POINTER TO THE
                                ; TYPE OF OBJECT FOR ALL OBJECTS IN THE MAP




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
