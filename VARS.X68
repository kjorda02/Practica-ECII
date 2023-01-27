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

TIME        DS.W    1
STTIME      DS.L    1
FRAMES      DS.W    1   ; FRAME COUNTER
FPS         DS.W    1   ; LAST VALUE OF SCRCYCCT
TPS         DS.W    1   ; LAST VALUE OF UPDCYCCT
DEBUG       DS.W    1

                                
; --- MAP RELATED VARIABLES ----------------------------------------------------

; [B G R <DRAW><COLLISION><POSX><POSXUPD><POSY><POSYUPD><START><END> X X Y Y]

LINES       DC.L    $12345600,$026201AE,$AAFF00C2,$029E0244,$00AAFFC0,$03660118,$00AAFFC0,$042E0118,$00AAFFC0,$044C01A4,$00AAFFC0,$044C02D0,$00AAFFC0,$02BC0334
            DC.L    $00AAFFC0,$02580334,$AA00FFC1,$01900140

NOFLINES    DC.W    9

; --- COLLISIOPN RELATED VARIABLES
COLCT       DC.W    1








*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
