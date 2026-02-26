#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

/* setuid script wrapper */ 

int main()
{
    setreuid(geteuid(), geteuid());
    system("/challenge/app-script/ch6/ch6.py");
    return 0;
}
