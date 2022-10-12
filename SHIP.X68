*===============================================================================
;                                SHIP MANAGEMENT
*===============================================================================

; ------------------------------------------------------------------------------
SHIPINIT
; INITIALIZE SHIP.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    MOVE.W  #SCRHEIGH/2,(SHIPPOSY)
    MOVE.W  #SCRWIDTH/2,(SHIPPOSX)
    RTS
            
; ------------------------------------------------------------------------------
SHIPUPD
; UPDATES THE SHIP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    ADD.W   #1,(SHIPPOSX)
    RTS

; ------------------------------------------------------------------------------
SHIPPLOT
; PLOT THE SHIP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

    ; SET CONTOUR COLOR
    MOVE.W  #80,D0
    MOVE.L  #SHIPPCOL,D1
    TRAP    #15
    
    ; SET FILL COLOR
    MOVE.W  #81,D0
    MOVE.L  #SHIPFCOL,D1
    TRAP    #15
    
    ; SET CURSOR AT THE NOSE OF THE SHIP
    MOVE.W  #86,D0
    MOVE.W  (SHIPPOSX),D1
    MOVE.W  (SHIPPOSY),D2
    SUB.W   #SHIPNOSE,D2
    TRAP    #15
    
    ; SET THE CURSOR AT RIGHT BOTTOM VERTEX OF THE SHIP AND DRAW 1ST LINE
    MOVE.W  #85,D0
    ADD.W   #SHIPNOSE+SHIPTAIL,D2
    ADD.W   #SHIPWIDT,D1
    TRAP    #15
    
    ; SET THE CURSOR AT LEFT BOTTOM VERTEX OF THE SHIP AND DRAW 2ND LINE
    MOVE.W  #85,D0
    SUB.W   #SHIPWIDT*2,D1
    TRAP    #15
    
    ; SET CURSOR BACK AT NOSE POSITION AND DRAW 3RD LINE
    MOVE.W  #85,D0
    MOVE.W  (SHIPPOSX),D1
    MOVE.W  (SHIPPOSY),D2
    SUB.W   #SHIPNOSE,D2
    TRAP    #15
    
    RTS
    
    
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
