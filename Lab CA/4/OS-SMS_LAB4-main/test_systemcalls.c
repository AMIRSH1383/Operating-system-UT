#include "types.h"
#include "stat.h"
#include "user.h"

#define NUM_OF_PROCESSES 10
#define job_ITERATIONS 100000000

void job(int id) 
{
    volatile long long x = 0;
    for (long long i = 0; i < job_ITERATIONS; i++)
    {
        // if(i == 100000 && id == 4)
        // {
        //     printinfo();
        // }
        // if(i == 100000 && id == 5)
        // {
        //     printinfo();
        // }
        // if(i == 100000 && id == 7)
        // {
        //     printinfo();
        // }
        // if(i == 100000 && id == 8)
        // {
        //     printinfo();
        // }
        x += i;
    }
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
            if (getpid() % 2 == 0) 
            {
                printf(1, "Set queue called for process: %d\n" , getpid());
                setqueue(getpid(), 2);
            } 
            if (getpid() % 4 == 0)
            {
                printf(1, "Set burst confidence called for process: %d\n" , getpid());
                setburstconf(getpid(),1,70);
            }
            // Child process
            job(getpid());
            exit();
        }


    }
    while (wait() > 0);
    
    printf(1, "All processes done\n\n");
    exit();
}
