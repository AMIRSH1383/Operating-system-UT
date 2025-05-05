#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "reentrantlock.h"

extern struct cpu cpus[NCPU];
extern int ncpu;
extern struct spinlock main_lock;
extern struct spinlock cpu_lock;
extern int numof_all_syscalls;

int sys_init_reentrantlock(void) {
    struct reentrantlock *rlock;
    if (argptr(0, (void*)&rlock, sizeof(*rlock)) < 0) { return -1; }
    init_reentrantlock(rlock);
    return 0;
}

int sys_acquire_reentrantlock(void) {
    struct reentrantlock *rlock;
    if (argptr(0, (void*)&rlock, sizeof(*rlock)) < 0) { return -1; }
    acquire_reentrantlock(rlock);
    return 0;
}

int sys_release_reentrantlock(void) {
    struct reentrantlock *rlock;
    if (argptr(0, (void*)&rlock, sizeof(*rlock)) < 0) { return -1; }
    release_reentrantlock(rlock);
    return 0;
}
int sys_count_syscalls(void) {
    int num_syscalls = 0;
    for (int i = 0; i < ncpu; i++) {  // `ncpu` is the total number of CPUs
        struct cpu *c = &cpus[i];
        num_syscalls += c->syscall_count;
    }
    cprintf("Global counter says: %d\n", numof_all_syscalls);
    cprintf("Number of system calls used is: %d\n", num_syscalls);
    return 0;
}

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
