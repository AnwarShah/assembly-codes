; A program to put the sum 1+4+7+........+148 in AX, then display the result
; This program is incomplete as it does not display the result yet
CODE    SEGMENT
    ASSUME  CS:CODE
    
    START:
        XOR AX,AX   ;clear AX
        MOV AX, 1D      ; put decimal 1 in AX
        XOR CX,CX
        MOV CX,AX        
    COUNT:
        ADD CX,3D           
        ADD AX, CX
        CMP CX, 148D    ;
        JE DISPLAY
        JMP COUNT       ; loop until 148
        
        
    DISPLAY:
        
        
CODE    ENDS
    END START
        