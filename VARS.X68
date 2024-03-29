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
CROSSED     DS.L    1   ; IF CROSSED THE START LINE MORE THAN ONCE THE TIME IS NOT VALID
FRAMES      DS.W    1   ; FRAME COUNTER
FPS         DS.W    1   ; LAST VALUE OF SCRCYCCT
TPS         DS.W    1   ; LAST VALUE OF UPDCYCCT
DEBUG       DS.W    1

                                
; --- MAP RELATED VARIABLES ----------------------------------------------------

; [B G R <DRAW><COLLISION><POSX><POSXUPD><POSY><POSYUPD><START><END> X X Y Y]
; (ONE LINE IS 8 BYTES = 2 LONGS)

; MAX LINE LENGTH: 1023
LINES       DC.L    $12345600,$001E0064,$0000FFC1,$001EFF9C,$12345600,$0028FF9C,$00FF00C2,$00280064,$00AAFFC0,$02800064
            DC.L    $00AAFFC0,$041EFFF8,$00AAFFC0,$04BFFE27,$00AAFFC0,$03D3FD19,$00AAFFC0,$0110FD48,$00AAFFC0,$FE52FE11
            DC.L    $00AAFFC0,$FDD3FF8F,$00AAFFC0,$00280064,$12345600,$0028FF9C,$00AAFFC0,$021CFF9C,$00AAFFC0,$03A0FF40
            DC.L    $00AAFFC0,$03D8FE38,$00AAFFC0,$036BFDF8,$00AAFFC0,$0149FE1C,$00AAFFC0,$FEFCFE9B,$00AAFFC0,$FF50FF55
            DC.L    $00AAFFC0,$0028FF9C

NOFLINES    DC.W    21

; --- COLLISIOPN RELATED VARIABLES
COLCT       DC.W    1

; --- EDITOR RELATED VARIABLES
EDITMODE    DC.W    1   ; 0 = GAME MODE, 1 = EDITOR MODE
SELVTX      DC.W    1   ; SELECTED VERTEX
EDITSTAT    DC.B    1   ; LEAST SIGNIFICANT BITS: <SELECT><MOVE_VERTEX><NEW_VERTEX>

MOUSPOSXA   DC.W    1   ; ABSOLUTE POSITION OF MOUSE ON THE MAP,
MOUSPOSYA   DC.W    1   ; NOT DEPENDENT ON THE CAMERA'S POSITION

POINT1X     DC.W    1   ; STORES THE INITIAL POSITION WHEN CLICKING AND HOLDING MOUSE
POINT1Y     DC.W    1

CAMPOS1X    DC.W    1   ; CAMERA POSITION AT THE MOMENT WHEN RIGHT MOUSE BUTTON WAS PRESSED
CAMPOS1Y    DC.W    1   ; IS NECESSARY TO PAN THE MAP WITH THE MOUSE

MOUSBUSY    DC.B    1   ; INDICATES IF SOMETHING IS USING THE MOUSE.
                        ; LEAST SIGNIFICANT BITS: <PLACE_VERTEX><SELECT><PANNING>
                        
            DS.W        1









*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
