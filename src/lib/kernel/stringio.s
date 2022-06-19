BITS 16

[global screen_print]
[global screen_putchar]
[global screen_getchar]

screen_getchar: ; 从键盘读入一个支付到 tempc变量，使用 16号中断
    mov ah,0 ; 功能号
    int 16h
    mov ah,0
    retf
screen_putchar:
    pusha ; 保护现场，缓存所有寄存器的值
    mov bp,sp ;栈顶
    add bp,16+4; 参数地址
    mov al,[bp] ; al= char
    mov bh,0 ; bh= 页码
    mov ah,0EH ;功能号
    int 10h
    
    popa
    retf
screen_print:
    pusha ; msg,len,x,y
    mov si,sp ; print in pos
    add si,16+4 ; 首个参数地址
    mov ax,cs
    mov ds,ax
    mov bp,[si] ; bp指向 当前串的便宜地址  
    mov ax,ds ; es,bp
    mov es,ax ; 置 es=ds
    mov cx,[si+4]; cx,串长度
    mov ax,1301h ;AH = 13(功能号) ，al=01h (字符串显示光标)
    mov bx,0007h ; bh=0 ,表示0号页 ，bl=7 ,黑底白字
    mov dh,[si+8] ; 行号=0
    mov dl,[si+12] ; 列好=0 
    int 10h ; interrupt 使用 bios 10h显示一行字符
    popa
    retf

;extern void screen_print(char *msg,uint16_t row,pos row,pos col)
;extern void screen_putchar(char c)
;extern void screen_getchar()