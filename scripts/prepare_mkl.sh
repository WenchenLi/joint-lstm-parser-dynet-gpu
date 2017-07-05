#!/usr/bin/env bash
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11544/l_mkl_2017.3.196.tgz
tar -xvzf l_mkl_2017.3.196.tgz
cd l_mkl_2017.3.196
sudo sh install.sh