; Program 16: Write a program to reverse a bit pattern

CODE    SEGMENT
    ASSUME  CS:CODE
    
    START:
        MOV AL, 11011000B   ; store bit pattern
        MOV CX, 8;
    REVERSE:
        SHL AL,1    ; get a bit into CF
        RCR BL, 1   ; get the bit into BL by rotating
        LOOP    REVERSE ; loop until done
        MOV AL, BL  ; AL get the reversed bit pattern
    
    EXIT:
        
        MOV DL, 4cH
        INT 21H

CODE    ENDS
    END START