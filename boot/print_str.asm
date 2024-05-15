

print_str:
  pusha
  mov   ah, 0xe
  jmp   read_char

read_char:
  mov   al, [bx]
  cmp   al, 0
  
  jne   print_char
  popa
  ret


print_char:
  int   0x10 
  add   bx, 1
  jmp   read_char

