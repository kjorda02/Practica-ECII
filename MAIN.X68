*-----------------------------------------------------------
* Title      : Archivo principal del juego
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
    
    INCLUDE "CONST.X68"
    INCLUDE "SYSCONST.X68"
    
START:                  ; first instruction of program
    
* Put program code here

    SIMHALT             ; halt simulator
    
    INCLUDE "VARS.X68"
    INCLUDE "SYSVARS.X68"
* Put variables and constants here

    END    START        ; last line of source
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
