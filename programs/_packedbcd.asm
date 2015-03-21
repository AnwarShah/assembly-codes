CODE SEGMENT
    ASSUME CS:CODE
    
    MOV BL, '5'
    MOV AL, '9'
    AND BL, 0FH  ; mask upper 4 bits of BL
    AND AL, 0FH  ; mask upper 4 bits of AL
    ROL BL, 04H ; Rotate BL 4 times
    OR AL, BL   ; Combines nibbles, result in AL
CODE    ENDS
