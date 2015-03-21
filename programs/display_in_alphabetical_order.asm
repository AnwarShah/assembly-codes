; Program 13: Write a program to display a '?' also read two capital letters
; display them next line alphabetically order

; This program does not check whether the user has entered correct letters
; Assumes the user always enter two capital letter

CODE    SEGMENT
    ASSUME  CS:CODE
    
START:
    ; display ?
    MOV AH,2
    MOV DL, '?'
    INT 21H
    
    ; read first capital letters
    MOV AH,1
    INT 21H
    MOV BL,AL   ; store first letter in BL
    
    ;read second capital letters
    MOV AH,1
    INT 21H
    MOV BH,AL   ; store second letter in BH
    
    ; go to next line
    MOV AH, 2   ; display character function
    MOV DL, 0DH ; next line
    INT 21H
    MOV DL, 0AH ; CARRIAGE RETURN
    INT 21H
    
    ;compare two letter and display
    CMP BL,BH
    JBE  BL_SMALLER   ; if BL is smaller then jump 
    MOV  DL, BH
    INT 21H
    MOV DL, ' '
    INT 21H
    MOV DL, BL
    INT 21H
    JMP EXIT
    
BL_SMALLER:
    MOV DL, BL
    INT 21H
    MOV DL, ' '
    INT 21H
    MOV DL,BH
    INT 21H

EXIT:
    MOV AH, 4CH;
    INT 21H
        
CODE    ENDS
    END START