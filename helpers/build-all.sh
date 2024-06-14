source /opt/Xilinx/Vitis/2023.1/settings64.sh

JOBS=`nproc 2> /dev/null || echo 1`

make -j $JOBS cores

make NAME=led_blinker_77_76 all

PRJS="sdr_receiver_77_76 sdr_receiver_hpsdr_77_76"

printf "%s\n" $PRJS | xargs -n 1 -P $JOBS -I {} make NAME={} bit

sudo sh scripts/alpine.sh
