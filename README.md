# join syntactic and semantic parser
Transition-based joint syntactic dependency parser and semantic role labeler using stack LSTM RNN architecture

#### Required software

 * A C++ compiler supporting the [C++11 language standard](https://en.wikipedia.org/wiki/C%2B%2B11), g++4.8.5 tested working
 * [Boost](http://www.boost.org/) libraries, 1.60 compiled with g++4.8.5 
 * [Eigen](http://eigen.tuxfamily.org) (newer versions strongly recommended, 3.3.3)
 * [CMake](http://www.cmake.org/)
 * [intel mkl](https://software.intel.com/en-us/mkl)[default required]recommended,speed up parser training 1.5~2 faster
 * This runs with the older version of dynet : `commit:814f1819e4b7a75cb490b6a242a40e55f5ce7a1b
`notice: might not work with dynet 2.0 (not tested)

#### Checking out the project for the first time

The first time you clone the repository, you need to sync the `dynet/` submodule.(eigen and boost install included)

    sh scripts/prepare_submodule.sh

#### Prepare other dependencies
    ```
    sh scripts/prepare_eigen.sh
    sh scripts/prepare_boost.sh
    sh scripts/prepare_mkl.sh
    ```
#### Build instructions

    sh scripts/build.sh

#### Train a parsing model
Once you successfully build lstm-parse, we can continue to train the model:

```
sh scripts/prepare_conll_data_and_train_zh.sh $WORKING_DIR $EMBEDDING
 
```
$WORKING_DIR keeps reference to the trained model(joint.model), as well as all the necessary train/dev data
$EMBEDDING to specify the word embedding to train the model, [wang2vec](https://github.com/wlin12/wang2vec) suggested. 

to resume training:

```
sh scripts/resume_training.sh $WORKING_DIR $WORD_EMBEDDING $MODEL
```

#### Testing 
`sh scripts/test.sh $WORKING_DIR $WORD_EMBEDDING $MODEL`

#### Predicting

```
sh scripts/predict.sh $WORKING_DIR $WORD_EMBEDDING $MODEL
```

## current results

###  result on official conll 2009 dev data with wang2vec trained with wiki dump, use mkl on single thread.

```
[epoch=69 eta=0.0153374 clips=85 updates=100] update #15394 (epoch 69.1072)	 llh: 4980.81 ppl: 1.51411 err: 0.0898642
[epoch=69 eta=0.0153374 clips=85 updates=100] update #15395 (epoch 69.1116)	 llh: 4838.37 ppl: 1.49128 err: 0.0852399
[epoch=69 eta=0.0153374 clips=75 updates=100] update #15396 (epoch 69.1161)	 llh: 4759.13 ppl: 1.4869 err: 0.0904393
[epoch=69 eta=0.0153374 clips=84 updates=100] update #15397 (epoch 69.1206)	 llh: 5141.25 ppl: 1.47943 err: 0.0887484
[epoch=69 eta=0.0153374 clips=89 updates=100] update #15398 (epoch 69.1251)	 llh: 5748.75 ppl: 1.52395 err: 0.0948333
[epoch=69 eta=0.0153374 clips=85 updates=100] update #15399 (epoch 69.1296)	 llh: 4799.43 ppl: 1.49627 err: 0.0897565
[epoch=69 eta=0.0153374 clips=81 updates=100] update #15400 (epoch 69.1341)	 llh: 5530.8 ppl: 1.52136 err: 0.0899021
  **dev (iter=15400 epoch=69.1341)	 llh=0 ppl: 1 err: 1 las: 79.01 semF1: 79.04 macro:79.04	[1762 sents in 39816.8 ms]

```

### result on our own conll 2009 data  with wang2vec trained with wiki dump, use mkl on single thread.

```

[epoch=70 eta=0.0151515 clips=56 updates=100] update #12996 (epoch 70.6858)	 llh: 1139.36 ppl: 1.37206 err: 0.0816213
[epoch=70 eta=0.0151515 clips=57 updates=100] update #12997 (epoch 70.6912)	 llh: 1017.06 ppl: 1.33381 err: 0.0705183
[epoch=70 eta=0.0151515 clips=52 updates=100] update #12998 (epoch 70.6967)	 llh: 982.284 ppl: 1.34805 err: 0.0741867
[epoch=70 eta=0.0151515 clips=46 updates=100] update #12999 (epoch 70.7021)	 llh: 886.387 ppl: 1.29362 err: 0.06535
[epoch=70 eta=0.0151515 clips=56 updates=100] update #13000 (epoch 70.7076)	 llh: 1011.8 ppl: 1.31518 err: 0.074736
  **dev (iter=13000 epoch=70.7076)	 llh=0 ppl: 1 err: 1 las: 88.01 semF1: 76.9 macro:82.46	[3294 sents in 13458.6 ms]
[epoch=70 eta=0.0151515 clips=56 updates=100] update #13001 (epoch 70.713)	 llh: 1010.82 ppl: 1.3321 err: 0.0729078
[epoch=70 eta=0.0151515 clips=49 updates=100] update #13002 (epoch 70.7184)	 llh: 989.865 ppl: 1.33044 err: 0.0695125
[epoch=70 eta=0.0151515 clips=49 updates=100] update #13003 (epoch 70.7239)	 llh: 842.52 ppl: 1.29604 err: 0.0627886
[epoch=70 eta=0.0151515 clips=48 updates=100] update #13004 (epoch 70.7293)	 llh: 960.099 ppl: 1.3176 err: 0.0669348
[epoch=70 eta=0.0151515 clips=56 updates=100] update #13005 (epoch 70.7348)	 llh: 916.987 ppl: 1.30957 err: 0.0682353


```


## online predict

Here is the example input to the parsing system:

under example/ predict_example.transition:
we have input[to get the input, please see predicate_identification project]:
```

中国-NR, 最大-JJ, 氨纶丝-NN, 生产-NN, 基地-NN, 在-P, 连云港-NR, 建成-VV~建成, ROOT-NOTAG

王翔-NR, 虽-CS, 年过半百-VV~年过半百, ，-PU, 但-AD, 其-PN, 充沛-VV~充沛, 的-DEC, 精力-NN, 和-CC, 敏捷-NN~敏捷, 的-DEG, 思维-NN, ，-PU, 给-VV~给, 人-NN, 以-P, 一-CD, 个-M, 挑战者-NN, 的-DEG, 印象-NN, 。-PU, ROOT-NOTAG

```
and the system output:
```
predicates:
7:PR(建成.01)
sem-arcs:
4<- 7[SL(A1)], 
5<- 7[SL(LOC)], 
syn-arcs:
4-LA(NMOD)->0
4-LA(AMOD)->1
4-LA(NMOD)->2
4-LA(NMOD)->3
7-LA(SBJ)->4
7-LA(LOC)->5
5-RA(OBJ)->6
8-LA(ROOT)->7
-1-ERROR->8
predicates:
2:PR(UNK)
6:PR(充沛.01)
10:PR(UNK)
14:PR(给.01)
sem-arcs:
0<- 2[SL(A0)], 
1<- 2[SL(DIS)], 
8<- 6[SR(A0)], 
12<- 10[SR(A0)], 
15<- 14[SR(A1)], 
syn-arcs:
2-LA(SBJ)->0
2-LA(ADV)->1
22-LA(ADV)->2
22-LA(UNK)->3
22-LA(ADV)->4
8-LA(NMOD)->5
7-LA(COMP)->6
8-LA(RELC)->7
22-LA(SBJ)->8
8-RA(CJTN)->9
11-LA(COMP)->10
12-LA(RELC)->11
9-RA(CJT)->12
22-LA(UNK)->13
22-LA(ADV)->14
14-RA(COMP)->15
22-LA(MNR)->16
19-LA(DMOD)->17
17-RA(COMP)->18
20-LA(COMP)->19
21-LA(NMOD)->20
16-RA(OBJ)->21
23-LA(ROOT)->22
-1-ERROR->23
```

where parsing sentence results are seperated by -1-ERROR->num, and for each sentence, 
we have sentence predicate disambiguation:predicates:
semantic dependencies: sem-arcs, 
and syntactic dependencies: syn-arcs. 
Notice the order of the sentence start from 0. 

Below, is an example:

data input to the parser system: 
```
中国-NR, 最大-JJ, 氨纶丝-NN, 生产-NN, 基地-NN, 在-P, 连云港-NR, 建成-VV~建成, ROOT-NOTAG

```

data output by the parser system:
```
predicates:
7:PR(建成.01)
sem-arcs:
4<- 7[SL(A1)], 
5<- 7[SL(LOC)], 
syn-arcs:
4-LA(NMOD)->0
4-LA(AMOD)->1
4-LA(NMOD)->2
4-LA(NMOD)->3
7-LA(SBJ)->4
7-LA(LOC)->5
5-RA(OBJ)->6
8-LA(ROOT)->7
-1-ERROR->8

```

data conll 2009 format:
```
1	中国	中国	中国	NR	NR	_	_	5	5	NMOD	NMOD	_	_	_
2	最大	最大	最大	JJ	JJ	_	_	5	5	AMOD	AMOD	_	_	_
3	氨纶丝	氨纶丝	氨纶丝	NN	NN	_	_	5	5	NMOD	NMOD	_	_	_
4	生产	生产	生产	NN	NN	_	_	5	5	NMOD	NMOD	_	_	_
5	基地	基地	基地	NN	NN	_	_	8	8	SBJ	SBJ	_	_	A1
6	在	在	在	P	P	_	_	8	8	LOC	LOC	_	_	LOC
7	连云港	连云港	连云港	NR	NR	_	_	6	6	OBJ	OBJ	_	_	_
8	建成	建成	建成	VV	VV	_	_	0	0	ROOT	ROOT	Y	建成.01	_

```

you can compare to the gold standard[data conll 2009 format], the parser correctly 
a. disambiguate the predicate
b. find the semantic dependencies[4<- 7, 5<- 7] and it's role [SL(A1),SL(LOC)], where SL are transition actions. 


# references

1.[Swayamdipta, Swabha et al. “Greedy, Joint Syntactic-Semantic Parsing with Stack LSTMs.” CoNLL (2016).](https://www.semanticscholar.org/paper/Greedy-Joint-Syntactic-Semantic-Parsing-with-Stack-Swayamdipta-Ballesteros/777a1606544ee8348f5154d483bae65b2a50b8b6)
[paper presentation ACL](http://techtalks.tv/talks/greedy-joint-syntactic-semantic-parsing-with-stack-lstms/63397/)
[slides](https://www.cs.cmu.edu/~sswayamd/talks/conll16.pdf)

2.[Ling, Wang et al. “Two/Too Simple Adaptations of Word2Vec for Syntax Problems.” HLT-NAACL (2015).](https://www.semanticscholar.org/paper/Two-Too-Simple-Adaptations-of-Word2Vec-for-Syntax-Ling-Dyer/b92513dac9d5b6a4683bcc625b94dd1ced98734e)

