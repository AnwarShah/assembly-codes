; IF AL contain 1 or 3 display 'O' , if AL containt 0 or 4 display '1'

CODE SEGMENT
        MOV AH,2    ; character display fuction
        MOV DL,'?'  ; display '?'
        INT 21H     ; display
        
        MOV AH,1    ; read value
        INT 21H     ; execute
                
        TEST AL, 1  ;
        JZ EVEN     ; if AL in Even jump to Even        
        MOV AH, 2   ; otherwise display 'O'
        MOV DL, 0AH ; Line feed 
        int 21H     ;
        MOV DL, 0DH ; carrage return
        int 21h     ;    
        MOV DL, 'O'
        INT 21H     ;
        JMP EXIT
        
   EVEN:
        MOV AH,2    ;
        MOV DL,0AH  ; line feed
        INT 21H     ;
        MOV DL, 0DH ; c.R
        INT 21H
        MOV DL, 'E'
        INT 21H
    EXIT:
        HLT
        
CODE ENDS
    END