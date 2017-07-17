#!/usr/bin/env bash
git submodule init
git submodule update
cd dynet
git checkout 814f1819e4b7a75cb490b6a242a40e55f5ce7a1b
cd ..
