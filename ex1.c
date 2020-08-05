#include <unistd.h>

char p1[3] = "Hel";
char p2[3] = "lo\n";

int main(){
    write(1, p1, 6);
    return 0;
}