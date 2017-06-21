#!/usr/bin/env bash
git submodule init
git submodule update

#install eigen3.3
wget http://bitbucket.org/eigen/eigen/get/3.3.3.tar.gz
tar -xvzf 3.3.3.tar.gz
cd eigen-eigen-67e894c6cd8f
mkdir build
cd build
cmake ..
make
sudo make install

#install boost1.60
wget https://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz
tar -xvzf boost_1_60_0.tar.gz
cd boost_1_60_0
sh bootstrap.sh
sudo ./b2 install -j4