
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

data segment
    test_msg    db 'This is the time for assembly programming'
    bloc        db  100 dup(0)  ; a block of text
    new         db  41  dup(0)
    
data ends

code segment
    start:
        mov ax,data
        mov ds,ax
        mov es,ax
        
        lea si, test_msg    ; point SI  at source string
        lea di, new     ; point DI  at destination string
        
        mov cx, 41d          ; load count
        cld                 ; clear direction flag
                            ; so that the pointers autoincrement
        rep movsb
        
        
        mov dx, offset new
        mov ah,09h
        int 21h
code ends
    end start
    






