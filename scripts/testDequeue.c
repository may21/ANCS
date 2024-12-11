#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

#define MAX_LEN (11)

/*
 * This program dequeues a value from a kernel ring buffer via the /proc/kboard/dequeue interface.
 * It reads an integer value from the proc file, checks for errors, and outputs the dequeued value.
 * If the ring buffer is empty, it notifies the user.
 */

int main() {
    // Open the /proc/kboard/dequeue file for reading only
    int fd = open("/proc/kboard/dequeue", O_RDONLY);

    // Check if the file was opened successfully
    if (fd == -1) {
        perror("Failed to open /proc/kboard/dequeue");
        return -1;
    }

    // Buffer to store the read data
    char buf[MAX_LEN];

    int n;
    ssize_t readRes;

    // Attempt to read from the proc file
    readRes = read(fd, buf, sizeof(buf) - 1);

    // Check if the read operation was successful
    if (readRes > 0) {
        // Null-terminate the buffer to safely use it as a string
        buf[readRes] = '\0';

        // Convert the read string to an integer
        n = atoi(buf);

        // If n is -1, the ring buffer is empty
        if (n == -1) {
            printf("now ring buffer empty\n");
            close(fd);
            return -1;
        }

        // Output the dequeued value
        printf("dequeue %d\n", n);
    } else if (readRes == 0) {
        // End of file reached without reading data
        printf("now ring buffer empty\n");
        close(fd);
        return -1;
    } else {
        // Read operation failed
        perror("Read failed");
        close(fd);
        return -1;
    }

    // Close the file descriptor to free resources
    close(fd);

    return 0;
}