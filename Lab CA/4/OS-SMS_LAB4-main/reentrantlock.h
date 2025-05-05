#ifndef RL_H
#define RL_H
#include "spinlock.h"

struct reentrantlock {
    struct spinlock lock; 
    int locked;           // is locked?
    int recursive;        // number of recursive calls so far 
    struct proc* owner;   // pointer to current owner of the lock       
};

void init_reentrantlock(struct reentrantlock *rlock);
void acquire_reentrantlock(struct reentrantlock *rlock);
void release_reentrantlock(struct reentrantlock *rlock);

#endif
