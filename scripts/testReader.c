#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

/*
 * This program configures the reader setting via the /proc/kboard/reader interface.
 * It takes a single command-line argument and writes it to the specified proc file.
 * The program checks for the correct number of arguments, attempts to write the value,
 * and handles any errors that occur during the process.
 */

int main(int argc, char** argv) {
    // Check if exactly one argument is provided (program name + one argument)
    if (argc != 2) {
        printf("testReader: invalid argument\n");
        return -1;
    }

    // Open the /proc/kboard/reader file for writing only
    int fd = open("/proc/kboard/reader", O_WRONLY);
    if (fd == -1) {
        perror("Failed to open /proc/kboard/reader");
        return -1;
    }

    int res;

    // Attempt to write the argument to the proc file
    res = write(fd, argv[1], strlen(argv[1]));

    // Check if the write operation was successful
    if (res == -1) {
        // Write failed, likely due to an error (e.g., ring buffer full)
        perror("Write failed");
    } else {
        // Write succeeded, output the reader value set
        printf("reader %s\n", argv[1]);
    }

    // Close the file descriptor to free resources
    close(fd);

    return 0;
}