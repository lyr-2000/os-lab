%include "boot.inc"
%include "hd.inc"
SECTION MBR vstart=0x7c00
mov ax,cs
mov es,ax
mov ss,ax
mov sp,0x7c00

;scroll the screen
mov ah,0x6
mov al,0x0
mov bx,0x700
mov cx,0x0
mov dx,0x184f

int 0x10


;print the context by int 
; mov ax,message
; mov bp,ax
; mov ah,0x13
; mov al,1
; mov bx,0x2
; mov cx,7
; mov dh,5
; mov dl,5
; int 0x10

;print the context by memory
mov ax,0xb800
mov es,ax

mov al,16
mov ah,40
call trans
mov bp,ax
mov byte [es:bp],'1'
mov byte [es:bp+1],0xA4

mov byte [es:bp+2],' '
mov byte [es:bp+3],0xA4

mov byte [es:bp+4],'M'
mov byte [es:bp+5],0xA4	   ;A表示绿色背景闪烁，4表示前景色为红色

mov byte [es:bp+6],'B'
mov byte [es:bp+7],0xA4

mov byte [es:bp+8],'R'
mov byte [es:bp+9],0xA4

mov eax,LOADER_START_SECTOR	 ; 起始扇区lba地址
mov bx,LOADER_BASE_ADDR       ; 写入的地址
mov cx,2			 ; 待读入的扇区数
call rd_disk_m_16		 ; 以下读取程序的起始部分（一个扇区）


jmp LOADER_BASE_ADDR
; message db "1 MBR 1"



trans:
    ;trans function
    ;al is the row and ah is the col
    ;al*80+ah:how many char before char we want to print
    ;2*(al*80+ah) +  0xb800 = address of the target char
    ;address + 1 = attribute of the target char
    ;put address of target char in ax
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

rd_disk_m_16:	   
      
      mov esi,eax	  ;备份eax
      mov di,cx		  ;备份cx

;读写硬盘:
;第1步：设置要读取的扇区数
      mov dx,port_num_of_sector_to_read
      mov al,cl
      out dx,al            ;读取的扇区数

      mov eax,esi	   ;恢复ax

;第2步：将LBA地址存入0x1f3 ~ 0x1f6

      ;LBA地址7~0位写入端口0x1f3
      mov dx,0x1f3                       
      out dx,al                          

      ;LBA地址15~8位写入端口0x1f4
      mov cl,8
      shr eax,cl    
      mov dx,0x1f4
      out dx,al

      ;LBA地址23~16位写入端口0x1f5
      shr eax,cl
      mov dx,0x1f5
      out dx,al

      shr eax,cl
      and al,0x0f	   ;lba第24~27位
      or al,0xe0	   ; 设置7～4位为1110,表示lba模式
      mov dx,0x1f6
      out dx,al

;第3步：向port_read_check端口写入读命令，0x20 
      mov dx,port_read_check
      mov al,0x20                        
      out dx,al

;第4步：检测硬盘状态
  .not_ready:
      ;同一端口，写时表示写入命令字，读时表示读入硬盘状态
      nop             
      in al,dx        
      and al,0x88	   ;第3位为1表示硬盘控制器已准备好数据传输，第7位为1表示硬盘忙
      cmp al,0x08
      jnz .not_ready	   ;若未准备好，继续等。

;第5步：从port_read端口读数据
      mov ax, di
      mov dx, 256
      mul dx
      mov cx, ax	   ; di为要读取的扇区数，一个扇区有512字节，每次读入一个字，
			   ; 共需di*512/2次，所以di*256
      mov dx, port_read
  .go_on_read:
      in ax,dx
      mov [bx],ax
      add bx,2		  
      loop .go_on_read
      ret

times 510-($-$$) db 0
db 0x55,0xaa