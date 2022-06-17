%include "boot.inc"
section loader vstart=LOADER_BASE_ADDR
LOADER_STACK_TOP equ LOADER_BASE_ADDR
jmp loader_start

GDT_BASE:
    dd 0x00000000
    dd 0x00000000
CODE_DESC:
    dd 0x0000ffff
    dd code_high4
DATA_STACK_DESC:
    dd 0x0000FFFF
    dd data_high4
VIDEO_DESC:
    dd 0x80000007
    dd vedio_high4

GDT_SIZE equ $ - GDT_BASE
GDT_LIMIT equ GDT_SIZE-1
times 60 dq 0
SELECTOR_CODE equ (0x0001<<3) + TI_GDT + RPL0         ; 相当于(CODE_DESC - GDT_BASE)/8 + TI_GDT + RPL0
SELECTOR_DATA equ (0x0002<<3) + TI_GDT + RPL0	 ; 同上
SELECTOR_VIDEO equ (0x0003<<3) + TI_GDT + RPL0

gdt_ptr dw GDT_LIMIT
        dd GDT_BASE

loader_start:

    mov al,10
    mov ah,10

    call trans
    mov bp,ax

    mov byte [es:bp],'l'
    mov byte [es:bp+1],0xA4

    mov byte [es:bp+2],'o'
    mov byte [es:bp+3],0xA4

    mov byte [es:bp+4],'a'
    mov byte [es:bp+5],0xA4	   ;A表示绿色背景闪烁，4表示前景色为红色

    mov byte [es:bp+6],'d'
    mov byte [es:bp+7],0xA4

    mov byte [es:bp+8],'e'
    mov byte [es:bp+9],0xA4

    mov byte [es:bp+10],'r'
    mov byte [es:bp+11],0xA4

    ;-----------------  打开A20  ----------------
    in al,0x92
    or al,0000_0010B
    out 0x92,al
    ;-----------------  加载GDT  ----------------
    lgdt [gdt_ptr]

    ;-----------------  cr0第0位置1  ----------------
    mov eax, cr0
    or eax, 0x00000001
    mov cr0, eax

   mov byte [es:bp+12],'p'
   mov byte [es:bp+13],0xA4

    jmp $

jmp  SELECTOR_CODE:p_mode_start	

trans:
   push bx
   push cx
   and cx,0
   mov cl,ah
   mov bl,80
   mov bh,25
   mul bl
   add ax,cx
   mov bx,2
   mul bx
   pop cx
   pop bx
   ret

[bits 32]
p_mode_start:
   mov ax, SELECTOR_DATA
   mov ds, ax
   mov gs, ax
   mov ss, ax
   mov esp,LOADER_STACK_TOP
   mov ax, SELECTOR_VIDEO
   mov es, ax

   jmp $