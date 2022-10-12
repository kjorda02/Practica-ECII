* ==============================================================================
;                              GAME VARIABLES
* ==============================================================================

;--- SHIP RELATED VARIABLES ----------------------------------------------------

SHIPPOSX    DS.W    1   ; SHIP X COORDINATE
SHIPPOSY    DS.W    1   ; SHIP Y COORDINATE
SHIPVELX    DS.W    1   ; SHIP X VELOCITY (IN PX/FRAME)
SHIPVELY    DS.W    1   ; SHIP Y VELOCITY (IN PX/FRAME)
SHIPANGL    DS.W    1   ; SHIP HEADING (O-255)

; THE FOLLOWING SHIP VARIABLES ARE NOT REQUIRED SINCE THEY CAN BE CALCULATED
; FROM EXISTING VARIABLES AND CONSTANTS, BUT SINCE WE'LL NEED TO USE THEM
; OFTEN WE CAN AVOID DOING THE CALCULATIONS MORE THAN ONCE THIS WAY
SHIPFROX    DS.W    1   ; SHIP NOSE 
SHIPFROY    DS.W    1

SHIPBALX    DS.W    1   ; SHIP TAIL LEFT POINT
SHIPBALY    DS.W    1

SHIPBARX    DS.W    1   ; SHIP TAIL RIGHT POINT
SHIPBARY    DS.W    1

PROJPOSX    DS.W    1   ; PROJECTILE X COORDINATE
PROJPOSY    DS.W    1   ; PROJECTILE Y COORDINATE

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SHIPHLTH    DS.W    1   ; SHIP HEALTH
PLASCORE    DS.W    1   ; PLAYER SCORE

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
