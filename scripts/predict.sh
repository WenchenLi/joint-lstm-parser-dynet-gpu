#!/usr/bin/env bash
# $1 is working directory name
WORKING_DIR=$1
WORD_EMBEDDING=$2
MODEL=$3

WORD_EMBEDDING=data/word_embedding/wiki.zh.wang2vec.100.vec
TRAIN_DATA=$WORKING_DIR/train.transitions
TRAIN_CONLL_LEMMA=$1/train.conll.pb.lemmas
PREDICT_DATA=example/predict_example.transitions
#/home/wenchen/gpu/predicate_identification/input_to_joint_syn_sem_parser.predict
#predict
cmake-build-debug/parser/lstm-parse --predict -T $TRAIN_DATA --predict_data $PREDICT_DATA --model $MODEL -w $WORD_EMBEDDING --propbank_lemmas $TRAIN_CONLL_LEMMA -s dev.predictions.conll