1.

#include <fcntl.h>                               //for O_CREAT
#include <unistd.h>                              //for write(),close(),write()
#include <stdio.h>

int main() {
    int fd = creat("hole.txt", 0666);            //0666: Sets file permissions when file is created
    write(fd, "ABCDEFGHIJ", 10);
    lseek(fd, 16384, SEEK_CUR);   // create hole
    write(fd, "abcdefghij", 10);
    close(fd);
    printf("File 'hole.txt' created with a hole.\n");
    return 0;
}




2.

#include <fcntl.h>                              //for O_CREAT,O_RDWR
#include <unistd.h>                             //for sleep(),close()
#include <stdio.h>                              

int main() {
    int fd = open("temp.txt", O_CREAT | O_RDWR, 0666);          //0666: Sets file permissions when file is created
    printf("File opened. Sleeping 15 seconds...\n");
    sleep(15);
    printf("Woke up. Terminating.\n");
    close(fd);
    return 0;
}




3.

#include <dirent.h>
#include <sys/stat.h>
#include <stdio.h>
#include <string.h>

int main() {
    DIR *d = opendir(".");
    struct dirent *e;
    struct stat st;
    int count = 0;

    printf("%-25s %-10s %s\n", "Name", "Size", "Type");
    while ((e = readdir(d)) != NULL) {
        if (strcmp(e->d_name, ".") == 0 || strcmp(e->d_name, "..") == 0)
            continue;
        lstat(e->d_name, &st);
        printf("%-25s %-10ld %s\n", e->d_name, st.st_size,
               S_ISDIR(st.st_mode) ? "Directory" :
               S_ISREG(st.st_mode) ? "Regular" : "Other");
        count++;
    }
    closedir(d);
    printf("Total files: %d\n", count);
    return 0;
}
