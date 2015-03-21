;   Problem 7
;   Compare two numbers in AX and BX, and put the biggest one in CX and display it
;   This program assumes that the numbers are in hex and does not contain A-F

DATA    SEGMENT
    digit1  db  ?
    digit2  db  ?
    digit3  db  ?
    digit4  db  ?,'$'
DATA    ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:
    MOV AX,DATA ; initialize data segment
    MOV DS,AX   ;
        
    MOV AX, 8790H   ; Signed number in AX
    MOV BX, 9340H   ; Another number in BX
    
    CMP AX,BX   ; Compare AX and BX
    JL BIGGER   ; if AX is less than BX jump to BIGGER 
    MOV CX,AX   ; else Store AX in CX
    JMP DISPLAY ; display it
    
BIGGER: 
    MOV CX,BX   ; BX is bigger
DISPLAY:
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
    
    ; display the 4 digit display
    MOV DX, OFFSET  digit1
    MOV AH, 9
    INT 21H
    
    HLT
CODE ENDS
    END START