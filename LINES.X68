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
        

; ------------------------------------------------------------------------------
COLTST
; COLLISION DETECTION CODE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D7/A0,-(A7)
            
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
                
                BTST.L  #22,D2
                BEQ     .NOHLTEST
            
                ; TEST HORIZONTAL INTERVAL
                CMP.W   SHPOSX,D0
                BLT     .LTX0       ; X>=X0
                CMP.W   SHPOSX,D2
                BGE     .NOVLTEST   ; X>=X0 AND X<X1
                BRA     .VLTEST
    .LTX0:      
                CMP.W   SHPOSX,D2   ; X<X0
                BLT     .NOVLTEST   ; X<X0 AND X>=X1
    
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
                
                JSR TESTVLT
    .NOVLTEST:
                ; TEST VERTICAL INTERVAL
                CMP.W   SHPOSY,D1
                BLT     .LTY0       ; Y>=Y0
                CMP.W   SHPOSY,D3
                BGE     .NOHLTEST   ; Y>=Y0 AND Y<Y1
                BRA     .HLTEST
    .LTY0:      
                CMP.W   SHPOSY,D3   ; Y<Y0
                BLT     .NOHLTEST   ; Y<Y0 AND Y>=Y1

    .HLTEST:    ; HORIZONTAL LINE TEST:
                ; D0-X0, D1-Y0, D2-X1, D3-Y1
                MOVE.W  D2,D4
                SUB.W   D0,D4   ; D4=X1-X0
                
                MOVE.W  SHPOSY,D5
                SUB.W   D1,D5   ; D5=Y-Y0
                
                MULS    D5,D4   ; D4=(X1-X0)*(Y-Y0)
                
                MOVE.W  D3,D5
                SUB.W   D1,D5   ; D5=Y1-Y0
                DIVS    D5,D4   ; D4=(X1-X0)*(Y-Y0)/(Y1-Y0)
                ADD.W   D0,D4   ; D4=(X1-X0)*(Y-Y0)/(Y1-Y0) + X0
                
                JSR TESTHLT
    .NOHLTEST:

                MOVE.L  D2,D0   ; X0 = X1
                MOVE.W  D3,D1   ; Y0 = Y1
                
                ADDQ.W  #4,A0
                DBRA D6,COL
            
            MOVEM.L (A7)+,D0-D7/A0
            RTS
            
TESTVLT     ; D4=Y
            MOVEM.L D0-D4,-(A7)
            
            MOVE.L  #$00FFAA00,D1
            MOVE.W  #80,D0
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
; PLOT ALL LINES THE CAMERA'S POSITION
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
