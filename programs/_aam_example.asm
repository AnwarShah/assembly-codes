CODE    SEGMENT
    ASSUME  CS:CODE
    
    MOV AL,63H
    mov ah,0
    aam
    add ax,3030h
    mov dl,ah
    mov ah,2
    push ax
    int 21h
    pop ax
    mov dl,al
    int 21h
    
CODE    ENDS
