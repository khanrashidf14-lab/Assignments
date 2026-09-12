1.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

void sighup_handler(int sig) {
    printf("Child: Received SIGHUP\n");
    fflush(stdout);
}

void sigint_handler(int sig) {
    printf("Child: Received SIGINT\n");
    fflush(stdout);
}

void sigquit_handler(int sig) {
    printf("My DADDY has Killed me!!!\n");
    fflush(stdout);
    exit(0);
}

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        perror("fork failed");
        exit(1);
    }

    if (pid == 0) {  /* Child process */
        /* Install signal handlers */
        signal(SIGHUP, sighup_handler);
        signal(SIGINT, sigint_handler);
        signal(SIGQUIT, sigquit_handler);

        printf("Child (PID %d) started. Waiting for signals...\n", getpid());
        fflush(stdout);

        /* Keep running until SIGQUIT is received */
        while (1) {
            pause();  /* Wait for any signal */
        }
    } else {  /* Parent process */
        printf("Parent (PID %d): Child PID = %d\n", getpid(), pid);
        fflush(stdout);

        /* Send SIGHUP or SIGINT every 3 seconds for 30 seconds (10 times) */
        for (int i = 0; i < 10; i++) {
            sleep(3);
            if (i % 2 == 0) {
                printf("Parent: Sending SIGHUP to child\n");
                kill(pid, SIGHUP);
            } else {
                printf("Parent: Sending SIGINT to child\n");
                kill(pid, SIGINT);
            }
            fflush(stdout);
        }

        /* After 30 seconds send SIGQUIT */
        printf("Parent: Sending SIGQUIT to child\n");
        fflush(stdout);
        kill(pid, SIGQUIT);

        wait(NULL);  /* Wait for child to terminate */
        printf("Parent: Child has terminated. Exiting.\n");
    }

    return 0;
}
