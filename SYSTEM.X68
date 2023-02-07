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
            JSR MOUSINIT
    
            MOVE.L  #SCRPLOT,($80)  ; INSTALL SCRPLOT ON TRAP #0
            MOVE.L  #KBDUPD,($84)   ; INSTALL KBDUPD ON TRAP #1
            MOVE.L  #MOUSUPD,($88)  ; INSTALL MOUSUPD ON TRAP #2
    
            ; Switch to user mode and return from subroutine
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)
            RTE
    
; ------------------------------------------------------------------------------
SCRINIT
; INIT SCREEN. SET SCREEN RESOLUTION, SET WINDOWED MODE, CLEAR SCREEN
; ENABLE DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D1
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
            
            ; INIT SCREEN VARIABLES
            CLR.W   (SCRINTCT)
            CLR.W   (SCRCYCCT)
            CLR.W   (FPS)
            CLR.W   (UPDINTCT)
            CLR.W   (UPDCYCCT)
            
            ; INSTALL ISR SCRISR INTO INT. NUM. SCRINTNM
            MOVE.L  #SCRISR,($60+SCRINTNM*4)    ; INSTALL SCRISR
            
            ; ENABLE HARDWARE (TIMED INTERRUPT)
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #%10000000|SCRINTNM,D2
            MOVE.L  #1000/SCRFPS,D3             ; MILLISECONDS PER FRAME
            TRAP    #15
            
            ; INSTALL ISR UPDISR INTO INT. NUM. UPDINTNM
            MOVE.L  #UPDISR,($60+UPDINTNM*4)    ; INSTALL UPDISR
            
            ; ENABLE HARDWARE (TIMED INTERRUPT)
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #%10000000|UPDINTNM,D2
            MOVE.L  #1000/UPDTPS,D3             ; MILLISECONDS PER UPDATE
            TRAP    #15
            
            ; INSTALL ISR FPSISR INTO INT. NUM. FPSINTNM
            MOVE.L  #FPSISR,($60+FPSINTNM*4)    ; INSTALL SCRISR
            
            ; ENABLE TIMED INTERRUPT FOR FPSISR
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #%10000000|FPSINTNM,D2
            MOVE.L  #1000,D3    ; GENERATE INTERRUPT EVERY 1 SECOND
            TRAP    #15
    
            ; ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
    
            MOVEM.L (A7)+,D0-D1
    
            RTS

; ------------------------------------------------------------------------------
FPSISR
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  (SCRCYCCT),(FPS)
            CLR.W   (SCRCYCCT)

            MOVE.W  (UPDCYCCT),(TPS)
            CLR.W   (UPDCYCCT)
            
            RTE
            
; ------------------------------------------------------------------------------
UPDISR
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ADDQ.W  #1,(UPDINTCT)
            RTE
    
; ------------------------------------------------------------------------------
SCRISR
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ADDQ.W   #1,(SCRINTCT)

            RTE

; ------------------------------------------------------------------------------
SCRPLOT
; UPDATES DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D1
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
; [e|a|x|t|DOWN|RIGHT|UP|LEFT]
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)
    
            ; READ FIRST 4 KEYS
            MOVE.B  #19,D0
            MOVE.L  #KBDe<<24|KBDa<<16|KBDx<<8|KBDt, D1
            TRAP    #15
    
            ; CONVERT TO DESIRED FORMAT
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

    
.PACK       MOVE.W  #3,D3
.LOOP           LSL.L   #8,D1   ; SHIFT D1 TAKING OUT 1 BYTE AT A TIME AND SAVE IT IN X
                ROXL.B  #1,D2   ; SHIFT D2 PUTING IN THE BIT SAVED IN THE X FLAG
                DBRA.W  D3,.LOOP
            RTS
            
; ------------------------------------------------------------------------------
MOUSINIT
; INIT MOUSE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (MOUSVAL)
            RTS
            
; ------------------------------------------------------------------------------
MOUSUPD
; UPDATE MOUSE INFO
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : D0-D3
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)

            MOVE.B  #61,D0
            MOVE.W  #0,D1
            TRAP    #15 ;D0.B=BUTTONS, D1.L= YY XX
            
            ; COMPUTE (AND STORE) MOUSEDGE
            MOVE.B  (MOUSVAL),D2    ; PREVIOUS VALUES
            NOT.B   D2
            AND.B   D0,D2
            MOVE.B  D2,(MOUSEDGE)   ; STORE BUTTON EDGE STATES
            
            MOVE.B  D0,(MOUSVAL)    ; STORE BUTTON STATES
            MOVE.W  D1,(MOUSPOSX)   ; STORE X-COORDINATE
            ASR.L   #8,D1
            ASR.L   #8,D1
            MOVE.W  D1,(MOUSPOSY)   ; STORE Y-COORDINATE
            
            MOVEM.L (A7)+,D0-D2
            RTE
    
    
    




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
