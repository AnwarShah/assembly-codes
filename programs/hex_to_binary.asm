; Hex input and display in binary
; We assume user enters no more than 4 hex digits and 
; only upper case letters are used


CODE    SEGMENT
    ASSUME  CS:CODE
    
START:
    XOR BX,BX   ; BX WILL CONTAIN THE HEX INPUT
    
    ; READ A VALUE
    MOV AH,1
    INT 21H
    
WHILE:
    CMP AL, 0DH ; IS IT CR
    JZ  END_WHILE    ; YES, EXIT
    
    CMP AL, 39H ; A DIGIT?
    JG  LETTER  ; NO, A LETTER
    
    ; CONVERT THE DIGIT INTO BINARY VALUE
    AND AL,0FH  
    JMP SHIFT
    
LETTER:
    ; Convert the letter into binary value
    SUB AL, 37H
    
SHIFT:
    ; create room for hex value
    SHL BX, 4
    ; insert value into BX
    OR  BL,AL
    
    ; input another character
    INT 21H
    JMP WHILE

END_WHILE:
    
    ; counter for 16 bit binary value
    XOR CX,CX
    MOV CX, 0FH
         
    ; get a new line
    MOV AH,2
    MOV DL, 0AH
    int 21H
    MOV DL, 0DH
    INT 21H
         
BINARY_DISP:
    ; get the value in CF
    RCL BX, 1
    ; if CF is 1, go to print 1
    JC ONE
    ; otherwise ready to display 0
    MOV DL, 30H
    JMP PRINT
ONE:
    MOV DL, 31H ; value is one
    
PRINT:
    ;select display char funct
    MOV AH,2 
    INT 21H
    ; decrease the counter
    DEC CX
    ; see if the counter is 0
    CMP CX, 0
    JZ  EXIT    ; if zero exit
    ; jump to display another
    JMP  BINARY_DISP
EXIT:
    MOV AH,4CH
    INT 21H     
CODE    ENDS
    END START