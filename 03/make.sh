nasm -f bin boot1b.asm
gcc -arch i386 -static -S -m32 keyboard.c
./gas2nasm.pl keyboard.s
nasm -f bin keyboard.asm
cat boot1b keyboard > boot; dd if=boot of=fdd.img conv=notrunc

