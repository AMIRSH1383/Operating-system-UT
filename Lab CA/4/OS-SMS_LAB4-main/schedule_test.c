#include "types.h"
#include "stat.h"
#include "user.h"

#define NUM_OF_PROCESSES 60
#define job_ITERATIONS 10000000

void job(int id) 
{
    volatile long long x = 0;
    for (long long i = 0; i < job_ITERATIONS; i++)
        x += i;
}

int main(void) 
{
    int pid;
    for (int i = 0; i < NUM_OF_PROCESSES; i++) 
    {
        pid = fork();
        if (pid < 0) 
        {
            printf(1, "Fork failed\n");
            exit();
        } 
        else if (pid == 0) 
        {
            // Child process
            job(i);
            exit();
        }
    }
    
    while (wait() > 0);
    
    printf(1, "All processes done\n\n");
    exit();
}
