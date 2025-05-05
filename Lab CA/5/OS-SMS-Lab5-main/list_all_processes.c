#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
	if(argc != 1){
		printf(2, "You must enter exactly 1 number!\n");
		exit();
	}
    else
    {
		printf(1, "User: list_all_processes() called.\n");
		list_all_processes();
		exit();  	
    }
    exit();
} 