void _start() {
    int sum = 0;
    for(int i = 1; i < 10; ++i) {
        sum += i;
    }

    asm volatile ("mv x29, %0" :: "r"(sum));
    while(1);
}


