void _start() {
    asm volatile("call main");    
    while (1);
}

int main() {
    int sum = 0;
    for(int i = 1; i < 10; ++i) {
        sum += i;
    }

    return sum;
}