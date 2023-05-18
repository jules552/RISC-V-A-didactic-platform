int main();

void _start() {
    main();
    while (1){}
}

int main() {
    int sum = 0;
    for(int i = 1; i < 10; ++i) {
        sum += i;
    }

    return sum;
}