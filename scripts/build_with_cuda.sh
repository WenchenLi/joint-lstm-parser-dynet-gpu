#!/usr/bin/env bash
# this part only build cnn

#cd cnn
#cmake . -DBACKEND=cuda
#cd cnn
#make -j2

# current cmake build with cnn from project root
cd build
cmake .. -DBACKEND=cuda
make  -j8


#cmake .. -DEIGEN3_INCLUDE_DIR=/usr/local/include/eigen3 -DBACKEND=cuda -DCUDNN_ROOT=/usr/local/cuda-8.0/