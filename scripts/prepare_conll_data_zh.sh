#!/usr/bin/env bash
# $1 is working directory name
WORKING_DIR=$1
mkdir -p $WORKING_DIR

WORD_EMBEDDING=data/word_embedding/wiki.zh.wang2vec.100.vec

TRAIN_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-train.txt
DEV_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-development.txt
TEST_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-evaluation-Chinese.txt


TRAIN_DATA=$WORKING_DIR/train.transitions
DEV_DATA=$WORKING_DIR/dev.transitions
TEST_DATA=$WORKING_DIR/test.transitions
#working scripts for train and dev in conll09 format
java -jar jointOracle.jar -inp $TRAIN_CONLL_DATA -lemmas true >$TRAIN_DATA
java -jar jointOracle.jar -inp $DEV_CONLL_DATA > $DEV_DATA
java -jar jointOracle.jar -inp $TEST_DATA > $TEST_DATA

LEMMA_FILE_SUFFIX='.pb.lemmas'
TRAIN_CONLL_LEMMA=$TRAIN_CONLL_DATA$LEMMA_FILE_SUFFIX
cp $TRAIN_CONLL_LEMMA $WORKING_DIR/train.conll.pb.lemmas
rm $TRAIN_CONLL_LEMMA
TRAIN_CONLL_LEMMA=$WORKING_DIR/train.conll.pb.lemmas

#train
cmake-build-debug/parser/lstm-parse -T $TRAIN_DATA -d $DEV_DATA -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA -g $DEV_CONLL_DATA -e eval09.pl -s dev.wang2.predictions.conll --out_model $WORKING_DIR/joint.model -t -P
#build/parser/lstm-parse