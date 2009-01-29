#include <ctype.h>
#include <string.h>

int return3()
{
  return 3;
}


// for x86-64
// 6 register arguments + 2 stack arguments
int add8(int x1, int x2, int x3, int x4, int x5, int x6, int x7, int x8)
{
  printf("%d %d %d %d %d %d %d %d \n", x1, x2, x3, x4, x5, x6, x7, x8);
  return x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8;
}


int sub(int a, int b)
{
  return a - b;
}

int sub3(int a, int b, int c)
{
  return a - b - c;
}

int string_length(const char* text)
{
    return strlen(text);
}

void my_upper(char* text, int length)
{
    int i;
    for (i = 0; i < length; i++) {
        text[i] = toupper(text[i]);
    }
}

void* pointer()
{
  return (void*)0x12345678;
}

void* return_pointer_string()
{
  return "hello";
}

void* return_array_of_pointer_string()
{
  static char* p[2];
  p[0] = "hello";
  p[1] = "world";
  return (void*)p;
}