#include <tos/tos.h>

int magic = TOS_MAGIC;
char Msg [] = "hell world!!!!";
char buf[1024];
void kernel_init() {
    char *screen = (char *)0xb8000;//显示器内存位置
    for (int i=0;i<sizeof(Msg);i++) {
        screen[i*2] = Msg[i];
    }

}




// void echo(char *str)
// {
//     static uint16_t *videoMemory = (uint16_t *)0xb8000;
//     for (int i = 0; str[i]; i++)
//     {
//         videoMemory[i] = (videoMemory[i] & 0xFF00) | str[i];
//     }
// }


