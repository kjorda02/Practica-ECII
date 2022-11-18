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
            CLR.B   SHANGL
            MOVE.W  #SCRHEIGH/2,(SHPOSY) ; Intialize ship at center of screen
            MOVE.W  #SCRWIDTH/2,(SHPOSX)
            RTS
            
; ------------------------------------------------------------------------------
SHIPUPD
; UPDATES THE SHIP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D3/A0
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3/A0,-(A7)

            ; UPDATE THE POSITION BASED ON THE VELOCITY
            MOVE.L  (SHVELX),D0
            ADD.L   D0,(SHPOSX)
            MOVE.L  (SHVELY),D0
            ADD.L   D0,(SHPOSY)
        
            ; SLOW DOWN THE SHIP
            MOVE.L  (SHVELX),D0
            MOVE.L  (SHVELY),D1
            ASR.L   #SHDECC,D0
            ASR.L   #SHDECC,D1
        
            SUB.L   D0,(SHVELX)
            SUB.L   D1,(SHVELY)
        
            CLR.L   D0  ; IMPORTANTE
            CLR.L   D1
        
            ; CALCULATE THE POSITION OF THE EDGE POINTS BASED ON THE CENTER POSITION
            ; AND ANGLE (USING THE ROTATION MATRIX AND SINE TABLE)
            MOVE.B  (SHANGL),D0
            MULU    #2,D0               ; IMPORTANTE
            MOVE.W  D0,A0
            MOVE.W  RCTSINTB(A0),D0     ; SIN(SHIPANGL)*2^8
            MOVE.W  RCTCOSTB(A0),D1     ; COS(SHIPANGL)*2^8
        
            ; NOSE POINT (SHIPFROXV AND SHIPFROYV)
            MOVE.W  D0,D2
            NEG.W   D2                  ; -SIN
            MULS    #SHFRONTYC,D2        ; Y*-SIN(SHIPANGL)*2^8
            ASL.L   #8,D2               ; Y*-SIN(SHIPANGL)*2^^16
            ADD.L   (SHPOSX),D2
            ASR.L   #8,D2
            ASR.L   #8,D2
            MOVE.W  D2,(SHFRONTX)       ; SAVE CALCULATED X-COORDINATE
        
            MOVE.W  D1,D3               ; COS
            MULS    #SHFRONTYC,D3        ; Y*COS(SHIPANGL)*2^8
            NEG.L   D3                  ; DOWN IS GROWING Y (PERHAPS .L NOT NECESSARY)
            ASL.L   #8,D3               ; -Y*COS(SHIPANGL)
            ADD.L   (SHPOSY),D3
            ASR.L   #8,D3
            ASR.L   #8,D3
            MOVE.W  D3,(SHFRONTY)      ; SAVE CALCULATED Y-COORDIANTE
        
            ; LEFT BASE POINT (SHIPBALX AND SHIPBALY)
            MOVE.W  D1,D2               ; COS
            MOVE.W  D0,D3
            NEG.L   D3                      ; -SIN
            MULS    #SHBACKLXC,D2           ; COS*X
            MULS    #SHBACKLYC,D3         ; -SIN*Y
            ADD.L   D2,D3
            ASL.L   #8,D3
            ADD.L   (SHPOSX),D3
            ASR.L   #8,D3
            ASR.L   #8,D3
            MOVE.W  D3,(SHBACKLX)      ; SAVE CALCULATEX X-COORDINATE

            MOVE.W  D0,D2               ; SIN
            MOVE.W  D1,D3               ; COS
            MULS    #SHBACKLXC,D2        ; SIN*X
            MULS    #SHBACKLYC,D3        ; COS*Y
            ADD.L   D2,D3
            NEG.L   D3 
            ASL.L   #8,D3
            ADD.L   (SHPOSY),D3
            ASR.L   #8,D3
            ASR.L   #8,D3
            MOVE.W  D3,(SHBACKLY)      ; SAVE CALCULATE Y-COORDINATE
        
            ; RIGHT BASE POINT (SHIPBARX AND SHIPBARY)
            MOVE.W  D1,D2               ; COS
            MOVE.W  D0,D3
            NEG.L   D3                  ; -SIN
            MULS    #SHBACKRXC,D2        ; COS*X
            MULS    #SHBACKRYC,D3        ; -SIN*Y
            ADD.L   D2,D3
            ASL.L   #8,D3
            ADD.L   (SHPOSX),D3
            ASR.L   #8,D3
            ASR.L   #8,D3
            MOVE.W  D3,(SHBACKRX)      ; SAVE CALCULATED X-COORDINATE
        
            MOVE.W  D0,D2               ; SIN
            MOVE.W  D1,D3               ; COS
            MULS    #SHBACKRXC,D2        ; SIN*X
            MULS    #SHBACKRYC,D3        ; COS*Y
            ADD.L   D2,D3
            NEG.L   D3 
            ASL.L   #8,D3
            ADD.L   (SHPOSY),D3
            ASR.L   #8,D3
            ASR.L   #8,D3
            MOVE.W  D3,(SHBACKRY)      ; SAVE CALCULATED Y-COORDINATE
        
            CLR.L   D1  ; IMPORTANTE
            CLR.L   D2
            CLR.L   D3
        
            ; UPDATE THE VELOCITY AND ANGLE BASED ON THE KEYS CURRENTLY PRESSED
            MOVE.B  (KBDVAL),D0
            BTST.L  #3,D0   ; TEST DOWN KEY
            BEQ RIGHT
            MOVE.B  (SHANGL),D3
            MULU    #2,D3               ; IMPORTANTE
            MOVE.W  D3,A0
            MOVE.W  RCTSINTB(A0),D1 ;SIN
            MOVE.W  RCTCOSTB(A0),D2 ;COS
        
            ;MULS    #1,D1
            EXT.L   D1
            ASL.L   #8,D1
            ADD.L   D1,(SHVELX)   ; X=-ACC*COS(ANGLE)
        
            ;MULS    #1,D2
            EXT.L   D2
            ASL.L   #8,D2
            SUB.L   D2,(SHVELY)
        
