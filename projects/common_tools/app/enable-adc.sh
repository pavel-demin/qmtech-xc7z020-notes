#! /bin/sh

echo 567 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio567/direction
echo 1 > /sys/class/gpio/gpio567/value
