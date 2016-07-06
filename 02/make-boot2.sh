java -jar coins.jar -coins:target-arch=x86 -S boot2.c
./gas2nasm.pl boot2.s
nasm -f bin boot2.asm
cat boot1 boot2 > boot; dd if=boot of=fdd.img conv=notrunc
