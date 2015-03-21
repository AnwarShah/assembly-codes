; Write a program which prompts user to enter two binary 
; number upto 8 digits each and display the sum in the next line
; 
DATA    SEGMENT
    msg1     db  'TYPE A BINARY NUMBER, UP TO 8 DIGITS: $'
    MSG2    db  0DH,0AH,'THE BINARY SUM IS  $'
    SUM     db  ?,'$'
    NewLine db  0AH,0DH,'$'
DATA    ENDS

CODE    SEGMENT
        ASSUME  CS:CODE, DS:DATA
START:
    ; initialize data segment
    MOV AX, DATA
    MOV DS,AX
    
    XOR BX,BX   ; BX contain both the numbers in BL,BH
    
    ;prompt user
    MOV AH,9
    MOV DX, OFFSET MSG1
    INT 21H
    
    ;; read the value
    MOV cl, 8   ; counter for 8 bits
READ1:
    MOV AH,1
    INT 21H
    ; check if it is CR
    CMP AL, 0DH 
    JZ  prompt
    ; convert to binary
    AND AL, 0FH
    SHL BL,1
    OR  BL, AL  ; insert it into BL
    LOOP    READ1                             
PROMPT:    
    ; again set the counter for another 8 bits
    MOV cl, 8
    ;prompt user again
    MOV AH,9
    MOV DX, OFFSET NewLine
    INT 21H
    MOV DX, OFFSET  msg1
    INT 21H
    
READ2:
    MOV AH,1
    INT 21H    
    ; check if it is CR
    CMP AL, 0DH 
    JZ  ADD_NUMBERS
    ; convert to binary
    AND AL, 0FH
    SHL BH,1
    OR  BH, AL  ; insert it into BH
    LOOP READ2                             

ADD_NUMBERS:
    ADD BH,BL   ; add and store it in BH
    MOV BL,BH   ; store sum for future need
    
DISPLAY_SUM:
    ; display message
    MOV DX, OFFSET MSG2
    MOV AH, 9
    INT 21H
    ; check whether any carry are there
    JC Carry
    JMP NO_CARRY
CARRY:
    MOV AH, 2
    MOV DL, '1'
    INT 21H
    
NO_CARRY:    
    ; set counter for 8 digits
    MOV CL, 8
    MOV AH,2    ; select disp funct once
PRINT_LOOP:
    RCL BH,1    ; get the msb in CF
    JC  ONE ;   if carry, it is one
    MOV DL, '0' ; otherwise it is zero
    JMP PRINT   ; go to print
ONE:
    MOV DL, '1'
PRINT:
    INT 21H     ; display
    LOOP    PRINT_LOOP
                               
EXIT:
    MOV AH, 4CH
    INT 21H    
CODE    ENDS
    END START