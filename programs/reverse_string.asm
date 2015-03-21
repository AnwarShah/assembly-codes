; Get a string of characters and reverse it and display

STACK   SEGMENT STACK
    DW  100 dup(0)
STACK   ENDS

CODE    SEGMENT
    Assume cs:code, ss:stack

START:
    ;initialize segments
    mov ax,stack
    mov ss, ax
    
    ; display user prompt
    mov ah,2
    mov dl, '?'
    int 21h
    
    ; initialize a character count    
    XOR CX,CX
    
    ; read a character
    mov ah,1
    int 21h
    
WHILE:
    cmp al, 0DH ; is it CR?
    JE  End_WHILE
    push   ax   ; else push the ax into stack
    INC CX  ; increase count
    INT 21H;
    JMP WHILE
    
END_WHILE:
    JCXZ    EXIT    ; if no character read, exit
    ; else prepare for output
    ; go to new line
    mov ah,2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    
    ; pop and display
    
POPPING:
    pop dx
    int 21h
    LOOP POPPING

EXIT:
    mov ah,4ch
    int 21h
CODE   ENDS
    end start
    
                    