#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"


void writeDecode(int fd, int key, char* sentence) {
    for (int i = 0;sentence[i] != '\0' ; i++) {
        char temp ;
        temp = sentence[i];
        if (temp >= 'a' && temp <= 'z'){
            if ((temp - 'a' - key ) < 0  )
                temp = (temp - 'a' - key + 26 )%26 +'a';
            else
                temp = (temp - 'a' - key ) % 26 + 'a';
        }    
        else if (temp >= 'A' && temp <= 'Z'){
                if((temp - 'A' - key ) < 0)
                    temp = (temp - 'A' - key + 26) % 26 + 'A';
                else
                    temp = (temp - 'A' - key ) % 26 + 'A';
        }
        sentence[i] = temp;
        }
        printf(fd, "%s ", sentence);
    }

int main(int argc, char* argv[]) {

    int key = (51+ 20 + 65) % 26 ; 
    unlink("result.txt");
    int fd = open("result.txt", O_CREATE | O_WRONLY);
    if (fd < 0) {
        printf(1, "result: cannot create result.txt\n");
        exit();
    }
    for (int i = 0 ; i <argc - 1 ; i++){
        writeDecode(fd, key, argv[i+1]);
    }
    write(fd, "\n", 1);
    close(fd);

    exit();
}