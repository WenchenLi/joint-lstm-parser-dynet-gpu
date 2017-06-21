#!/usr/bin/env bash
# $1 is working directory name
WORKING_DIR=$1
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
java -jar jointOracle.jar -inp $TRAIN_CONLL_DATA -lemmas true >$TRAIN_DATA
java -jar jointOracle.jar -inp $DEV_CONLL_DATA > $DEV_DATA
java -jar jointOracle.jar -inp $TEST_DATA > $TEST_DATA
#java -jar jointOracle.jar -inp $TEST_OOD_DATA > $TEST_OOD_DATA


LEMMA_FILE_SUFFIX='.pb.lemmas'
TRAIN_CONLL_LEMMA=$TRAIN_CONLL_DATA$LEMMA_FILE_SUFFIX
cp $TRAIN_CONLL_LEMMA $WORKING_DIR/train.conll.pb.lemmas
rm $TRAIN_CONLL_LEMMA
TRAIN_CONLL_LEMMA=$WORKING_DIR/train.conll.pb.lemmas

#train

build/parser/lstm-parse -T $TRAIN_DATA -d $DEV_DATA -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA -g $DEV_CONLL_DATA -e eval09.pl -s dev.predictions.conll --out_model $WORKING_DIR/joint.model -t
##!/usr/bin/env bash
## $1 is working directory name
#WORKING_DIR=$1
#mkdir -p $WORKING_DIR
#
#WORD_EMBEDDING=data/word_embedding/wiki.zh.100.vec
#
#TRAIN_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-train.txt
#DEV_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-development.txt
#TEST_CONLL_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-evaluation-Chinese.txt
##TEST_OOD_DATA=data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-evaluation-Chinese-ood.txt
#
#
#
#TRAIN_DATA=$WORKING_DIR/train.transitions
#DEV_DATA=$WORKING_DIR/dev.transitions
#TEST_DATA=$WORKING_DIR/test.transitions
##TEST_OOD_DATA=$WORKING_DIR/test_ood.transitions
##working scripts for train and dev in conll09 format
#java -jar jointOracle.jar -inp $TRAIN_CONLL_DATA -lemmas true >$TRAIN_DATA
#java -jar jointOracle.jar -inp $DEV_CONLL_DATA -lemmas true > $DEV_DATA
#java -jar jointOracle.jar -inp $TEST_CONLL_DATA -lemmas true > $TEST_DATA
##java -jar jointOracle.jar -inp $TEST_OOD_DATA > $TEST_OOD_DATA
#
#
#LEMMA_FILE_SUFFIX='.pb.lemmas'
#TRAIN_CONLL_LEMMA=$TRAIN_CONLL_DATA$LEMMA_FILE_SUFFIX
#DEV_CONLL_LEMMA=$DEV_CONLL_DATA$LEMMA_FILE_SUFFIX
#TEST_CONLL_LEMMA=$TEST_CONLL_DATA$LEMMA_FILE_SUFFIX
#
#cat $TRAIN_CONLL_LEMMA $DEV_CONLL_LEMMA $TEST_CONLL_LEMMA| sort | uniq > TRAIN_DEV_TEST.CONLL.pb.lemmas
#
#cp TRAIN_DEV_TEST.CONLL.pb.lemmas $WORKING_DIR/train_dev_test.conll.pb.lemmas
#rm TRAIN_DEV_TEST.CONLL.pb.lemmas
#TRAIN_CONLL_LEMMA=$WORKING_DIR/train_dev_test.conll.pb.lemmas
#
##train
#
#build/parser/lstm-parse -T $TRAIN_DATA -d $DEV_DATA -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA -g $DEV_CONLL_DATA -e eval09.pl -s dev.predictions.conll --out_model $WORKING_DIR/joint.model -t
#
#
##build/parser/lstm-parse -T TRAIN_DATA -d DEV_DATA -w sskip.100.vectors --propbank_lemmas train.conll.pb.lemmas -m joint.model -s test.predictions.conll -g test.conll -e ../eval09.pl
