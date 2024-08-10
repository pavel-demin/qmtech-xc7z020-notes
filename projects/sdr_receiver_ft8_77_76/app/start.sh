#! /bin/sh

apps_dir=/media/mmcblk0p1/apps

source $apps_dir/stop.sh

if grep -q '' $apps_dir/sdr_receiver_ft8_77_76/upload-ft8.sh
then
  mount -o rw,remount /media/mmcblk0p1
  dos2unix $apps_dir/sdr_receiver_ft8_77_76/upload-ft8.sh
  mount -o ro,remount /media/mmcblk0p1
fi

rm -rf /dev/shm/*

cat $apps_dir/sdr_receiver_ft8_77_76/sdr_receiver_ft8_77_76.bit > /dev/xdevcfg

$apps_dir/common_tools/setup-adc
$apps_dir/common_tools/enable-adc.sh

ln -sf $apps_dir/sdr_receiver_ft8_77_76/ft8.cron /etc/cron.d/ft8_77_76

service dcron restart
