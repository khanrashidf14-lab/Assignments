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

    /* P = Wait, V = Signal */
    struct sembuf p = {0, -1, 0};
    struct sembuf v = {0, 1, 0};

    union semun u;

    printf("========== PROGRAM START ==========\n\n");

    /* Step 1: Generate key */
    printf("1. Generating IPC key...\n");

    key = ftok("shmfile", 65);

    if (key == -1) {
        perror("ftok");
        exit(1);
    }

    printf("   Key created successfully: %d\n\n", key);


    /* Step 2: Create shared memory */
    printf("2. Creating shared memory...\n");

    shmid = shmget(key, 1024, 0666 | IPC_CREAT);

    if (shmid == -1) {
        perror("shmget");
        exit(1);
    }

    printf("   Shared memory created successfully.\n");
    printf("   Shared Memory ID = %d\n", shmid);
    printf("   Size = 1024 bytes\n\n");


    /* Step 3: Create semaphore */
    printf("3. Creating semaphore...\n");

    semid = semget(key, 1, 0666 | IPC_CREAT);

    if (semid == -1) {
        perror("semget");
        exit(1);
    }

    printf("   Semaphore created successfully.\n");
    printf("   Semaphore ID = %d\n", semid);
    printf("   Number of semaphores = 1\n\n");


    /* Step 4: Initialize semaphore to 0 */
    printf("4. Initializing semaphore...\n");

    u.val = 0;

    if (semctl(semid, 0, SETVAL, u) == -1) {
        perror("semctl SETVAL");
        exit(1);
    }

    printf("   Semaphore value = 0\n");
    printf("   This means CHILD must WAIT.\n\n");


    /* Step 5: Attach shared memory */
    printf("5. Attaching shared memory...\n");

    shared_memory = (char *)shmat(shmid, NULL, 0);

    if (shared_memory == (char *)-1) {
        perror("shmat");
        exit(1);
    }

    printf("   Shared memory attached successfully.\n\n");


    /* Step 6: Create child process */
    printf("6. Creating child process using fork()...\n\n");

    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(1);
    }


    /* ================= PARENT PROCESS ================= */

    if (pid > 0) {

        printf("========== PARENT PROCESS ==========\n");

        /* Parent writes message */
        strcpy(shared_memory, "Hello from the parent process!");

        printf("Parent: Message written to shared memory.\n");
        printf("Parent: Message = \"%s\"\n\n", shared_memory);


        /* Parent signals child */
        printf("Parent: Performing V (SIGNAL) operation...\n");

        if (semop(semid, &v, 1) == -1) {
            perror("semop V");
            exit(1);
        }

        printf("Parent: Semaphore signal sent.\n");
        printf("Parent: Child can now read the message.\n\n");


        /* Wait for child */
        printf("Parent: Waiting for child to finish...\n");

        wait(NULL);

        printf("Parent: Child has finished.\n\n");


        /* Detach shared memory */
        printf("Parent: Detaching shared memory...\n");

        shmdt(shared_memory);

        printf("Parent: Shared memory detached.\n");


        /* Remove shared memory */
        printf("Parent: Removing shared memory...\n");

        shmctl(shmid, IPC_RMID, NULL);

        printf("Parent: Shared memory removed.\n");


        /* Remove semaphore */
        printf("Parent: Removing semaphore...\n");

        semctl(semid, 0, IPC_RMID);

        printf("Parent: Semaphore removed.\n\n");

    }


    /* ================= CHILD PROCESS ================= */

    else {

        printf("========== CHILD PROCESS ==========\n");

        /* Child waits for parent */
        printf("Child: Waiting on semaphore...\n");
        printf("Child: P (WAIT) operation started.\n");

        if (semop(semid, &p, 1) == -1) {
            perror("semop P");
            exit(1);
        }

        printf("Child: Semaphore signal received.\n");
        printf("Child: Parent has finished writing.\n\n");


        /* Child reads message */
        printf("Child: Reading message from shared memory...\n");

        printf("Child: Message = \"%s\"\n\n", shared_memory);


        /* Detach shared memory */
        printf("Child: Detaching shared memory...\n");

        shmdt(shared_memory);

        printf("Child: Shared memory detached.\n");


        /* End child */
        printf("Child: Exiting...\n");

        exit(0);
    }


    printf("\n========== PROGRAM END ==========\n");

    return 0;
}
