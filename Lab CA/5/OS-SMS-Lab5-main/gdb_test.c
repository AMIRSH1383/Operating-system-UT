#include "types.h"
#include "stat.h"
#include "user.h"

int main(){
    int pid = getpid();
    printf(1,"Process pid = %d \n" ,pid);
    exit();
}