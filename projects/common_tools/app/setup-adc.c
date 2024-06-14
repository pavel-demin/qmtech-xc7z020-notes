#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/spi/spidev.h>

int main()
{
  int i, fd, value;

  uint8_t data[9] =
  {
    0x00, 0x0B, 0x01,
    0x00, 0x14, 0x41,
    0x00, 0xFF, 0x01
  };

  fd = open("/dev/spidev0.0", O_RDWR);

  value = SPI_MODE_0;
  ioctl(fd, SPI_IOC_WR_MODE, &value);

  value = 8;
  ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &value);

  value = 1000000;
  ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &value);

  write(fd, data, 9);

  close(fd);

  return EXIT_SUCCESS;
}
