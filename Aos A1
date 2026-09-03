
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

    //Buffer management

int free_list[5] = {1, 2, 3, 4, 5};
int buffer_list[5] = {0};

    /* Allocating free buffer block */
int getblk()
{
    int i;

    for(i = 0; i < 5; i++)
    {
        if(free_list[i] != 0)
        {
            int block = free_list[i];
            free_list[i] = 0;

            for(int j = 0; j < 5; j++)
            {
                if(buffer_list[j] == 0)
                {
                    buffer_list[j] = block;
                    return block;
                }
            }
        }
    }

    return -1;
}

//Buffer block releases here
void brelse(int block)
{
    int i;

    /* Removes block from buffer list */
    for(i = 0; i < 5; i++)
    {
        if(buffer_list[i] == block)
        {
            buffer_list[i] = 0;
            break;
        }
    }

    /* Return to free list */
    for(i = 0; i < 5; i++)
    {
        if(free_list[i] == 0)
        {
            free_list[i] = block;
            break;
        }
    }
}

                        //Display lists 
void show_buffers()
{
    int i;

    printf("\nFree List   : ");
    for(i = 0; i < 5; i++)
        if(free_list[i] != 0)
            printf("B%d ", free_list[i]);

    printf("\nBuffer List : ");
    for(i = 0; i < 5; i++)
        if(buffer_list[i] != 0)
            printf("B%d ", buffer_list[i]);

    printf("\n");
}

                        // Pipe 

void create_pipe(int fd[])
{
    if(pipe(fd) == -1)
    {
        perror("pipe");
        exit(1);
    }
}

/* -------- Deposit -------- */

void deposit(int fd[])
{
    int amount = 3000;
    int block = getblk();

    close(fd[0]);

    write(fd[1], &amount, sizeof(amount));

    printf("\nDeposit Process\n");
    printf("Buffer B%d allocated\n", block);
    printf("Deposited Rs.%d\n", amount);

    brelse(block);

    close(fd[1]);
    exit(0);
}

/* -------- EMI -------- */

void emi(int fd[])
{
    int amount = 2500;
    int block = getblk();

    close(fd[0]);

    write(fd[1], &amount, sizeof(amount));

    printf("\nEMI Process\n");
    printf("Buffer B%d allocated\n", block);
    printf("EMI Rs.%d\n", amount);

    brelse(block);

    close(fd[1]);
    exit(0);
}

/* -------- Withdrawal -------- */

void withdraw(int fd[])
{
    int amount = 1500;
    int block = getblk();

    close(fd[0]);

    write(fd[1], &amount, sizeof(amount));

    printf("\nWithdrawal Process\n");
    printf("Buffer B%d allocated\n", block);
    printf("Withdrawn Rs.%d\n", amount);

    brelse(block);

    close(fd[1]);
    exit(0);
}

            /* Reads Pipe  */

int read_amount(int fd[])
{
    int amount;

    close(fd[1]);

    read(fd[0], &amount, sizeof(amount));

    close(fd[0]);

    return amount;
}



int main()
{
    int fd1[2], fd2[2], fd3[2];
    int balance = 1000;
    int amount;

    printf("Initial Balance = Rs.%d\n", balance);

    show_buffers();

    create_pipe(fd1);

    if(fork() == 0)
        deposit(fd1);

    wait(NULL);

    amount = read_amount(fd1);
    balance += amount;

    printf("Balance after Deposit = Rs.%d\n", balance);
    show_buffers();

    create_pipe(fd2);

    if(fork() == 0)
        emi(fd2);

    wait(NULL);

    amount = read_amount(fd2);
    balance -= amount;

    printf("Balance after EMI = Rs.%d\n", balance);
    show_buffers();

    create_pipe(fd3);

    if(fork() == 0)
        withdraw(fd3);

    wait(NULL);

    amount = read_amount(fd3);
    balance -= amount;

    printf("Balance after Withdrawal = Rs.%d\n", balance);
    show_buffers();


    printf("\nFinal Balance = Rs.%d\n", balance);

    return 0;
}
