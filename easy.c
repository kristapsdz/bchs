#include <err.h> /* err(3) */
#include <stdlib.h> /* EXIT_xxxx */
#include <stdio.h> /* puts(3) */
#include <unistd.h> /* pledge(2) */

int
main(void)
{
    if (pledge("stdio", NULL) == -1) 
        err(EXIT_FAILURE, "pledge");
    puts("Status: 200 OK\r");
    puts("Content-Type: text/html\r");
    puts("\r");
    puts("Hello, world!\n");
    return EXIT_SUCCESS;
}
