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
    
START:
    
; --- INITIALIZATION -----------------------------------------------------------

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

; UPDATE GAME LOGIC

; --- SYNC ---------------------------------------------------------------------

; --- PLOT ---------------------------------------------------------------------

    BRA     .LOOP
    
    SIMHALT             ; halt simulator
    
    INCLUDE "VARS.X68"
    INCLUDE "SYSVARS.X68"

    END    START        ; last line of source

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
