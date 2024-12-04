#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

/*
 * This program enqueues a value into a kernel ring buffer via the /proc/kboard/enqueue interface.
 * It takes a single command-line argument and writes it to the specified proc file.
 * The program checks for the correct number of arguments, attempts to write the value,
 * and handles any errors that occur during the process.
 */

int main(int argc, char** argv) {
    // Open the /proc/kboard/enqueue file for writing only
    int fd = open("/proc/kboard/enqueue", O_WRONLY);

    // Check if exactly one argument is provided (program name + one argument)
    if (argc != 2) {
        printf("testEnqueue: invalid argument\n");
        return -1;
    }

    int res;

    // Attempt to write the argument to the proc file
    res = write(fd, argv[1], sizeof(argv[1]));

    // Check if the write operation was successful
    if (res == -1) {
        // Write failed, likely because the ring buffer is full
        printf("now ring buffer full\n");
    } else {
        // Write succeeded, output the enqueued value
        printf("enqueue %s\n", argv[1]);
    }

    // Close the file descriptor to free resources
    close(fd);

    return 0;
}