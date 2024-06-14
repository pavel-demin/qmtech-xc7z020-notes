CFLAGS = -O3 -march=armv7-a -mtune=cortex-a9 -mfpu=neon -mfloat-abi=hard

all: measure-corr measure-level setup-adc sleep-rand sleep-to-59

measure-corr: measure-corr.c
	gcc $(CFLAGS) -o $@ $^

measure-level: measure-level.c
	gcc $(CFLAGS) -o $@ $^ -lm

setup-adc: setup-adc.c
	gcc $(CFLAGS) -o $@ $^

sleep-rand: sleep-rand.c
	gcc $(CFLAGS) -o $@ $^

sleep-to-59: sleep-to-59.c
	gcc $(CFLAGS) -o $@ $^

clean:
	rm -f measure-corr measure-level setup-adc sleep-rand sleep-to-59
