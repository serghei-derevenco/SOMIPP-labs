[org 0x7c00]

mov bx, msg
call printing
call print

mainloop:
    mov bx, prompt
    call printing
    
    call get_string
    jmp mainloop

jmp $

printing:
    pusha

printloop:
    mov al, [bx]
    cmp al, 0
    je make_printing
    mov ah, 0x0e
    int 0x10

    add bx, 1
    jmp printloop

make_printing:
    popa
    ret

print: 			; print new line
    pusha
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    popa
    ret

get_string:
    pusha
    xor cl, cl

    loop:
        mov ah, 0
        int 0x16 

        cmp al, 0x08 ; handle backspace
        je backspace

        cmp al, 0x0d ; handle enter
        je enter

        cmp cl, 0x0ef 
        je loop       
    
        mov ah, 0x0e ; print the character
        int 0x10

        inc cl
        jmp loop

backspace:
    cmp cl, 0 
    je loop

    dec di
    mov byte[di], 0 ; delete char
    dec cl          
    mov ah, 0x0e
    mov al, 0x08
    int 10h

    mov al, ''
    int 10h
    mov al, 0x08    ; print the backspace first time -> move the cursor one position to the left
    int 10h         ; print the backspace twice -> clear the character
    jmp loop

enter:
    mov al, 0
    call print
    popa
    ret 

prompt: db 'serghei$> ', 0
msg: db 'HELLO!!!', 0
times 510-($-$$) db 0
dw 0xaa55
