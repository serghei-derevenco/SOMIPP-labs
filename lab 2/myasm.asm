org 0x7c00
jmp begin

	hello db "Hello!",0
	text db "Some text",0
	tex db "Other text",0
	texx db "More text",0

begin:
mov al,25
mov bh,0dh
mov ch,0
mov cl,0
mov dh,25h
mov dl,20
mov ah,07h
int 10h

mov dh,2
mov dl,10
mov ah,2
mov bh,0
int 10h
lea si,[hello]

print_first:
	mov al,byte[si]
	mov ah,0eh
	int 10h
	inc si
	cmp al,0
	jz end_first_string
	jmp print_first
end_first_string:
	hlt



mov bh,0eh
mov ch,0
mov cl,20
mov dh,25h
mov dl,30
mov ah,07h
int 10h

mov dh,7
mov dl,20
mov ah,2
mov bh,0
int 10h

mov ah,0ah
mov al,02
mov cx,25h
int 10h
lea si,[text]


print_second:
	
	mov al,byte[si]
	mov ah,0eh
	int 10h
	inc si
	cmp al,0
	jz end_second_string
	jmp print_second
end_second_string:
	hlt


mov bh,0ch
mov ch,0
mov cl,30
mov dh,25h
mov dl,40
mov ah,07h
int 10h

mov dh,12
mov dl,30
mov ah,2
mov bh,0
int 10h

mov ah,09h
mov al,01
mov bl,21h
mov cx,3
int 10h
lea si,[tex]

print_third:
	mov al,byte[si]
	mov ah,0eh
	int 10h
	inc si
	cmp al,0
	jz end_third_string
	jmp print_third
end_third_string:
	hlt


mov bh,0ah
mov ch,0
mov cl,40
mov dh,25h
mov dl,80
mov ah,07h
int 10h

mov dh,17
mov dl,40
mov ah,2
mov bh,0
int 10h
lea si,[texx]


print_fourth:
	mov al,byte[si]
	mov ah,0eh
	int 10h
	inc si
	cmp al,0
	jz end_fourth_string
	jmp print_fourth
end_fourth_string:
	hlt


