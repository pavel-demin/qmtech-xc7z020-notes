CFLAGS = -O3 -march=armv7-a -mtune=cortex-a9 -mfpu=neon -mfloat-abi=hard -D_GNU_SOURCE

all: sdr-receiver

sdr-receiver: sdr-receiver.c
	gcc $(CFLAGS) -o $@ $^ -lm

clean:
	rm -f sdr-receiver
