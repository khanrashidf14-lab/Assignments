#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/wait.h>

int main() {
    key_t key;
    int shmid;
    char *shared_memory;

    // Generate a unique key
    key = ftok("shmfile", 65);

    // Create shared memory segment
    shmid = shmget(key, 1024, 0666 | IPC_CREAT);

    if (shmid == -1) {
        perror("shmget");
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

        // Wait for child to read the message
        wait(NULL);

        // Detach shared memory
        shmdt(shared_memory);

        // Remove shared memory segment
        shmctl(shmid, IPC_RMID, NULL);
    }
    else {
        // Child process
        sleep(1);  // Give parent time to write

        printf("Child: Message read from shared memory: %s\n",
               shared_memory);

        // Detach shared memory
        shmdt(shared_memory);

        exit(0);
    }

    return 0;
}
