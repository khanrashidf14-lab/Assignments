#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <sys/wait.h>

/* Union needed for semctl */
union semun {
    int val;
    struct semid_ds *buf;
    unsigned short *array;
};

int main() {
    key_t key;
    int shmid, semid;
    char *shared_memory;
    struct sembuf p = {0, -1, 0};   /* P (wait) operation */
    struct sembuf v = {0,  1, 0};   /* V (signal) operation */
    union semun u;

    // Generate a unique key
    key = ftok("shmfile", 65);

    // Create shared memory segment
    shmid = shmget(key, 1024, 0666 | IPC_CREAT);
    if (shmid == -1) {
        perror("shmget");
        exit(1);
    }

    // Create a semaphore set with 1 semaphore
    semid = semget(key, 1, 0666 | IPC_CREAT);
    if (semid == -1) {
        perror("semget");
        exit(1);
    }

    // Initialize the semaphore to 0 (locked)
    u.val = 0;
    if (semctl(semid, 0, SETVAL, u) == -1) {
        perror("semctl SETVAL");
        exit(1);
    }

    // Attach shared memory
    shared_memory = (char *)shmat(shmid, NULL, 0);
    if (shared_memory == (char *)-1) {
        perror("shmat");
        exit(1);
    }

    // Create a child process
    pid_t pid = fork();
    if (pid < 0) {
        perror("fork");
        exit(1);
    }

    if (pid > 0) {
        // Parent process
        strcpy(shared_memory, "Hello from the parent process!");
        printf("Parent: Message written to shared memory.\n");

        // Signal the semaphore (V operation) so the child can proceed
        if (semop(semid, &v, 1) == -1) {
            perror("semop V");
            exit(1);
        }

        // Wait for child to finish
        wait(NULL);

        // Detach and remove shared memory
        shmdt(shared_memory);
        shmctl(shmid, IPC_RMID, NULL);

        // Remove the semaphore
        semctl(semid, 0, IPC_RMID);
    }
    else {
        // Child process
        // Wait on the semaphore (P operation) until parent signals
        if (semop(semid, &p, 1) == -1) {
            perror("semop P");
            exit(1);
        }

        printf("Child: Message read from shared memory: %s\n", shared_memory);

        // Detach shared memory
        shmdt(shared_memory);
        exit(0);
    }

    return 0;
}
