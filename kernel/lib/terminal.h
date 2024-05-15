
#ifndef _TERMINAL_H
#define _TERMINAL_H

#define VGA_ADDRESS     0xB8000
#define TERMINAL_ROWS   25
#define TERMINAL_COLS   80
#define WHITE_ON_BLACK  0x0F

void terminal_initialize();
void print_str(const char* str);
#endif
