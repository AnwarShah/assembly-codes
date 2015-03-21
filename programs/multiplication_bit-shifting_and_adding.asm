; Multiplication using bit shifting and addition

.MODEL  SMALL
.STACK  100h
.CODE   

MAIN    PROC
    ; call multiply for multiplication
    CALL    MULTIPLY
    ; after return exit
    MOV AH,4ch
    INT 21h
MAIN    ENDP

MULTIPLY    PROC
;input : AX and BX containing two numbers in range 0 - FFh
;output: Product of AX and BX in DX

    PUSH    AX  ; save AX
    PUSH    BX  ; save BX
    XOR     DX,DX   ; clear DX
    
DO:
    TEST    BX, 1   ; test first bit
    JZ      SHIFT   ; if even, go to shifting
    ; else do addition with AX
    ADD     DX, AX  ;   Product = Product + AX
    
SHIFT:
    SHL AX,1    ; shift left AX
    SHR BX, 1   ; shift right BX
    
    ; if BX not zero, do again
    JNZ DO
    
    ; end multiplication ? restore original value of AX , BX
    POP AX
    POP BX
    
    ; return
    RET
MULTIPLY    ENDP
    END MAIN