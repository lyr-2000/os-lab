bootFile=boot.s
loaderFile=loader.s
destFile=G:\\osLab\os.vhd

# 	dd if=hello.bin of=G:/osLab/OsLab.vhd bs=512 count=1
asm:
	nasm ${bootFile} -o boot.bin
	nasm ${loaderFile} -o loader.bin

out:
	dd if=./boot.bin of=${destFile}  bs=512 count=1 conv=notrunc	
	dd if=./loader.bin of=${destFile}  bs=512 count=4 seek=2 conv=notrunc	
	

clean:
	rm hello hello.o boot.bin
