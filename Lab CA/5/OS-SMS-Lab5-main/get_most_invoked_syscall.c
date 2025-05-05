#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
    if (argc != 2) {
        printf(2, "Usage: get_most_invoked_syscall <pid>\n");
        exit();
    }
    int pid = atoi(argv[1]);
    int result = get_most_invoked_syscall(pid);

    if (result < 0) {
        // printf(1, "Failed to find the most invoked syscall for PID %d\n", pid);
    } else {
        // printf(1, "Successfully found the most invoked syscall for PID %d\n", pid);
    }

    exit();
}
