[bits 32]

extern kernel_init
global _start
_start:
    xchg bx,bx
    call kernel_init
    xchg bx,bx
        ; mov byte [0xb8000], 'K'
    jmp $ ; 阻塞


