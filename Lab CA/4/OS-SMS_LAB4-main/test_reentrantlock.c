#include "types.h"
#include "stat.h"
#include "user.h"
struct reentrantlock {
    int locked;
    int owner;
    int count;
};
struct reentrantlock rlock;

int fact(int i) {
    if (i <= 0) { return 1; }

    acquire_reentrantlock(&rlock);
    printf(1, "current i %d: acquired lock\n", i);
    int res = fact(i-1);
    release_reentrantlock(&rlock);
    printf(1, "current i %d: released lock\n", i);
    return i * res;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf(1, "please enter a number\n");
        exit();
    }
    int i = atoi(argv[1]);
    printf(1, "i: %d\n", i);
    init_reentrantlock(&rlock);
    printf(1, "calculating %d!...\n", i);
    int res = fact(i);
    printf(1, "finished calculating %d! and the result is %d\n", i, res);
    exit();
}