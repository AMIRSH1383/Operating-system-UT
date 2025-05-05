#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char** argv)
{
    printf(1,"History of commands:\n");
    for(int i = 1; i < argc ; i++)
        printf(1, "%d.%s \n" , i,argv[i]);
    exit();
}