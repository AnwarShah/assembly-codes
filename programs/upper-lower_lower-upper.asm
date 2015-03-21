; upper case to lower-case and vice-verca

code segment
    assume cs:code
    CR  EQU 0DH
    LF  EQU 0AH
start:
    mov ah,1
    int 21h
    
    TEST al, 32
    JNZ lowercase ; not zero means lowercase
    mov dl,al     ; upper case
    or dl, 32    ; so set  the 5th bit  to convert it to lowercase
    JMP print
    
lowercase:
    mov dl,al
    ; so convert to upper case by removing bit 5
    AND dl, 0DFh
    
   
print:
    mov bl,dl
    mov ah,2
    mov dl, CR
    int 21h
    mov dl, LF
    int 21h
    mov dl,bl
    int 21h

EXIT:
    mov ah,4ch
    int 21h
code ends
    end start
    
        