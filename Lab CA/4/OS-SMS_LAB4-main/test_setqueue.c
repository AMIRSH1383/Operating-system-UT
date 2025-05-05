#include "types.h"
#include "user.h"

int main() {
    int pid = fork();
    if (pid == 0) {
        setqueue(getpid(), 2);  
        while (1);  
    } else {
        wait();   
    }

    exit();
}