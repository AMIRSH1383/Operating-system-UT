#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define NUM_PROCESSES 5
#define FILE_PREFIX "process_file_"

void write_to_file(const char *filename, const char *content) {
    int fd = open(filename, O_CREATE | O_RDWR);
    if (fd < 0) {
        printf(1, "Error: Could not open file %s\n", filename);
        exit();
    }
    if (write(fd, content, strlen(content)) < 0) {
        // printf(1, "Error: Could not write to file %s\n", filename);
        close(fd);
        exit();
    }
    close(fd);
}

int main() {
    for (int i = 0; i < NUM_PROCESSES; i++) {
        int pid = fork();
        if (pid < 0) {
            printf(1, "Error: fork failed\n");
            exit();
        }
        if (pid == 0) {
            // Child process
            char filename[20] = FILE_PREFIX;
            filename[13] = i + '0';
            char content[50] = "This is process writing to its file.";            
            write_to_file(filename, content);
            exit();
        }
    }
    
    for (int i = 0; i < NUM_PROCESSES; i++) {
        wait();
    }
    
    printf(1, "All processes have completed writing to their files.\n");
    count_syscalls();
    exit();
}
