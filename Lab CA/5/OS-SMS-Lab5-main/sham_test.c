#include "types.h"
#include "stat.h"
#include "user.h"

#define NPROCESS 5
#define ID       30

void test_sharedmem(void) {
    char* adr = open_sharedmem(ID);
    adr[0] = 1;
    printf(1, "%d\n", adr[0]);

    for (int i = 0; i < NPROCESS; i++) {
        if (fork() == 0) {
            sleep(100 * i);
            char* adrs = open_sharedmem(ID);
            adrs[0] *= (i+1);
            printf(1, "%d\n", adrs[0]);
            close_sharedmem(ID);
            exit();
        }
    }
    for (int i = 0; i < NPROCESS; i++)
        wait();
    close_sharedmem(ID);
}

int main(int argc, char* argv[]) {
    test_sharedmem();
    exit();
}