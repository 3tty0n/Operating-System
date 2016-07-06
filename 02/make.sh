nasm -f bin boot1.asm
hexdump -C boot1
java -jar coins.jar -coins:target-arch=x86 -S boot2.c
./gas2nasm.pl boot2.s
nasm -f bin boot2.asm
dd if=/dev/zero of=fdd.img count=2880
cat boot1 boot2 > boot; dd if=boot of=fdd.img conv=notrunc
