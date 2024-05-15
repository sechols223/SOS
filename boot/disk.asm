

load_disk:
  pusha

  push  dx

  mov   ah, 0x02
  mov   al, dh
  mov   ch, 0
  mov   dh, 0
  mov   cl, 2

  int   0x13 
  
  pop   dx
  jc    disk_error
  
  cmp   al, dh
  jne   disk_error

  popa
  ret

disk_error:
  mov   bx, ERROR_MSG
  call  print_str

  jmp   $

ERROR_MSG: db "Unable to load disk", 0x0
