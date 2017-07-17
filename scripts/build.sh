#!/usr/bin/env bash
#install joint-lstm-parser
mkdir -p cmake-build-debug
cd cmake-build-debug
cmake .. -DEIGEN3_INCLUDE_DIR=/usr/local/include/eigen3
make -j4