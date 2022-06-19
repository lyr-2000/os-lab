
#include "stdint.h"
#define pos uint8_t

extern void screen_print(char *msg,uint16_t len,pos row,pos col);
extern void screen_putchar(char c);
extern void screen_getchar();

#undef pos


inline uint16_t strlen(char *s) {
    if(!s) return 0;
    int cnt=0;
    while(s[cnt++] != '\0');
    return cnt-1;
}





