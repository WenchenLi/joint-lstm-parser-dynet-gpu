#!/usr/bin/env bash
# $1 is working directory name
WORKING_DIR=$1
WORD_EMBEDDING=$2
MODEL=$3

#WORD_EMBEDDING=data/word_embedding/wiki.zh.wang2vec.100.vec

TRAIN_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-train.txt
TEST_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-evaluation-Chinese.txt
#TEST_OOD_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-evaluation-Chinese-ood.txt

TRAIN_DATA=$WORKING_DIR/train.transitions
TEST_DATA=$WORKING_DIR/test.transitions

TRAIN_CONLL_LEMMA=$1/train.conll.pb.lemmas

#train
cmake-build-debug/parser/lstm-parse --test -T $TRAIN_DATA -d $TEST_DATA --model $MODEL -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA  -g $TEST_CONLL_DATA -e eval09.pl -s test.predictions.conll