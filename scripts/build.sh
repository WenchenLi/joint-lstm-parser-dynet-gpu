#!/usr/bin/env bash
#install joint-lstm-parser
mkdir -p build
cd build
cmake .. -DEIGEN3_INCLUDE_DIR=/usr/local/include/eigen3
make -j4