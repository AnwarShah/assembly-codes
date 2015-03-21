; Program 14: Write a program to display extended ASCII characters
; display 10 characterss per line seperated by blanks
; stop after extended characters have been displayed

CODE  SEGMENT
    ASSUME  CS:CODE
    
START:
    MOV BL,80H  ;
    XOR CX,CX   ;
    JMP COUNT_START
    
    PRINT_LINE:        
        ; go to next line
        MOV AH,2
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH
        INT 21H
        
    COUNT_START:
        MOV CL, 0AH
    
    WHILE_INNER:
        ; print a char
        MOV AH, 2;
        MOV DL, BL
        INT 21H;
        
        ; if the last character is displayed
        ; stop
        CMP BL, 0FFH;
        JZ  END_WHILE
        
        ; point to next char
        INC BL
        
        ; print a space 
        MOV DL, ' ';
        INT 21H 
        
        ; Decrement counter
        DEC CL
        
        ; if Count is 0 jump to WHILE OUTER
        CMP CL, 0h;
        JZ  PRINT_LINE
        JMP WHILE_INNER

END_WHILE:
    MOV AH,4CH;
    INT 21H
        
CODE    ENDS
    END START
        
      