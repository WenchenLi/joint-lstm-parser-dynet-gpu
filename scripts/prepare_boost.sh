#!/usr/bin/env bash
#install boost1.60
wget https://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz
tar -xvzf boost_1_60_0.tar.gz
cd boost_1_60_0
sh bootstrap.sh
sudo ./b2 install -j4