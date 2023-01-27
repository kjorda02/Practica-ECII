*===============================================================================
;                                   LINES
*===============================================================================

; ------------------------------------------------------------------------------
LININIT
; INITIALIZE LINES
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        CLR.W   COLCT
        RTS

; ------------------------------------------------------------------------------
COLTST
; COLLISION DETECTION CODE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; [B G R <DRAW><COLLISION><POSX><POSXUPD><POSY><POSYUPD><START><END> X X Y Y]
;
; DRAW:         SHOULD LINE BE DRAWN FROM PREVIOUS VERTEX TO CURRENT VERTEX?
; COLLISION:    SHOULD WE TEST FOR COLLISIONS AGAINST THIS LINE?
; POSX:         1=SHIP TO THE RIGHT OF LINE, 0 OTHERWISE
; POSY:         1=SHIP ON TOP OF LINE, 0 OTHERWISE
; POS<X/Y>UPD:  1=POS<X/Y> WAS UPDATED LAST FRAME, 0 OTHERWISE
; START:        COLLISION WITH THIS LINE WILL START STOPWATCH
; STOP:         COLLISION WITH THIS LINE WILL STOP STOPWATCH
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6/A0,-(A7)
            
            MOVE.W  (NOFLINES),D6
            SUBQ.W  #1,D6
            MOVEA.L #2,A0
            CLR.W   D0  ; D0=X0
            CLR.W   D1  ; D1=Y0
COL:            
                ; LOAD NEW VERTICES
                MOVE.L  LINES(A0),D2  ; D2.W=X1, HIGH 16 BITS=WORD WITH CONTROL BITS
                ADDQ.W  #4,A0
                MOVE.W  LINES(A0),D3  ; D3=Y1

                ; LINE TEST ---------------------------------------------------
