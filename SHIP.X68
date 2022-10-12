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
    CLR.W   (SHIPVELX)
    CLR.W   (SHIPVELY)
    RTS
            
; ------------------------------------------------------------------------------
SHIPUPD
; UPDATES THE SHIP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        
        ; UPDATE THE VELOCITY BASED ON THE KEYS CURRENTLY PRESSED
        MOVE.B  (KBDVAL),D0
        BTST.L  #3,D0   ; TEST DOWN KEY
        BEQ RIGHT
        ADDQ.W  #1,(SHIPVELY)
        
RIGHT:  BTST.L  #2,D0   ; TEST RIGHT KEY
        BEQ UP
        ADDQ.W  #1,(SHIPVELX)

UP:     BTST.L  #1,D0   ; TEST UP KEY
        BEQ LEFT
        SUBQ.W  #1,(SHIPVELY)
        
LEFT:   BTST.L  #0,D0   ; TEST LEFT KEY
        BEQ END
        SUBQ.W  #1,(SHIPVELX)
END:

        ; UPDATE THE POSITION BASED ON THE VELOCITY
        MOVE.W  (SHIPVELX),D0
        ADD.W   D0,(SHIPPOSX)
        MOVE.W  (SHIPVELY),D0
        ADD.W   D0,(SHIPPOSY)
        
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
