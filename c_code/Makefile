CC=riscv32-unknown-elf-gcc
AS=riscv32-unknown-elf-as
LD=riscv32-unknown-elf-ld
OBJCOPY=riscv32-unknown-elf-objcopy
OBJDUMP=riscv32-unknown-elf-objdump

CFLAGS=-march=rv32im

all: main.hex

main.s: main.c
	$(CC) -S -o main.s main.c $(CFLAGS)

main.o: main.s
	$(AS) -o main.o main.s

main.elf: main.o
	$(LD) -T linker.ld -o main.elf main.o

main.hex: main.elf
	$(OBJDUMP) -d main.elf | awk '{print $$2}' | grep '^[0-9a-f]\{8\}$$' > main.hex

clean:
	rm -f main.s main.o main.elf main.hex

