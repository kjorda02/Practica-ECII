* ==============================================================================
;                           MAP (VECTOR OF OBJECTS)
* ==============================================================================

; ------------------------------------------------------------------------------
MAPINIT
; INITIALIZE MAP.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : A0
; ------------------------------------------------------------------------------

            MOVE.W  #0,MAP    ; OBJECT COUNTER
            
            LEA 2,A0
            
            ; OBJETO DE PRUEBA
            MOVE.W  #0,MAP(A0)          ; NO VELOCITY
            ADDQ.W  #2,A0
            MOVE.W  #250,MAP(A0)        ; POS_X
            ADDQ.W  #2,A0
            MOVE.W  #250,MAP(A0)        ; POS_Y
            ADDQ.W  #2,A0
            MOVE.L  #ASTEROID,MAP(A0)   ; ADRESS OF THE OBJECT CLASS
            ADDQ.W  #2,A0
            
            MOVE.W  A0,(MAP)            ; SAVE POINTER TO THE END OF THE VECTOR

            RTS
            
; ------------------------------------------------------------------------------
DRAWMAP
; DRAWS EVERY INSTANCE OF EVERY OBJECT IN THE MAP VECTOR.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEA.L #2,A0       ; FIRST OBJECT ADRESS      
            MOVE.W (MAP),D0     ; END OF VECTOR ADRESS

.DRAWPT                         ; DO

            ADDQ.W  #2,A0       ; IGNORING VELOCITY FOR NOW
            MOVE.W  MAP(A0),D1  ; POS_X
            ADDQ.W  #2,A0
            MOVE.W  MAP(A0),D2  ; POS_Y
            ADDQ.W  #2,A0
            
            MOVEA.L  MAP(A0),A1 ; ADRESS OF THE OBJECT TYPE
            ADDQ.W  #4,A0
            
            CMP A0,D0
            BHI .DRAWPT         ; WHILE D0>A0
            
            RTS
            
            
DRAWOBJ     ; RECEIVES POS_X IN D1, POS_Y IN D2, AND THE OBJECT TYPE @ IN D3
            

            RTS
            
            
            
            
            
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
