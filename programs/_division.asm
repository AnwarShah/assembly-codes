    ;8086 Program
;ABSTRACT ; Add two numbers and calculate their average
;REGISTERS  ; DS,CS,AX,BL

DATA    SEGMENT
    NUMBER1 DB  34H ; first number
    NUMBER2 DB  23H ; second number
    AVG_NUMB    DB  ?
DATA    ENDS

CODE    SEGMENT
    ASSUME  CS:CODE, DS:DATA

START:  MOV AX,DATA ;
        MOV DS,AX   ; initialize data segments
        MOV AL, NUMBER1 
        ADD AL, NUMBER2 ; add two numbers
        MOV AH, 00H     ; clear AH
        ADC AH, 00H     ; put carry into AH
        MOV BL, 02H     ; mov divisor in BL reg
        DIV BL          ; Divide AX by BL, quotient in AL, remainder in AH
        
        MOV AVG_NUMB, AL ; copy result to memory
CODE ENDS
                           
    END START