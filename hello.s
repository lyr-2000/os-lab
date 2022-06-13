mov ax,0xb800;   指向屏幕文本模式的显示缓冲区
mov es,ax; es 是段寄存器

mov byte [es:0x00],'I'
mov byte [es:0x01],0x07
mov byte [es:0x02],'L'
mov byte [es:0x03],0x06 ; 改成黄颜色
mov byte [es:0x04],'U'


jmp $
times 510 - ($-$$) db 0
 ; 为什么是 510 不是512呢？ 因为最后2个字要填充魔数 ，0xaa55
DW 0XAA55    






