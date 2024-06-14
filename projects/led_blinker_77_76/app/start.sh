#! /bin/sh

apps_dir=/media/mmcblk0p1/apps

source $apps_dir/stop.sh

cat $apps_dir/led_blinker_77_76/led_blinker_77_76.bit > /dev/xdevcfg

$apps_dir/common_tools/setup-adc
$apps_dir/common_tools/enable-adc.sh
