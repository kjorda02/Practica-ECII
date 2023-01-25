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

.UPDATE

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES
            TRAP #1

; UPDATE GAME LOGIC

            JSR SHIPUPD
            JSR SCOUPD
            JSR COLTST
            BRA .UPDDONE

; --- SYNC ---------------------------------------------------------------------
.LOOP
            TST.W   (UPDINTCT)      ; WAIT FOR NEXT UPDATE INTERRUPT
            BEQ     .LOOP
            
            SUBQ.W  #1,(UPDINTCT)
            ADDQ.W  #1,(UPDCYCCT)            ASL.L   D4,D1
            BRA     .UPDATE

.UPDDONE    ; ALL UPDATES ARE UP TO DATE :)
            TST.W   (UPDINTCT)  ; MORE THAN 1 UPDATE PER FRAME CAN HAPPEN
            BNE     .LOOP
            TST.W   (SCRINTCT)  ; WAIT FOR NEXT FRAME INTERRUPT
            BEQ     .UPDDONE
            
            SUBQ.W  #1,(SCRINTCT)
            ADDQ.W  #1,(SCRCYCCT)

; --- PLOT ---------------------------------------------------------------------
            MOVE.W  #600,D0
.TESTA:
            MOVE.W  #-1,D1
.TESTB:
            ;DBRA    D1,.TESTB      
            DBRA    D0,.TESTA

            JSR SCOPLOT
            JSR LINEPLOT
            JSR SHIPPLOT

            TRAP    #0      ; UPDATE SCREEN
            
            BRA     .LOOP   ; WE DO NOT ALLOW PLOTTING MORE THAN 1 FRAME PER UPDATE
                            ; SINCE IT WOULD BE POINTLESS AND POSSIBLY DELAY UPDATES
    
            SIMHALT
    
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"

            END    START




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
