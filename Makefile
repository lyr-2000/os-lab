srcFile=hello.s
# 	dd if=hello.bin of=G:/osLab/OsLab.vhd bs=512 count=1
buildOsBoot:
	nasm hello.asm -o boot.bin


clean:
	rm hello hello.o boot.bin
