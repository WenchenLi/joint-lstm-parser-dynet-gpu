#!/usr/bin/env bash
cd cnn
cmake . -DBACKEND=cuda
cd cnn
make -j2
