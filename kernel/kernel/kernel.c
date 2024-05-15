
#include "../lib/terminal.h"
#include "../lib/ctypes.h"

typedef struct {
  uint32_t framebuffer_addr;
  uint32_t framebuffer_pitch;
  uint32_t framebuffer_width;
  uint32_t framebuffer_height;
  uint32_t framebuffer_bpp;
} VideoModeInfo;

extern VideoModeInfo* const vmi = (VideoModeInfo*)0x7E00;

//const VideoModeInfo* vmi = VIDEO_MODE_INFO;

void put_pixel(uint32_t x, uint32_t y, uint32_t color)
{
  uint8_t* pixel_address = (uint8_t*)(vmi->framebuffer_addr + y *vmi->framebuffer_pitch + x * (vmi->framebuffer_bpp / 8));
  *(uint32_t*)pixel_address = color;
}

void draw_rectangle(uint32_t x, uint32_t y, uint32_t width, uint32_t height, uint32_t color) {
    for (uint32_t j = 0; j < height; j++) {
        for (uint32_t i = 0; i < width; i++) {
            put_pixel(x + i, y + j, color);
        }
    }
}

void main()
{

  draw_rectangle(100, 50, 200, 150, 0xFF0000FF);
}
