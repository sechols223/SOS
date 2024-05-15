

#include "../lib/terminal.h"
#include "../lib/ctypes.h"

// VGA text mode buffer
volatile uint16_t* const vga_buffer = (uint16_t*) 0xB8000;

// Global cursor position
unsigned int cursor_row = 0;
unsigned int cursor_col = 0;


void outportb(uint16_t port, uint8_t data) {
  __asm__ volatile ("outb %0, %1" 
      :  // No output
      : "a"(data), "Nd"(port));
}

// Function to update the cursor position in hardware
void update_cursor(void) {
  uint16_t position = cursor_row * TERMINAL_COLS + cursor_col;
  outportb(0x3D4, 14);
  outportb(0x3D5, (position >> 8) & 0xFF);
  outportb(0x3D4, 15);
  outportb(0x3D5, position & 0xFF);
}

void terminal_initialize(void) {
  // Clear the entire screen
  for (int row = 0; row < TERMINAL_ROWS; row++) {
    for (int col = 0; col < TERMINAL_COLS; col++) {
      const size_t index = row * TERMINAL_COLS + col;
      // Place a space character with white-on-black attributes at every position
      vga_buffer[index] = ' ' | (WHITE_ON_BLACK << 8);
    }
  }

  // Reset cursor position
  cursor_row = 0;
  cursor_col = 0;

  // Update the hardware cursor to the top-left corner
  update_cursor();
}


// Function to write a null-terminated string to the VGA buffer
void print_str(const char* str) {
  while (*str) {
    // Handle newlines separately
    if (*str == '\n') {
      cursor_col = 0;
      cursor_row++;
    } else {
      // Calculate position in VGA buffer
      const size_t index = cursor_row * TERMINAL_COLS + cursor_col;
      // Combine character and attribute byte
      vga_buffer[index] = (uint16_t)(*str) | (uint16_t)(WHITE_ON_BLACK << 8);
      cursor_col++;
    }

    // Wrap to the next line if the column limit is reached
    if (cursor_col >= TERMINAL_COLS) {
      cursor_col = 0;
      cursor_row++;
    }

    // Handle scrolling (if reaching the end of the screen)
    if (cursor_row >= TERMINAL_ROWS) {
      cursor_row = TERMINAL_ROWS - 1;
      // Implement a simple scroll mechanism if desired
    }

    // Move to the next character in the string
    str++;
  }

  // Update the cursor position in the hardware
  update_cursor();
}
