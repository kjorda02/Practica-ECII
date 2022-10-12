* ==============================================================================
;                                   SYSTEM
* ==============================================================================

SYSINIT
; INITIALIZE SYSTEM
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    JSR SCRINIT
    JSR KBDINIT
    
    MOVE.L  #SCRPLOT,($80)  ; INSTALL SCRPLOT ON TRAP #0
    MOVE.L  #KBDUPD,($84)   ; INSTALL KBDUPD ON TRAP #1
    
    ; Switch to user mode and return from subroutine
    MOVE.W  SR,-(A7)
    ANDI.W  #$DFFF,(A7)
    RTE
    
; ------------------------------------------------------------------------------
SCRINIT
; INIT SCREEN. SET SCREEN RESOLUTION, SET WINDOWED MODE, CLEAR SCREEN
; ENABLE DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

    MOVEM.L D0-D1,-(A7)

    ; SET SCREEN RESOLUTION
    MOVE.B  #33,D0
    MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
    TRAP    #15
    
    ; SET WINDOWED MODE
    MOVE.L  #1,D1
    TRAP    #15
    
    ; CLEAR SCREEN
    MOVE.B  #11,D0
    MOVE.W  #$FF00,D1
    TRAP    #15
    
    ; ENABLE DOUBLE BUFFER
    MOVE.B  #92,D0
    MOVE.B  #17,D1
    TRAP    #15
    
    MOVEM.L (A7)+,D0-D1
    
    RTS
    

; ------------------------------------------------------------------------------
SCRPLOT
; UPDATES DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    MOVEM.W D0-D1,-(A7)
    ; SWTICH BUFFERS
    MOVE.W  #94,D0
    TRAP    #15
    
    ; CLEAR HIDEN BUFFER
    MOVE.B  #11,D0
    MOVE.W  #$FF00,D1
    TRAP    #15
    MOVEM.W (A7)+,D0-D1
    RTE
    
; ------------------------------------------------------------------------------
KBDINIT
; INIT KEYBOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    CLR.B   (KBDVAL)
    CLR.B   (KBDEDGE)
    RTS
    
; ------------------------------------------------------------------------------
KBDUPD
; UPDATE KEYBOARD INFO
; [PAUSE|FIRE3|FIRE2|FIRE1|DOWN|RIGHT|UP|LEFT]
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    MOVEM.L D0-D3,-(A7)
    
    ; READ FIRST 4 KEYS
    MOVE.B  #19,D0
    MOVE.L  #KBDPAUSE<<24|KBDFIRE3<<16|KBDFIRE2<<8|KBDFIRE1, D1
    TRAP    #15
    
    ; CONVERT TO DESIRED FORMAT
    MOVE.W  #3,D3
    
    JSR .PACK
    
    ; READ THE OTHER 4 KEYS
    MOVE.L  #KBDDOWN<<24|KBDRIGHT<<16|KBDUP<<8|KBDLEFT, D1
    TRAP    #15
    
    ; CONVERT TO DESIRED FORMAT
    JSR .PACK
    
    ; COMPUTE (AND STORE) KBDEDGE
    MOVE.B  (KBDVAL),D0 ; PREVIOUS VALUES
    NOT.B   D0
    AND.B   D2,D0
    MOVE.B  D0,(KBDEDGE)
    
    ; STORE KBDVAL
    MOVE.B  D2,(KBDVAL)
    
    MOVEM.L (A7)+,D0-D3
    
    RTE
    
.PACK
    MOVE.W  #3,D3
.LOOP   LSL.L   #8,D1   ; SHIFT D1 TAKING OUT 1 BYTE AT A TIME AND SAVE IT IN X
        ROXL.B  #1,D2   ; SHIFT D2 PUTING IN THE BIT SAVED IN THE X FLAG
        DBRA.W  D3,.LOOP
    RTS
    
    
    
    
    
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
