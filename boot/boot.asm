  bits  16
  org   0x7C00

struc VideoModeInfo
  .framebuffer_addr     resd 1
  .framebuffer_pitch    resd 1
  .framebuffer_width    resd 1
  .framebuffer_height   resd 1
  .framebuffer_bpp      resd 1
endstruc

  VIDEO_MODE_INFO   equ 0x7E00
  KERNEL_OFFSET     equ 0x1000
  VIDEO_MODE        equ 0x118
  jmp   main

main:
  
  mov   [BOOT_DRIVE], dl


  mov   bp, 0x9000
  mov   sp, bp

  call load_vesa

  call load_kernel

  call  switch_pm

  jmp $


%include "print_str.asm"
%include "disk.asm"
%include "gdt.asm"
%include "switch_pm.asm"
%include "print_str_pm.asm"

bits    16
load_vesa:
  mov   ax, 0x4F02
  mov   bx, VIDEO_MODE
  int   0x10 
  jc    .failure

  mov   ax, 0x4F01
  mov   cx, VIDEO_MODE
  mov   di, VIDEO_MODE_INFO
  int   0x10
  jc    .failure

  mov   eax, [es:di+0x28]
  mov   [VIDEO_MODE_INFO + VideoModeInfo.framebuffer_addr], eax

  ret

.failure:
  mov   ax, 0x0003
  int   0x10 
  jmp   $

load_kernel:
  ;mov   bx, LOAD_KERNEL_MSG
  ;call  print_str
  
  mov   bx, KERNEL_OFFSET
  mov   dh, 1
  mov   dl, [BOOT_DRIVE]

  call  load_disk
  ret

bits    32
BEGIN_PM:
  ;mov   ebx, PROT_MSG
  ;call  print_str_pm
  
  call KERNEL_OFFSET

  jmp   $

BOOT_DRIVE          db 0x0

INIT_MSG:           db "S.O.S", 0xa, 0xd, 0x0
PROT_MSG:           db "Entering protected mode..", 0x0
LOAD_KERNEL_MSG:    db "Loading kernel..", 0xa, 0xd, 0x0

times   510-($-$$) db 0x0
dw      0xAA55

