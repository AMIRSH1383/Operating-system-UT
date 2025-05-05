#include "types.h"
#include "stat.h"
#include "user.h"

#define NUM_PROCESSES 5

int main() {
    printf(1,"Creating %d processes...\n", NUM_PROCESSES);

    for (int i = 0; i < NUM_PROCESSES; ++i) {
        int pid = fork();
        if (pid == 0) {
            sleep(500);
            for (int j = 0; j < 100000 * (i + 1); ++j) {
                int temp = j % 123;
                temp++;
            }
            exit();
        } else if (pid > 0) {
            int burst_time = (i + 1) * 100;
            int confidence = 90 - (i * 10);
            if (setburstconf(pid, burst_time, confidence) < 0) {
                printf(1,"Error: Unable to set burst_time and confidence for PID %d\n", pid);
            } else {
                printf(1,"Set burst_time=%d and confidence=%d for PID %d\n", burst_time, confidence, pid);
            }
        } else {
            printf(1,"Error: Fork failed\n");
        }
    }

    printf(1,"\n[INFO] Printing process info after setting burst_time and confidence:\n");
    printinfo();

    for (int i = 0; i < NUM_PROCESSES; ++i) {
        wait();
    }

    printf(1,"\n[INFO] Printing process info after all children have exited:\n");
    printinfo();

    printf(1,"All child processes have completed.\n");
    exit();
}