

  section .text
  global _start
  extern main

_start:
  call main

hang:
  jmp hang
