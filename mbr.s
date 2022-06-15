


loader_base_addr equ 0x900
loader_start_sector equ 0x2

section MBR vstart=0x7c00

mov ax,cs
mov ds,ax
mov es,ax
mov ss,ax
mov fs,ax
mov sp,0x7c00
mov ax,axb800
mov gs,ax

;利用 0x06的功能，调用10号中断，清零
; AH=0x06
; AL = 0 表示全部都要清除
; BH= 上卷行的属性
; (CL,CH) 左上角 x,y
; (DL,DH) 右下角


mov ax,0600h
mov bx,0700h
mov cx,0
mov dx,184fh ;(80,25)
int 10h

; 输出当前我们在MBR
mov byte [gs:0x00],'1'
mov byte [gs:0x01],0xA4
mov byte [gs:0x02],' '
mov byte [gs:0x03],0xA4
mov byte [gs:0x04],'B'
mov byte [gs:0x05],0xA4


mov eax,LOADER_START_SECTOR ; lba读入扇区
mov bx LOADER_BASE_ADDR  ; 写入地址
mov cx,1 ; 等待读入的扇区数
call rd_disk
jmp LOADER_BASE_ADDR ;


rd_disk:
;eax LBA 的扇区号码
; bx 数据写入 的内存地址
;cx 数据写入的扇区数
mov esi,eax ; 备份eax
mov di,cx ;备份cx

mov dx,0x1f2
mov al,cl
out dx,al
mov eax,esi

;将 LBA地址存入 0x1f3,0x1f6
; 7-0位 


