.PHONY:build burn clean

mbr_source = mbr.s
mbr_target = mbr.bin

loader_source = loader.s
loader_target = loader.bin
hard_disk = ../hd60.img
# hard_disk 是系统盘的盘片

build:
	nasm $(mbr_source) -o $(mbr_target) 
	nasm $(loader_source) -o $(loader_target) 

burn:
	dd if=$(mbr_target) of=$(hard_disk) bs=512 count=1 conv=notrunc
	dd if=$(loader_target) of=$(hard_disk) bs=512 count=2 seek=2 conv=notrunc

image:
	yes | bximage -q -hd=60 -func=create -sectsize=512 -imgmode=flat  ${hard_disk}

run:
	cd .. && pwd &&  bochs -f bochsrc.disk
	
clean:
	
	rm *.bin

