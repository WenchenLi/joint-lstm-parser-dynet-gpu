#!/usr/bin/env bash
# $1 is working directory name
WORKING_DIR=$1
MODEL=$2

WORD_EMBEDDING=data/word_embedding/wiki.zh.wang2vec.100.vec
TRAIN_DATA=$WORKING_DIR/train.transitions
TRAIN_CONLL_LEMMA=$1/train.conll.pb.lemmas
PREDICT_DATA=$WORKING_DIR/predict.transitions
#predict
cmake-build-debug/parser/lstm-parse --predict -T $TRAIN_DATA --predict_data $PREDICT_DATA --model $MODEL -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA -s dev.predictions.conll