.LINETEST:      BTST.L  #22,D2
                BEQ     .LTESTEND
            
                ; TEST HORIZONTAL INTERVAL ------
                CMP.W   SHPOSX,D0
                BLT     .LTX0
                    ; X>=X0
                    CMP.W   SHPOSX,D2
                    BGE     .NOVLTEST
                        ; X>=X0 AND X<X1
                        BRA     .VLTEST

        .LTX0:      ; X<X0
                    CMP.W   SHPOSX,D2
                    BLT     .NOVLTEST
                        ; X<X0 AND X>=X1
    
    .VLTEST:    ; VERTICAL LINE TEST:
                MOVE.W  D3,D4
                SUB.W   D1,D4   ; D4=Y1-Y0
            
                MOVE.W  SHPOSX,D5
                SUB.W   D0,D5   ; D5=X-X0
                
                MULS    D5,D4   ; D4=(X-X0)*(Y1-Y0)
    
                MOVE.W  D2,D5
                SUB.W   D0,D5   ; D5=X1-X0
                DIVS    D5,D4   ; D4=(X-X0)*(Y1-Y0)/(X1-X0)
                ADD.W   D1,D4   ; D4=(X-X0)*(Y1-Y0)/(X1-X0) + Y0
                
                ; DETECT COLLISIONS FOR VERTICAL LINE TEST
                CMP.W   (SHPOSY),D4
                BLT     .SHONTOP
                    ; SHPOSY <= Y (SHIP IS BELOW LINE)
                    BCLR.L  #19,D2  ; SET POSY TO 0 AND TEST PREV VALUE
                    BEQ     .NOVCOL ; IF PREV VALUE ALSO = 0 -> NO COLLISION
                    
                    BTST.L  #18,D2  ; TEST POSYUPD
                    BEQ     .NOVCOL ; IF POSYUPD=0 -> NO COLLISION

                    JSR HANDLECOL   ; ELSE -> COLLISION!
                    BCLR.L  #18,D2  ; AVOIDS DETECTING THE COLLISION TWICE
                    BRA .NOHLTEST
        .SHONTOP:
                    ; SHPOSY > Y (SHIP IS ABOVE LINE)
                    BSET.L  #19,D2  ; SET POSY TO 1 AND TEST PREV VALUE
                    BNE     .NOVCOL ; IF PREV VALUE ALSO = 1 -> NO COLLISION
                    
                    BTST.L  #18,D2  ; TEST POSYUPD
                    BEQ     .NOVCOL ; IF POSYUPD=0 -> NO COLLISION
                    
                    JSR HANDLECOL   ; ELSE -> COLLISION!
                    BCLR.L  #18,D2  ; AVOIDS DETECTING THE COLLISION TWICE
                    BRA .NOHLTEST
    .NOVCOL:
                BSET.L  #18,D2  ; POSYUPD=1
                TST.W   (DEBUG)
                BEQ .VINTERVAL
                JSR TESTVLT
                BRA .VINTERVAL
    
    .NOVLTEST:
                BCLR.L  #18,D2  ; POSYUPD=0
    .VINTERVAL:
                ; TEST VERTICAL INTERVAL ------
                CMP.W   SHPOSY,D1
                BLT     .LTY0
                    ; Y>=Y0
                    CMP.W   SHPOSY,D3
                    BGE     .NOHLTEST
                        ; Y>=Y0 AND Y<Y1
                        BRA     .HLTEST
        .LTY0:      
                    ; Y<Y0
                    CMP.W   SHPOSY,D3
                    BLT     .NOHLTEST
                        ; Y<Y0 AND Y>=Y1

    .HLTEST:    ; HORIZONTAL LINE TEST:
                ; D0=X0, D1=Y0, D2=X1, D3=Y1
                MOVE.W  D2,D4
                SUB.W   D0,D4   ; D4=X1-X0
                
                MOVE.W  SHPOSY,D5
                SUB.W   D1,D5   ; D5=Y-Y0
                
                MULS    D5,D4   ; D4=(X1-X0)*(Y-Y0)
                
                MOVE.W  D3,D5
                SUB.W   D1,D5   ; D5=Y1-Y0
                DIVS    D5,D4   ; D4=(X1-X0)*(Y-Y0)/(Y1-Y0)
                ADD.W   D0,D4   ; D4=(X1-X0)*(Y-Y0)/(Y1-Y0) + X0
                
                ; DETECT COLLISIONS FOR HORIZONTAL LINE TEST
                CMP.W   (SHPOSX),D4
                BLT     .SHRIGHT
                    ; SHPOSX <= X (SHIP IS TO THE LEFT OF LINE)
                    BCLR.L  #21,D2  ; SET POSX TO 0 AND TEST PREV VALUE
                    BEQ     .NOHCOL ; IF PREV VALUE ALSO = 0 -> NO COLLISION
                    
                    BTST.L  #20,D2  ; TEST POSXUPD
                    BEQ     .NOHCOL ; IF POSXUPD=0 -> NO COLLISION
                    
                    JSR HANDLECOL   ; ELSE -> COLLISION!
                    BCLR.L  #18,D2  ; IN CASE VLTEST MARKED THIS SIDE OF THE LINE
                    BRA .NOHLTEST
        .SHRIGHT:   
                    ; SHPOSX > X (SHIP IS TO THE RIGHT OF LINE)
                    BSET.L  #21,D2  ; SET POSX TO 1 AND TEST PREV VALUE
                    BNE     .NOHCOL ; IF PREV VALUE ALSO = 1 -> NO COLLISION
                    
                    BTST.L  #20,D2  ; TEST POSXUPD
                    BEQ     .NOHCOL ; IF POSXUPD=0 -> NO COLLISION
                    
                    JSR HANDLECOL   ; ELSE -> COLLISION
                    BCLR.L  #18,D2
                    BRA .NOHLTEST
                    
        .NOHCOL:
                BSET.L  #20,D2
                TST.W   (DEBUG)
                BEQ .LTESTEND
                JSR TESTHLT
                BRA .LTESTEND
                
    .NOHLTEST:
                BCLR.L  #20,D2  ; POSXUPD=0
    .LTESTEND:
                SUBQ.W  #4,A0
                MOVE.L  D2,LINES(A0)
                ADDQ.W  #4,A0
                MOVE.L  D2,D0   ; X0 = X1
                MOVE.W  D3,D1   ; Y0 = Y1
                
                ADDQ.W  #4,A0
                DBRA D6,COL
            
            MOVEM.L (A7)+,D0-D6/A0
            RTS

