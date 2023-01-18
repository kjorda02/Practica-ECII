* ==============================================================================
;                   SYSTEM CONSTANTS
* ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH    EQU     640*2     ; SCREEN WIDTH
SCRHEIGH    EQU     480*2     ; SCREEN HEIGHT
SCRINTNM    EQU     1
UPDINTNM    EQU     2
FPSINTNM    EQU     3
SCRFPS      EQU     100        ; FRAMES PER SECOND
UPDTPS      EQU     100        ; TICKS PER SECOND
; WARNING: UNFORTUNATELY THE AUTO IRQ ONLY ACCEPTS MULTIPLES OF 10MS, THEREFORE
; THE FPS AND TPS WILL SETTLE AT 100,50,33,25,20,17,14,ETC

; --- KEYCODES -----------------------------------------------------------------

KBDLEFT     EQU $25 ; LEFT UP RIGHT AND DOWN ARROWS
KBDUP       EQU $26
KBDRIGHT    EQU $27
KBDDOWN     EQU $28
KBDFIRE1    EQU ' '
KBDFIRE2    EQU 'M'
KBDFIRE3    EQU $10 ; SHIFT
KBDPAUSE    EQU 'P'



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
