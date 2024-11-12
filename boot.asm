bits 16
org 0x7c00

; mov si, 0

start:
  mov si, message
  call print_string

  call read_string

  mov si, user_input
  call print_string

  jmp $

print_string:
  mov ah, 0x0E

.next_char:
  lodsb
  cmp al, 0
  je .done
  int 0x10
  jmp .next_char

.done:
  ret

read_string:
  mov si, user_input

.read_loop:
  mov ah, 0x01
  int 0x16
  cmp al, 0x0D
  je .done_input
  stosb
  jmp .read_loop

.done_input:
  mov byte [si], 0
  ret



; print:
;   mov ah, 0x0e
;   mov al, [hello + si]
;   int 0x10
;   add si, 1
;   cmp byte [hello + si], 0
;   jne print

; jmp $

; hello:
;   db "Hello World!", 0

message db "Please enter your name: ", 0
user_input db 20 dup(0)

times 510 - ($ - $$) db 0
dw 0xAA55