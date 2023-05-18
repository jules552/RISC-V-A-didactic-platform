MEMORY
{
    ROM (rx) : ORIGIN = 0x00000000, LENGTH = 4K
    RAM (rwx) : ORIGIN = 0x00001000, LENGTH = 4K
}

SECTIONS
{
    . = ORIGIN(ROM);

    .text :
    {
        *(.text*)
    } > ROM

    . = ORIGIN(RAM);

    .data :
    {
        *(.data*)
    } > RAM

    .bss :
    {
        *(.bss*)
    } > RAM
}