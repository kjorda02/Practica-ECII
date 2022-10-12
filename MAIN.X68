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
    INCLUDE "PROJECTILE.X68"
    INCLUDE "SCORE.X68"
    DS.W    1   ; WORD ALIGNMENT
START:

; --- INITIALIZATION -----------------------------------------------------------
    JSR SYSINIT
    JSR SHIPINIT
    JSR SCOINIT

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES
    TRAP #1

; UPDATE GAME LOGIC

    JSR SHIPUPD
    JSR PROJUPD
    JSR SCOUPD

; --- SYNC ---------------------------------------------------------------------
    ; THE FOLLOWING SYNC STRATEGY IS ***WRONG***
    MOVE.B  #23,D0
    MOVE.L  #3,D1
    TRAP    #15

; --- PLOT ---------------------------------------------------------------------

    JSR SCOPLOT
    JSR SHIPPLOT
    JSR PROJPLOT
    
    TRAP    #0  ; UPDATE SCREEN

    BRA     .LOOP
    
    SIMHALT
    
    INCLUDE "VARS.X68"
    INCLUDE "SYSVARS.X68"

    END    START


*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
