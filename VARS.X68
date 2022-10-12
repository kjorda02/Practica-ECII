* ==============================================================================
;                              GAME VARIABLES
* ==============================================================================

;--- SHIP RELATED VARIABLES ----------------------------------------------------

SHIPPOSX    DS.L    1   ; SHIP X COORDINATE [FIXED POINT BB.BB]
SHIPPOSY    DS.L    1   ; SHIP Y COORDINATE
SHIPVELX    DS.W    1   ; SHIP X VELOCITY (IN PX/FRAME) [FIXED POINT B.B]
SHIPVELY    DS.W    1   ; SHIP Y VELOCITY (IN PX/FRAME)
SHIPANGL    DS.B    1   ; SHIP HEADING (O-255)
            DS.W    0

; THE FOLLOWING SHIP VARIABLES ARE NOT REQUIRED SINCE THEY CAN BE CALCULATED
; FROM EXISTING VARIABLES AND CONSTANTS, BUT SINCE WE'LL NEED TO USE THEM
; OFTEN WE CAN AVOID DOING THE CALCULATIONS MORE THAN ONCE THIS WAY
SHIPFROXV    DS.W    1   ; SHIP NOSE 
SHIPFROYV    DS.W    1

SHIPBALXV    DS.W    1   ; SHIP TAIL LEFT POINT
SHIPBALYV    DS.W    1

SHIPBARXV    DS.W    1   ; SHIP TAIL RIGHT POINT
SHIPBARYV    DS.W    1

PROJPOSXV    DS.W    1   ; PROJECTILE X COORDINATE
PROJPOSYV    DS.W    1   ; PROJECTILE Y COORDINATE

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SHIPHLTH    DS.W    1   ; SHIP HEALTH
PLASCORE    DS.W    1   ; PLAYER SCORE


*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
