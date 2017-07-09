#!/usr/bin/env bash

DEV_DATA=/home/wenchen/gpu/joint-lstm-parser-dynet-gpu/data/conll2009/CoNLL2009-ST-Chinese/train_pred_identification_data.txt
MODEL=$1
cmake-build-debug/parser/tag-bilstm p $DEV_DATA $MODEL