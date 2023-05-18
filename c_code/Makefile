CC=riscv32-unknown-elf-gcc
AS=riscv32-unknown-elf-as
LD=riscv32-unknown-elf-ld
OBJCOPY=riscv32-unknown-elf-objcopy
OBJDUMP=riscv32-unknown-elf-objdump

CFLAGS=-march=rv32im -O2

all: build main.hex

build:
	mkdir -p build

build/main.s: main.c
	$(CC) -S -o build/main.s main.c $(CFLAGS)

build/main.o: build/main.s
	$(AS) -o build/main.o build/main.s

build/main.elf: build/main.o
	$(LD) -T linker.ld -o build/main.elf build/main.o

build/main.hex: build/main.elf
	$(OBJDUMP) -d build/main.elf | awk '{print $$2}' | grep '^[0-9a-f]\{8\}$$' > build/main.hex

main.hex: build/main.hex
	cp build/main.hex .

clean:
	rm -rf build/*
	rm -f main.hex

.PHONY: all clean