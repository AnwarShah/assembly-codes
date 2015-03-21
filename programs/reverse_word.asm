; If input is 'this is a test' this program outputs 'siht si a tset'

.MODEL  SMALL
.STACK  100H
.CODE   

MAIN    PROC
    
    XOR DX,DX   ; clear DX

DO:    
    ; Get char 
    MOV ah,1
    INT 21h
    MOV DL, AL  ; store in DL
    
    ; if space, do space handling
    ;cmp al, 20h
    ;je  space
    
    ; if carriage return stop input
    cmp al, 0dh
    JE EXIT
    
    ;get another char
    MOV AH,1
    INT 21H
    
    ; if space do space handling
    ;cmp al, 20h
    ;je  space
    
    XOR DH,DH
    OR DH, DL  ; shift left 4 bits
    XOR DL,DL
    OR  DL,AL
    POP  BX     ; remove old two letters
    PUSH  DX ; store new two reversed letters
    
    jmp do
    
EXIT:
    MOV AH,4ch
    INT 21H
MAIN    ENDP
    END MAIN
                      