; -----------------------------------------------------------------------------
HANDLECOL
; HANDLE COLLISION (IS CALLED BY COLTEST)
; INPUT: D0.W=X0, D1.W=Y0, D2.W=X1, D3.W=Y1
; OUTPUT: NONE
; MODIFIES: NONE
; [MAX DISTANCE BETWEEN POINTS (Lx and Ly) = 1023 (10 bits for Lx and Ly)]
; Everything is divided by 2^5 to make the denominator fit in 16 bits
; -----------------------------------------------------------------------------
            MOVEM.L D0-D7,-(A7)
            
            BTST.L  #17,D2  ; IS IT START LINE?
            BNE .STARTTIM
            BTST.L  #16,D2  ; IS IT END LINE?
            BNE .STOPTIM
            
            ADDQ.W  #1,COLCT            
            ; REFLECT VELOCITY ON COLLIDED LINE -------------------------------
            ; NECESSARY FOR BOTH --------------------
            SUB.W   D0,D2   ; D2=Lx
            SUB.W   D1,D3   ; D3=Ly
            MOVE.W  D2,D0
            MULS    D3,D0   
            ASR.L   #4,D0   ; D0=Lx*Ly*2^-4 (16 bits)
            
            MOVE.W  D2,D1
            MULS    D2,D1 ;Lx^2
            MOVE.W  D3,D4
            MULS    D3,D4 ;Ly^2
            MOVE.L  D1,D2
            ADD.L   D4,D2
            ASR.L   #5,D2   ; D2=((Lx^2)+(Ly^2))*2^-5  (16 bits)

            SUB.L   D4,D1
            ASR.L   #4,D1   ; D1=(Lx^2)-(Ly^2)*2^-4  (16 bits)
            
            MOVE.L  (SHVELY),D4
            ; [-------- ---XXXXX . XXXXXXXX --------] SHVELY = Vy*2^16 (5 + 16 = 21 bits)
            ASR.L   #8,D4
            ; [-------- -------- ---XXXXX . XXXXXXXX] D4= Vy*2^8 (5 + 8 = 13 bits)
            
            MOVE.L  (SHVELX),D6
            ASR.L   #8,D6   ; Same story as with Vy
                            ; D6= Vx*2^8
            
            ; CALCULATE NEW X VELOCITY --------------------
            MOVE.W  D4,D5
            MULS    D0,D5
            ;ASL.L   #2,D7   ; D5 = 2Vy(LxLy)*2^3  (1 + 5 + 20 + 3 = 29 bits)

            MOVE.W  D6,D7
            MULS    D1,D7
            ASR.L   #1,D7   ; D7= Vx*((Lx^2)-(Ly^2))*2^3  (5 + 20 + 3 = 28 bits)
            
            ADD.L   D5,D7   ; D7= ( 2VyLxLy + Vx*((Lx^2)-(Ly^2)) )*2^3  ( 26.58 + 3 = 29.58 bits )
            DIVS    D2,D7   ; D7= [( 2VyLxLy + Vx*((Lx^2)-(Ly^2)) )/((Lx^2)+(Ly^2))]*2^8 = Vx'*2^8
            
            ANDI.L  #$0000FFFF,D7   ; IMPORTANT
            EXT.L   D7              ; ALSO IMPORTANT :(
            ASL.L   #8,D7           ; D7 = Vx'*2^16
            MOVE.L  D7,(SHVELX)
            
            ; CALCULATE NEW Y VELOCITY --------------------
            MOVE.W  D6,D5
            MULS    D0,D5   ; D5= 2Vx(LxLy)*2^3 (29 bits)
            ;ASL.L   #2,D5
            
            MOVE.W  D4,D7
            MULS    D1,D7
            ASR.L   #1,D7   ; D7 = Vy((Lx^2)-(Ly^2))*2^3  (28 bits)
            
            SUB.L   D7,D5   ; D7 = (2Vx(LxLy) - [Vy((Lx^2)-(Ly^2)]))*2^3  ( 26 + 3 bits)
            DIVS    D2,D5   ; D7 = [(2Vx(LxLy) - [Vy((Lx^2)-(Ly^2)]))/((Lx^2)+(Ly^2))]*2^8  = Vy'*2^8
            
            ANDI.L  #$0000FFFF,D5   ; IMPORTANT
            EXT.L   D5
            ASL.L   #8,D5           ; D5 = Vx'*2^16
            MOVE.L  D5,(SHVELY)
            
            ; WE ADD THE NEW VELOCITY TWICE BEFORE THE NEXT COLLISION TEST IN CASE THE REFLECTED
            ;  VELOCITY WAS NOT ENOUGH TO CROSS THE LINE AGAIN DUE TO ROUNDING ERROR
            JSR SHIPUPD
            
.STARTTIM:

.STOPTIM:
            
            MOVEM.L (A7)+,D0-D7
            RTS

            
TESTVLT     ; D4=Y
            MOVEM.L D0-D4,-(A7)
            
            CMP.W   (SHPOSY),D4
            BGE     .NOFILLY
            MOVE.L  #$00800000,D1
            BRA     .FILLY
    .NOFILLY:  
            MOVE.L  #$00000000,D1
    .FILLY:           
            MOVE.B  #81,D0
            TRAP    #15
      
            MOVE.L  #$00FFAA00,D1
            MOVE.B  #80,D0
            TRAP    #15
            
            MOVE.W  SHPOSX,D1   ; D1=X, D4=Y
            
            MOVE.W  (CAMPOSY),D2
            SUB.W   D4,D2   ; Y1-Y
            MOVE.W  D2,D4
            
            MOVE.W  (CAMPOSX),D3
            SUB.W   D3,D1   ; X-X1
            MOVE.W  D1,D3
            
            SUBQ.W  #7,D1
            ADDQ.W  #7,D2
            ADDQ.W  #7,D3
            SUBQ.W  #7,D4
            
            MOVE.W  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            RTS
            
TESTHLT     ; D4=X
            MOVEM.L D0-D4,-(A7)
            
            CMP.W   (SHPOSX),D4
            BGE     .NOFILLX
            MOVE.L  #$00008000,D1
            BRA .FILLX
    .NOFILLX:
            MOVE.L  #$00000000,D1
    .FILLX:
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.L  #$00AAFF00,D1
            MOVE.W  #80,D0
            TRAP    #15
            
            MOVE.W  D4,D1
            SUB.W   (CAMPOSX),D1    ; X-X1
            MOVE.W  D1,D3
            
            MOVE.W  (CAMPOSY),D4
            SUB.W   (SHPOSY),D4     ; Y1-Y
            MOVE.W  D4,D2
            
            SUBQ.W  #7,D1
            ADDQ.W  #7,D2
            ADDQ.W  #7,D3
            SUBQ.W  #7,D4
            
            MOVE.W  #87,D0
            TRAP    #15

            MOVEM.L (A7)+,D0-D4
            RTS
; ------------------------------------------------------------------------------
LINEPLOT
; PLOT ALL LINES FROM THE CAMERA'S POSITION
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6/A0,-(A7)

            MOVE.W  (NOFLINES),D6
            BEQ     EPLOTLINE   ; If number of lines = 0 we don't enter the loop
            SUBQ.W  #1,D6
            MOVEA.L #0,A0
            MOVE.W  #16,D5
PLOTLINE:        
                MOVE.L  LINES(A0),D3    ; FIRST 2 WORDS CONTAINING BGR + CONTROL BITS
                ADDQ.W  #4,A0
                MOVE.L  LINES(A0),D4     ; LAST 2 WORDS CONTAINING X AND Y POSITIONS
                ADDQ.W  #4,A0            ; ABSOLUTE Y POSITION IN D4
                MOVE.W  (CAMPOSY),D2
                SUB.W   D4,D2       ; SCREEN Y POSITION IN D2 (Y0-Y)
                LSR.L   D5,D4      ; ABSOLUTE X POSITION IN D4
                SUB.W   (CAMPOSX),D4   ; SCREEN X POSITION IN D4
                BTST.L  #7,D3
                BNE     DRAW            ; IF BIT D = 1, JUMP TO DRAW
                
                MOVE.B  #86,D0  ; IF NOT DRAWING, MOVE CURSOR
                MOVE.W  D4,D1
                TRAP    #15
                BRA SKIPDRAW
    DRAW:
                MOVE.B  #80,D0  ; SET PEN COLOR
                MOVE.L  D3,D1
                LSR.L   #8,D1
                TRAP    #15
                
                MOVE.B  #85,D0  ; DRAW LINE
                MOVE.W  D4,D1
                TRAP    #15
    SKIPDRAW:
                DBRA D6,PLOTLINE
EPLOTLINE:
            MOVEM.L (A7)+,D0-D6/A0
            RTS
        
        



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
