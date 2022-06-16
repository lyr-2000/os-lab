;--------------loader------------------------
LOADER_BASE_ADDR equ 0x900
LOADER_START_SECTOR equ 0x2


;-------------section descriptor high 4--------
G equ 1_00000000000000000000000b
D equ 1_0000000000000000000000b
L equ 0
AVL equ 0
P equ 1_000000000000000b
DESC_DPL_0  equ		   00_0000000000000b
DESC_DPL_1  equ		   01_0000000000000b
DESC_DPL_2  equ		   10_0000000000000b
DESC_DPL_3  equ		   11_0000000000000b
S equ 1_000000000000b
Type_Code equ 1000_00000000b
Type_Data equ 0010_00000000b

limit2 equ 1111_0000000000000000b
vedio_limit2 equ 0;


code_high4 equ (0x00<<24)+G+D+L+AVL+limit2+P+DESC_DPL_0+Type_Code+0x00
data_high4 equ (0x00<<24)+G+D+L+AVL+limit2+P+DESC_DPL_0+Type_Data+0x00
vedio_high4 equ (0x00<<24)+G+D+L+AVL+vedio_limit2+P+DESC_DPL_0+Type_Data+0x00
;--------------   选择子属性  ---------------
RPL0  equ   00b
RPL1  equ   01b
RPL2  equ   10b
RPL3  equ   11b
TI_GDT	 equ   000b
TI_LDT	 equ   100b