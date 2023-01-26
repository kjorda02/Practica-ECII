* ==============================================================================
;                              GAME VARIABLES
* ==============================================================================

;--- SHIP RELATED VARIABLES ----------------------------------------------------

SHPOSX      DS.L    1   ; X-COORDINATE*2^16 [FIXED POINT BB.BB]
SHPOSY      DS.L    1
SHVELX      DS.L    1   ; X-VELOCITY*2^16 [FIXED POINT BB.BB] (IN PX/FRAME) 
SHVELY      DS.L    1
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
FRAMES      DS.W    1   ; FRAME COUNTER
FPS         DS.W    1   ; LAST VALUE OF SCRCYCCT
TPS         DS.W    1   ; LAST VALUE OF UPDCYCCT

                                
; --- MAP RELATED VARIABLES ----------------------------------------------------

;LINES       DC.L    $FFFFFF00,$026201AE,$FFFFFFC0,$029E0244,$AA00FFC0,$03660118,$FFAA00C0,$042E0118,$AAFF00C0,$044C01A4,$0000FFC0,$044C02D0,$00AAFFC0,$02BC0334
;            DC.L    $FFAAAAC0,$02580334,$FFAAAAC0,$01900140

LINES       DC.L    $FF000000,$026201AE,$FF0000C0,$029E0244,$FF0000C0,$03660118,$FF0000C0,$042E0118,$FF0000C0,$044C01A4,$FF0000C0,$044C02D0,$FF0000C0,$02BC0334
            DC.L    $FF0000C0,$02580334,$FF0000C0,$01900140

NOFLINES    DC.W    9

; --- COLLISIOPN RELATED VARIABLES
COLCT       DC.W    1







*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
