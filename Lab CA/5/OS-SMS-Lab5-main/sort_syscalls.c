#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
    if (argc != 2) {
        printf(2, "Usage: sort_syscalls <pid>\n");
        exit();
    }
    int pid = atoi(argv[1]);
    int result = sort_syscalls(pid);
    if (result < 0) {
        printf(1, "Failed to sort syscalls for PID %d\n", pid);
    }
    else {
        printf(1, "Successfully sorted syscalls for PID %d\n", pid);
    }
    exit();
}
