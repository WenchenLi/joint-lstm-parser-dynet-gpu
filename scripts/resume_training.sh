#!/usr/bin/env bash
# $1 is working directory name
WORKING_DIR=$1
model=$2
mkdir -p $WORKING_DIR

WORD_EMBEDDING=data/word_embedding/wiki.zh.wang2vec_short.100.vec

TRAIN_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-train.txt
DEV_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-development.txt
TEST_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-evaluation-Chinese.txt
#TEST_OOD_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-evaluation-Chinese-ood.txt



TRAIN_DATA=$WORKING_DIR/train.transitions
DEV_DATA=$WORKING_DIR/dev.transitions
TEST_DATA=$WORKING_DIR/test.transitions
#TEST_OOD_DATA=$WORKING_DIR/test_ood.transitions
#working scripts for train and dev in conll09 format


TRAIN_CONLL_LEMMA=$1/train.conll.pb.lemmas


#train
#echo {build/parser/lstm-parse -T $TRAIN_DATA -d $DEV_DATA --model $2 -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA  -g $DEV_CONLL_DATA -e eval09.pl -s dev.predictions.conll -t}
build/parser/lstm-parse -T $TRAIN_DATA -d $DEV_DATA --model $2 -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA  -g $DEV_CONLL_DATA -e eval09.pl -s dev.wang.predictions.conll -t > train.log