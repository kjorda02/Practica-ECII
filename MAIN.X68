* ==============================================================================
* Title      : Archivo principal del juego
* Written by :
* Date       :
* Description:
* ==============================================================================
            ORG    $1000
    
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "SHIP.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "RCTDATA.X68"
            INCLUDE "LINES.X68"
            
            DS.W    1   ; WORD ALIGNMENT
START:

; DISABLE INTERRUPTS
            OR.W    #$0700,SR

; --- INITIALIZATION -----------------------------------------------------------
            MOVE.W  #32,D0  ; ENABLE EXCEPTIONS
            MOVE.W  #5,D1
            TRAP    #15
            
            JSR SYSINIT
            JSR SHIPINIT
            JSR SCOINIT

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES
            TRAP #1

; UPDATE GAME LOGIC

            JSR SHIPUPD
            JSR SCOUPD

; --- SYNC ---------------------------------------------------------------------
            ; IF SCRINTCT IS 1 IT MEANS WE'RE LATE
            TST.B   (SCRINTCT)
            BEQ     .WAIT
            ADDQ.W  #1,(DROPFRA)
            CLR.B   (SCRINTCT)
            BRA     .LOOP
            
.WAIT       TST.B   (SCRINTCT)
            BEQ     .WAIT
            CLR.B   (SCRINTCT)

; --- PLOT ---------------------------------------------------------------------

            JSR SCOPLOT
            JSR SHIPPLOT
            JSR LINEPLOT
    
            TRAP    #0      ; UPDATE SCREEN

            BRA     .LOOP
    
            SIMHALT
    
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"

            END    START


*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
