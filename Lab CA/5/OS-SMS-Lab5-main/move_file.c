#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "stat.h"

int main(int argc , char *argv[])
{
    if(argc < 3)
    {
        printf(1,"source and destination are needed\n");
        exit();
    }
    char *src_file = argv[1];
    char *dest_dir = argv[2] ;
    if (move_file(src_file,dest_dir) < 0 )
    {
        printf(1,"move file failed\n");
        exit();
    }
    printf(1,"file %s moved to %s successfully\n",src_file,dest_dir);
    exit();
}