RIGHT:      BTST.L  #2,D0   ; TEST RIGHT KEY
            BEQ UP
            SUBQ.B  #5,(SHANGL)

UP:         BTST.L  #1,D0   ; TEST UP KEY
            BEQ LEFT
            MOVE.B  (SHANGL),D3
            MULU    #2,D3               ; IMPORTANTE
            MOVE.W  D3,A0
            MOVE.W  RCTSINTB(A0),D1 ;SIN
            MOVE.W  RCTCOSTB(A0),D2 ;COS
        
            ;MULS    #1,D1
            EXT.L   D1
            ASL.L   #8,D1
            SUB.L   D1,(SHVELX)   ; X=-ACC*COS(ANGLE)
        
            ;MULS    #1,D2
            EXT.L   D2
            ASL.L   #8,D2
            ADD.L   D2,(SHVELY)
        
        
LEFT:       BTST.L  #0,D0   ; TEST LEFT KEY
            BEQ END
            ADDQ.B  #5,(SHANGL)
END:
            MOVEM.L (A7)+,D0-D3/A0
            
            RTS

; ------------------------------------------------------------------------------
SHIPPLOT
; PLOT THE SHIP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D2
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            
            ; SET CONTOUR COLOR
            MOVE.W  #80,D0
            MOVE.L  #SHPCOL,D1
            TRAP    #15
    
            ; MOVE CURSOR TO NOSE POINT
            MOVE.W  #86,D0
            MOVE.W  (SHFRONTX),D1
            MOVE.W  (SHFRONTY),D2
            TRAP    #15

            ; DRAW LINE TO LEFT BASE POINT
            MOVE.W  #85,D0
            MOVE.W  (SHBACKLX),D1
            MOVE.W  (SHBACKLY),D2
            TRAP    #15

            ; DRAW LINE TO RIGHT BASE POINT
            MOVE.W  #85,D0
            MOVE.W  (SHBACKRX),D1
            MOVE.W  (SHBACKRY),D2
            TRAP    #15

            ; DRAW LINE BACK TO NOSE POINT
            MOVE.B  #85,D0
            MOVE.W  (SHFRONTX),D1
            MOVE.W  (SHFRONTY),D2
            TRAP    #15

            MOVEM.L (A7)+,D0-D2

            RTS

    
    



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
