#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int 
sys_create_palindrome(void)
{
    int number = myproc()->tf->ebx; //register after eax
    cprintf("Kernel: sys_create_palindrome called for number %d\n", number);
    return create_palindrome(number);
}

int
sys_sort_syscalls(void)
{
    int pid;
    // try to extract the first argument of the system call
    int could_fetch = argint(0, &pid);
    if (could_fetch < 0) {
        cprintf("Kernel: Could not extract the 'pid' argument for sort_syscalls\n");
        return -1;
    }
    
    // If the function reachs here, it means the 'pid' argument is available
    cprintf("Kernel: sort_syscalls called for process with ID %d\n", pid);

    // Get the process structure
    // struct proc* p = find_process_by_id(pid);

    return sort_syscalls(pid);
}

int
sys_get_most_invoked_syscall(void)
{
    int pid;
    // try to extract the first argument of the system call
    int could_fetch = argint(0, &pid);
    if (could_fetch < 0)
    {
        cprintf("Kernel: Could not extract the 'pid' argument for get_most_invoked_systemcall\n");
        return -1;
    }

    // If the function reachs here, it means the 'pid' argument is available
    cprintf("Kernel: most_invoked_systemcall called for process with ID %d\n", pid);

    int res = get_most_invoked_syscall(pid);
    if (res < 0)
    {
        cprintf("Kernel: Could not find the most invoked system call for process with ID %d\n", pid);
        return -1;
    }
    else
    {
        cprintf("Kernel: Successfully found the most invoked system call for process with ID %d\n", pid);
        return 0;
    }
}

void
sys_list_all_processes(void)
{
  cprintf("Kernel: sys_list_all_processes called.\n");
  list_all_processes(1);
}

char* sys_open_sharedmem(void) {
    int id;
    if (argint(0, &id) < 0)
        return (char*)(-1); // error but we don't have equivalent in char*

    return open_sharedmem(id);
}

int sys_close_sharedmem(void) {
    int id;
    if (argint(0, &id) < 0)
        return -1;

    return close_sharedmem(id);
}