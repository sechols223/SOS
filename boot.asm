bits    16
org     0x7C00

jmp     main

main:
  
  mov   ax, 0x003
  int   0x10

  cli
  mov   ax, 0x9C00
  mov   dx, ax
  mov   es, ax
  mov   fs, ax
  mov   gs, ax


  mov   si, message
  call  print

print:
  lodsb
  or    al, al
  jz    halt

  mov   ah, 0x0E
  mov   bh, 0x0
  mov   bl, 0x02
  int   0x10
  jmp   print

halt: 
  ret 

message:
  db    "SOS", 13, 10, 0

times   510-($-$$) db 0
dw      0xAA55
