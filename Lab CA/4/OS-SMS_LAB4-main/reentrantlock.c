#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "reentrantlock.h"
#include "proc.h"

void init_reentrantlock(struct reentrantlock *rlock) {
    initlock(&rlock->lock, "reentrantlock");
    rlock->locked = 0; rlock->owner = 0; rlock->recursive = 0;
}
void acquire_reentrantlock(struct reentrantlock *rlock) {
    struct proc* p = myproc();
    acquire(&rlock->lock);
    if (rlock->locked && rlock->owner == p) {
        rlock->recursive++; release(&rlock->lock);
        return;
    }

    while (rlock->locked) { sleep(rlock, &rlock->lock); }

    rlock->locked = 1; rlock->recursive = 1; rlock->owner = p;
    release(&rlock->lock);
}

void release_reentrantlock(struct reentrantlock *rlock) {
    acquire(&rlock->lock);
    if (rlock->owner != myproc()) { release(&rlock->lock); return; }

    rlock->recursive--;
    if (rlock->recursive == 0) {
        rlock->locked = 0; rlock->owner = 0;
        wakeup(rlock);
    }
    release(&rlock->lock);
}