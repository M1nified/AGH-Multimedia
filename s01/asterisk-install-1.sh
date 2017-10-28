#!/bin/bash

sudo bash
apt-get update
apt-get dist-upgrade
sudo su
passwd
apt-get install build-essential wget libssl-dev libncurses5-dev libnewt-dev libxml2-dev linux-headers-$(uname -r) libsqlite3-dev uuid-dev git subversion
cd /usr/src
wget downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz
tar zxvf asterisk-13-current.tar.gz
cd asterisk-13.13.1
git clone git://github.com/asterisk/pjproject pjproject
cd pjproject
./configure --prefix=/usr --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr CFLAGS='-O2 -DNDEBUG'
make dep
make
make install
ldconfig
# ldconfig -p | grep pj
cd ..
contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
./configure
make menuselect
make
make install
make samples
make config
ldconfig