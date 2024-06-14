---
layout: page
title: SDR receiver
permalink: /sdr-receiver-77-76/
---

Interesting links
-----

Some interesting links on digital signal processing and software defined radio:

 - [dspGuru - Tutorials](https://dspguru.com/dsp/tutorials)

 - [ARRL - Software Defined Radio](https://www.arrl.org/software-defined-radio)

 - [GNU Radio - Suggested Reading](https://wiki.gnuradio.org/index.php/SuggestedReading)

Hardware
-----

The FPGA configuration consists of sixteen identical digital down-converters (DDC). Their structure is shown in the following diagram:

![SDR receiver]({{ "/img/sdr-receiver-77-76.png" | prepend: site.baseurl }})

The I/Q data rate is configurable and four settings are available: 48, 96, 192, 384 kSPS.

The tunable frequency range covers from 0 Hz to 490 MHz.

The [projects/sdr_receiver_77_76](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/projects/sdr_receiver_77_76) directory contains two Tcl files: [block_design.tcl](https://github.com/pavel-demin/qmtech-xc7z020-notes/blob/main/projects/sdr_receiver_77_76/block_design.tcl), [rx.tcl](https://github.com/pavel-demin/qmtech-xc7z020-notes/blob/main/projects/sdr_receiver_77_76/rx.tcl). The code in these files instantiates, configures and interconnects all the needed IP cores.

The [projects/sdr_receiver_77_76/filters](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/projects/sdr_receiver_77_76/filters) directory contains the source code of the [R](https://www.r-project.org) scripts used to calculate the coefficients of the FIR filters.

Software
-----

The [projects/sdr_receiver_77_76/server](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/projects/sdr_receiver_77_76/server) directory contains the source code of the TCP server ([sdr-receiver.c](https://github.com/pavel-demin/qmtech-xc7z020-notes/blob/main/projects/sdr_receiver_77_76/server/sdr-receiver.c)) that receives control commands and transmits the I/Q data streams to the SDR programs.

The [SDR SMEM](https://github.com/pavel-demin/sdr-smem) repository contains the source code of the TCP client ([tcp_smem.lpr](https://github.com/pavel-demin/sdr-smem/blob/main/tcp_smem.lpr)), ExtIO plug-in ([extio_smem.lpr](https://github.com/pavel-demin/sdr-smem/blob/main/extio_smem.lpr)) and other programs and plug-ins. The following diagram shows an example of how these programs and plug-ins can be used:

![SDR SMEM]({{ "/img/sdr-smem.png" | prepend: site.baseurl }})

The `tcp_smem` program runs on a computer. It receives the I/Q data streams over the network and transfers them to other programs and plugins via shared memory.

Antenna
-----

I use simple indoor antennas made from a single loop of non-coaxial wire. Their approximate scheme is shown in the following diagrams:

![Antenna]({{ "/img/antenna.png" | prepend: site.baseurl }})

Getting started
-----

 - Connect an antenna to the SMA connector on the ADC board.
 - Download [SD card image zip file]({{ site.release-image }}) (more details about the SD card image can be found at [this link]({{ "/alpine/" | prepend: site.baseurl }})).
 - Copy the contents of the SD card image zip file to a micro SD card.
 - Optionally, to start the application automatically at boot time, copy its `start.sh` file from `apps/sdr_receiver` to the topmost directory on the SD card.
 - Install the micro SD card in the QMTECH XC7Z020 board and connect the power.
 - Download and install [SDR#](https://www.dropbox.com/sh/5fy49wae6xwxa8a/AAAdAcU238cppWziK4xPRIADa/sdr/sdrsharp_v1.0.0.1361_with_plugins.zip?dl=1) or [HDSDR](https://www.hdsdr.de).
 - Download and unpack the [SDR SMEM zip file]({{ site.sdr-smem-file }}).
 - Copy `extio_smem.dll` into the SDR# or HDSDR installation directory.
 - Start SDR# or HDSDR.
 - Select SMEM from the Source list in SDR# or from the Options [F7] &rarr; Select Input menu in HDSDR.
 - Press Configure icon in SDR# or press ExtIO button in HDSDR, then enter the IP address of the QMTECH XC7Z020 board.
 - Press Play icon in SDR# or press Start [F2] button in HDSDR.

Running CW Skimmer Server and Reverse Beacon Network Aggregator
-----

 - Install [CW Skimmer Server](https://dxatlas.com/skimserver).
 - Download and unpack the [SDR SMEM zip file]({{ site.sdr-smem-file }}).
 - Make a copy of the `tcp_smem.exe` program and rename the copy to `tcp_smem_1.exe`.
 - Start `tcp_smem.exe` and `tcp_smem_1.exe`, enter the IP addresses of the QMTECH XC7Z020 board and press the Connect button.
 - Copy `intf_smem.dll` to the CW Skimmer Server program directory (`C:\Program Files (x86)\Afreet\SkimSrv`).
 - Make a copy of the `SkimSrv` directory and rename the copy to `SkimSrv2`.
 - In the `SkimSrv2` directory, rename `SkimSrv.exe` to `SkimSrv2.exe` and rename `intf_smem.dll` to `intf_smem_1.dll`.
 - Install [Reverse Beacon Network Aggregator](https://www.reversebeacon.net/pages/Aggregator+34).
 - Start `SkimSrv.exe` and `SkimSrv2.exe`, configure frequencies and your call sign.
 - Start Reverse Beacon Network Aggregator.

Building from source
-----

The structure of the source code and of the development chain is described at [this link]({{ "/led-blinker-77-76/" | prepend: site.baseurl }}).

Setting up the Vitis and Vivado environment:
{% highlight bash %}
source /opt/Xilinx/Vitis/2023.1/settings64.sh
{% endhighlight %}

Cloning the source code repository:
{% highlight bash %}
git clone https://github.com/pavel-demin/qmtech-xc7z020-notes
cd qmtech-xc7z020-notes
{% endhighlight %}

Building `sdr_receiver_77_76.bit`:
{% highlight bash %}
make NAME=sdr_receiver_77_76 bit
{% endhighlight %}

Building SD card image zip file:
{% highlight bash %}
source helpers/build-all.sh
{% endhighlight %}