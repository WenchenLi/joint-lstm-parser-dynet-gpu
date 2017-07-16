#!/usr/bin/env bash
# $1 is working directory name
WORKING_DIR=$1
MODEL=$2

WORD_EMBEDDING=data/word_embedding/wiki.zh.wang2vec.100.vec

TRAIN_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-train.txt
DEV_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-development.txt


TRAIN_DATA=$WORKING_DIR/train.transitions
DEV_DATA=$WORKING_DIR/dev.transitions

TRAIN_CONLL_LEMMA=$1/train.conll.pb.lemmas


#train
cmake-build-debug/parser/lstm-parse --predict -T $TRAIN_DATA -d $DEV_DATA --model $MODEL -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA  -g $DEV_CONLL_DATA -e eval09.pl -s dev.predictions.conll