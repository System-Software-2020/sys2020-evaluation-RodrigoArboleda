#include <unistd.h>

void write2(int fd, const void *string, int size){
    syscall(4, fd, string, size);
}