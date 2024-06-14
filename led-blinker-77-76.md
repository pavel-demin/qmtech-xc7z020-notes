---
layout: page
title: LED blinker
permalink: /led-blinker-77-76/
---

Introduction
-----

For my experiments with the QMTECH XC7Z020 board, I would like to have the following development environment:

 - recent version of the [Vitis Core Development Kit](https://www.xilinx.com/products/design-tools/vitis.html)
 - recent version of the [Linux kernel](https://www.kernel.org)
 - recent version of the [Debian distribution](https://www.debian.org/releases/bookworm) on the development machine
 - recent version of the [Alpine distribution](https://alpinelinux.org) on the QMTECH XC7Z020 board
 - basic project with all the QMTECH XC7Z020 peripherals connected
 - mostly command-line tools
 - shallow directory structure

Here is how I set it all up.

Pre-requirements
-----

My development machine has the following installed:

 - [Debian](https://www.debian.org/releases/bookworm) 12 (amd64)

 - [Vitis Core Development Kit](https://www.xilinx.com/products/design-tools/vitis.html) 2023.1

Here are the commands to install all the other required packages:
{% highlight bash %}
apt-get update

apt-get --no-install-recommends install \
  bc binfmt-support bison build-essential ca-certificates curl \
  debootstrap device-tree-compiler dosfstools flex fontconfig git \
  libgtk-3-0 libncurses-dev libssl-dev libtinfo5 parted qemu-user-static \
  squashfs-tools sudo u-boot-tools x11-utils xvfb zerofree zip
{% endhighlight %}

Source code
-----

The source code is available at

<https://github.com/pavel-demin/qmtech-xc7z020-notes>

This repository contains the following components:

 - [Makefile](https://github.com/pavel-demin/qmtech-xc7z020-notes/blob/main/Makefile) that builds everything (almost)
 - [cfg](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/cfg) directory with constraints and board definition files
 - [cores](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/cores) directory with IP cores written in Verilog
 - [projects](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/projects) directory with Vivado projects written in Tcl
 - [scripts](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/scripts) directory with
   - Tcl scripts for Vivado and SDK
   - shell script that builds an SD card image

All steps of the development chain and the corresponding scripts are shown in the following diagram:

![Scripts]({{ "/img/scripts.png" | prepend: site.baseurl }})

Syntactic sugar for IP cores
-----

The [projects/led_blinker_77_76](https://github.com/pavel-demin/qmtech-xc7z020-notes/tree/main/projects/led_blinker_77_76) directory contains one Tcl file [block_design.tcl](https://github.com/pavel-demin/qmtech-xc7z020-notes/blob/main/projects/led_blinker_77_76/block_design.tcl) that instantiates, configures and interconnects all the needed IP cores.

By default, the IP core instantiation and configuration commands are quite verbose:
{% highlight Tcl %}
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 ps_0

set_property CONFIG.PCW_IMPORT_BOARD_PRESET cfg/qmtech_xc7z020.xml [get_bd_cells ps_0]

connect_bd_net [get_bd_pins ps_0/FCLK_CLK0] [get_bd_pins ps_0/M_AXI_GP0_ACLK]
{% endhighlight %}

With the Tcl's flexibility, it's easy to define a less verbose command that looks similar to the module instantiation in Verilog:
{% highlight Tcl %}
cell xilinx.com:ip:processing_system7 ps_0 {
  PCW_IMPORT_BOARD_PRESET cfg/qmtech_xc7z020.xml
} {
  M_AXI_GP0_ACLK ps_0/FCLK_CLK0
}
{% endhighlight %}

The `cell` command and other helper commands are defined in the [scripts/project.tcl](https://github.com/pavel-demin/qmtech-xc7z020-notes/blob/main/scripts/project.tcl) script.

Getting started
-----

Setting up the Vitis and Vivado environment:
{% highlight bash %}
source /opt/Xilinx/Vitis/2023.1/settings64.sh
{% endhighlight %}

Cloning the source code repository:
{% highlight bash %}
git clone https://github.com/pavel-demin/qmtech-xc7z020-notes
cd qmtech-xc7z020-notes
{% endhighlight %}

Building `boot.bin`:
{% highlight bash %}
make NAME=led_blinker_77_76 all
{% endhighlight %}

SD card image
-----

Building an SD card image:
{% highlight bash %}
sudo sh scripts/alpine.sh
{% endhighlight %}

A pre-built SD card image can be downloaded from [this link]({{ site.release-image }}).

To write the image to a micro SD card, copy the contents of the SD card image zip file to a micro SD card.

More details about the SD card image can be found at [this link]({{ "/alpine/" | prepend: site.baseurl }}).

Reprogramming FPGA
-----

It's possible to reprogram the FPGA by loading the bitstream file into `/dev/xdevcfg`:
{% highlight bash %}
cat led_blinker_77_76.bit > /dev/xdevcfg
{% endhighlight %}
