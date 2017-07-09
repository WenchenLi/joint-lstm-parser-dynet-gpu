#!/usr/bin/env bash

TRAIN_DATA=/home/wenchen/gpu/joint-lstm-parser-dynet-gpu/data/conll2009/CoNLL2009-ST-Chinese/train_pred_identification_data.txt
DEV_DATA=/home/wenchen/gpu/joint-lstm-parser-dynet-gpu/data/conll2009/CoNLL2009-ST-Chinese/dev_pred_identification_data.txt
cmake-build-debug/parser/tag-bilstm t $TRAIN_DATA $TRAIN_DATA