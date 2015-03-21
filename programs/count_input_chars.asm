; A Program that counts the number of entered characters and display it
; Note : This program assumes, input characters are either a character (including digits)
;        or a Carriage return

DATA    SEGMENT
    MSG     DB  0ah,0dh,'The number of characters entered is '
    digit1    DB  ?
    digit2    DB  ?
    digit3    DB  ?
    digit4    db  ? , '$'
DATA    ENDS

CODE    SEGMENT
    ASSUME  CS:CODE, DS:DATA

START:    
    ; initialize data segment
    MOV AX, DATA
    MOV DS, AX
    XOR CX,CX
READ:
    MOV AH,1;
    INT 21H     ; read input
    CMP AL, 0DH ; test whether enter key is pressed
    JZ  DISPLAY ; if yes go to display message 
    INC CX
    MOV AX,CX
    DAA
    MOV CX,AX
    JMP READ
    
DISPLAY:
    ; convert the count in ASCII
    MOV BL,CL   ; store in BL for convertion leftmost digit
    
    ; convert 1st digit
    AND BL,0FH  ; mask high 4 bits
    OR  BL,30H  ; set 3 in high 4 bits
    MOV digit4, BL; store in digit1
    
    ; convert 2nd digit
    MOV BL,CL   ; store in BL for convertion of 2nd digit
    AND BL, 0F0H ; mask left 4 bits
    SHR BL, 4   ;   right shift 4 bits
    OR  BL, 30H ; convert to ascii
    MOV digit3, BL
    
    ; convert 3rd digit
    MOV BL,CH   
    AND BL, 0FH
    OR  BL, 30H
    MOV digit2, BL
    
    ; convert 4th digit
    MOV BL,CH
    SHR BL, 4
    AND BL,0FH
    OR  BL, 30H;
    mov digit1, BL
    
    ;; display message
    LEA DX, MSG
    MOV AH,9    ; string display function
    INT 21H;
    
EXIT:
    MOV AH, 4CH;
    INT 21H
    
CODE    ENDS
    END START