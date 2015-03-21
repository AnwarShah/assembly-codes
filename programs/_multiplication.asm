DATA_HERE   SEGMENT
            MULTIPLICAND    DW  204AH   ;FIRST WORD HERE
            MULTIPLIER      DW  382AH   ; SECOND WORD HERE
            PRODUCT         DW  2 DUP(0)    ; RESULT OF MULTIPLICATION HERE
DATA_HERE   ENDS

CODE_HERE   SEGMENT
            ASSUME  CS:CODE_HERE,   DS:DATA_HERE

START:      MOV AX, DATA_HERE       ; initialize DS register
            MOV DS,AX       
            
            MOV AX,MULTIPLICAND;
            MUL MULTIPLIER          ; multiply by second word
            MOV PRODUCT, AX         ; Store low word of result
            MOV PRODUCT+2, DX       ; Store high word of result
            INT 3
CODE_HERE   ENDS
            END START