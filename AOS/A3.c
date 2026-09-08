1.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/resource.h>
#include <sys/types.h>

int main()
{
    int n, i;
    pid_t pid;
    struct rusage usage;

    double total_user = 0.0;
    double total_kernel = 0.0;

    printf("Enter number of children: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++)
    {
        pid = fork();

        if (pid < 0)
        {
            perror("fork");
            exit(EXIT_FAILURE);
        }

        if (pid == 0)
        {
            /* Child performs some work */
            for (volatile long j = 0; j < 100000000; j++);

            exit(0);
        }
    }

    /* Parent waits for all children */
    for (i = 0; i < n; i++)
    {
        wait4(-1, NULL, 0, &usage);

        total_user += usage.ru_utime.tv_sec +
                      usage.ru_utime.tv_usec / 1000000.0;

        total_kernel += usage.ru_stime.tv_sec +
                        usage.ru_stime.tv_usec / 1000000.0;
    }

    printf("\nTotal cumulative time:\n");
    printf("User mode time   : %.6f seconds\n", total_user);
    printf("Kernel mode time : %.6f seconds\n", total_kernel);

    return 0;
}




2.

#include <stdio.h>
#include <stdlib.h>

void function1()
{
    printf("atexit function 1 called\n");
}

void function2()
{
    printf("atexit function 2 called\n");
}

void function3()
{
    printf("atexit function 3 called\n");
}

int main()
{
    atexit(function1);
    atexit(function2);
    atexit(function3);

    printf("Main function is executing...\n");

    exit(0);
}





3.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main()
{
    int parent_to_child[2];
    int child_to_parent[2];

    pid_t pid;

    char parent_msg[] = "Hello Child, this is Parent!";
    char child_msg[] = "Hello Parent, this is Child!";

    char buffer[100];

    if (pipe(parent_to_child) == -1 ||
        pipe(child_to_parent) == -1)
    {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    pid = fork();

    if (pid < 0)
    {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if (pid == 0)
    {
        /* Child */

        close(parent_to_child[1]);  // Child doesn't write here
        close(child_to_parent[0]);  // Child doesn't read here

        /* Read message from parent */
        read(parent_to_child[0], buffer, sizeof(buffer));
        printf("Child received: %s\n", buffer);

        /* Send message to parent */
        write(child_to_parent[1], child_msg, strlen(child_msg) + 1);

        close(parent_to_child[0]);
        close(child_to_parent[1]);

        exit(0);
    }
    else
    {
        /* Parent */

        close(parent_to_child[0]);  // Parent doesn't read here
        close(child_to_parent[1]);  // Parent doesn't write here

        /* Send message to child */
        write(parent_to_child[1], parent_msg, strlen(parent_msg) + 1);

        /* Read reply from child */
        read(child_to_parent[0], buffer, sizeof(buffer));
        printf("Parent received: %s\n", buffer);

        close(parent_to_child[1]);
        close(child_to_parent[0]);

        wait(NULL);
    }

    return 0;
}

