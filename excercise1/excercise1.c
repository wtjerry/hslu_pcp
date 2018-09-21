#include <stdio.h>
#include <stdlib.h>

void printNumbersGoto(int n) {
    int i = 0;
loop:
    if (i <= n) {
        printf("%i ", i);
        i++;
        goto loop;
    }
}

void printNumbersFor(int n) {
    for(int i=0; i<=n; i++) {
        printf("%i ", i);
    }
}

void printNumbersRecursiveFunction(int n) {
    if (n >= 0) {
        printNumbersRecursiveFunction(n-1);
        printf("%i ", n);
    }
}

int main(int argc, char** argv) {
    printNumbersGoto(7);
    printf("= printNumbersGoto(7)\n");
    printNumbersFor(7);
    printf("= printNumbersFor(7)\n");
    printNumbersRecursiveFunction(7);
    printf("= printNumbersRecursiveFunction(7)\n");
}
