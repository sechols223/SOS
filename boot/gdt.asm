gdt_start:

gdt_null:
  dd 0x0
  dd 0x0   ; 8 byte gdt entries

gdt_code:  ; code segment descriptor



  dw 0xffff                  ; bytes 0-1: segment limit 15:00
  dw 0x0                     ; bytes 2-3: base address 15:00
  db 0x0                     ; byte 4: base address 23:16
  db 10011010b               ; byte 5: 1st flags and type flags
  db 11001111b               ; byte 6: 2nd flags and highest four bits of segment limit (0xf)
  db 0x0                     ; byte 7: base address 31:24

gdt_data:  ; data segment descriptor

  dw 0xffff
  dw 0x0
  db 0x0
  db 10010010b               ; byte 5: 1st flags and type flags
  db 11001111b
  db 0x0

gdt_end:   

gdt_descriptor:

  dw gdt_end - gdt_start - 1 
  dd gdt_start               

CODE_SEG equ gdt_code - gdt_start ; 0x08
DATA_SEG equ gdt_data - gdt_start  ; 0x10
