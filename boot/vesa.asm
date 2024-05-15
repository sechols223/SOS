
struc VideoModeInfo
  .framebuffer_addr     read 1
  .framebuffer_pitch    read 1
  .framebuffer_width    read 1
  .framebuffer_height   read 1
  .framebuffer_bpp      read 1
endstruc

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

  mov   eax, [es+0x28]
  mov   [VIDEO_MODE_INFO + VideoModeInfo.framebuffer_addr], eax

  ret

.failure:
  mov   ax, 0x0003
  int   0x10 
  jmp   $
