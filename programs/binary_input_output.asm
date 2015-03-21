; Read binary input and display it
; This program assumes that user will enter either '0' or '1' or CR

CODE    SEGMENT
    ASSUME  CS:CODE
    
START:
    XOR BX,BX   ; BX will contain the binary word

READ:
    ; read a value    
    MOV AH,1
    INT 21H
    
    ;if it is CR, exit
    CMP AL, 0DH
    JE  DISPLAY
    
    ; else convert the ascii value into binary 
    AND AL, 0FH;
    ; shift the BX to create room for new value
    SHL BX, 1;
    ; store it in new room
    OR  BL,AL
    JMP READ

DISPLAY:    
    MOV AH,2
    MOV DL, 0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    ; display the bit pattern
    MOV CX, 16D ; counter

WHILE:    
    ; rotate left BX
    ROL BX, 1
    
    ; compare the CF with 1 and 0
    JC  ONE ; if 1, display 1
    
    MOV DL, 30H ;not 1, so display 0     
    JMP PRINT  
    
    ONE:
        MOV DL, 31H; 
    
    PRINT:
        MOV AH, 2
        INT 21H
        
        DEC CX ; decrease counter 
        CMP CX, 0  ; check, if counter has reached 0
        JZ  EXIT   ; if yes, then exit
        JMP  WHILE ; else go to print next binary value
            
EXIT:
    MOV AH,4CH
    INT 21H
    
CODE    ENDS
    END START