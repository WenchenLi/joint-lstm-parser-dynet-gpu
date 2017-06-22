#!/usr/bin/env bash

#install eigen3.3
wget http://bitbucket.org/eigen/eigen/get/3.3.3.tar.gz
tar -xvzf 3.3.3.tar.gz
cd eigen-eigen-67e894c6cd8f
mkdir build
cd build
cmake ..
make
sudo make install

