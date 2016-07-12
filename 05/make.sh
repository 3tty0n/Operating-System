./cc.sh boot
./cc.sh fdc
./linker -T link-os.ld -o boot.obj boot2d.o boot.o fdc.o
dd if=/dev/zero of=fdd.img count=2880
cat boot1d boot.obj | dd of=fdd.img conv=notrunc
