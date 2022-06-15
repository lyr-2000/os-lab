[org 0x7c00]

; 设置屏幕模式为文本模式，清除屏幕
mov ax, 3
int 0x10

; 初始化段寄存器
mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00
; 800 是文本显示器呢次
mov ax,0xb800
mov ds,ax
mov byte [0],'H'
mov byte [2],'I'

jmp $
times 510 - ($-$$) db 0
 ; 为什么是 510 不是512呢？ 因为最后2个字要填充魔数 ，0xaa55
; DW 0XAA55    

db 0x55,0xaa





