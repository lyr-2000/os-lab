// #include "kernel/stringio.h"
#include "kernel/print.h"
#include "init.h"


void main(void) {
    kernel_init();
    
    put_str("hello world!!!\b\b\b\b");
    while(1);
}