bits 16
org 0x7C00

extern _start

jmp main

main:

  cli
  mov   ax, 0x9C00
  mov   dx, ax
  mov   es, ax
  mov   fs, ax
  mov   gs, ax


  

  mov si, message
  call print

  call _start

print:
  lodsb
  or al, al
  jz halt

  mov ah, 0x0E
  mov bh, 0
  int 0x10
  jmp print

halt: 
  ret 

message:
  db "SOS", 13, 10, 0

times 510-($-$$) db 0
dw 0xAA55
