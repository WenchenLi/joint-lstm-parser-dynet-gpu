# lstm-parser
Transition-based joint syntactic dependency parser and semantic role labeler using stack LSTM RNN architecture

#### Required software

 * A C++ compiler supporting the [C++11 language standard](https://en.wikipedia.org/wiki/C%2B%2B11), g++4.8.5 tested working
 * [Boost](http://www.boost.org/) libraries, 1.60 compiled with g++4.8.5 
 * [Eigen](http://eigen.tuxfamily.org) (newer versions strongly recommended, 3.3.3)
 * [CMake](http://www.cmake.org/)
 * This runs with the older version of cnn/dynet : `cnn-v1`

#### Checking out the project for the first time

The first time you clone the repository, you need to sync the `cnn/` submodule.(eigen and boost install included)

    sh scripts/prepare_submodule.sh

#### Build instructions

    sh scripts/build.sh

#### Train a parsing model

The data must be in the [CoNLL 2009 format](https://ufal.mff.cuni.cz/conll2009-st/task-description.html). For best performance, it is suggested to [projectivize the treebank data](http://www.maltparser.org/userguide.html#singlemalt_info). As a preprocessing step, first convert the treebank data (in CoNLL 2009 format) into transitions, \*.transitions (this is a format usable by the joint parser), using the following commands.

    java -jar ../jointOracle.jar -inp train.conll -lemmas true > train.transitions
    java -jar ../jointOracle.jar -inp dev.conll > dev.transitions
    
Note that it is required to set the option ''lemmas'' to true for the training data, so that an auxilliary file, train.conll.pb.lemmas is generated, which saves the lemmas of all the predicate words. The joint parser can now run on the generated files.

    parser/lstm-parse -T train.transitions -d dev.transitions -w sskip.100.vectors --propbank_lemmas train.conll.pb.lemmas -g dev.conll -e ../eval09.pl -s dev.predictions.conll --out_model joint.model -t
    
Link to the word vectors that we used in the ACL 2015 paper for English: [sskip.100.vectors](https://drive.google.com/file/d/0B8nESzOdPhLsdWF2S1Ayb1RkTXc/view?usp=sharing). The evaluation script, eval09.pl, is provided by [CoNLL 2009](https://ufal.mff.cuni.cz/conll2009-st/scorer.html). The model is written to the current directory.

Note-1: you can also run it without word embeddings by removing the -w option for both training and parsing.

Note-2: the training process should be stopped when the development Macro F1 does not substantially improve anymore.

Note-3: the default hyperparameters are the same as in the [paper](http://arxiv.org/abs/1606.08954) for the CoNLL 2009 English model. These can be changed by altering the command-line options provided in the lstm-parse.cc code.

#### Parse data with your parsing model

The test.conll file must also be in to the [CoNLL 2009 data format](https://ufal.mff.cuni.cz/conll2009-st/task-description.html) .

    java -jar ../jointOracle.jar -inp test.conll > test.transitions

    parser/lstm-parse -T train.transitions -d test.transitions -w sskip.100.vectors --propbank_lemmas train.conll.pb.lemmas -m joint.model -s test.predictions.conll -g test.conll -e ../eval09.pl 

The parser will output a file test.predictions.conll with predicted syntax and SRL dependencies.

#### Citation

If you make use of this software, please cite the following:

    @inproceedings{swayamdipta:2016conll,
    author={Swabha Swayamdipta and Miguel Ballesteros and Chris Dyer and Noah A. Smith},
    title={Greedy, Joint Syntactic-Semantic Parsing with Stack LSTMs},
    booktitle={Proc. of CoNLL},
    year={2016}
    }

#### Contact

For questions and usage issues, please contact swabha@cs.cmu.edu



## current results
current result with wang2vec trained with wiki dump 

```
 **dev (iter=9900 epoch=44.4449)	 llh=0 ppl: 1 err: 1 las: 79.33 semF1: 78.89 macro:79.12	[1762 sents in 48764.3 ms]
[epoch=44 eta=0.0221239 clips=78 updates=100] update #9901 (epoch 44.4494)	 llh: 4479.1 ppl: 1.47692 err: 0.0833188
[epoch=44 eta=0.0221239 clips=81 updates=100] update #9902 (epoch 44.4539)	 llh: 4595.28 ppl: 1.49194 err: 0.0837541
[epoch=44 eta=0.0221239 clips=88 updates=100] update #9903 (epoch 44.4584)	 llh: 5370.55 ppl: 1.5307 err: 0.093698
[epoch=44 eta=0.0221239 clips=78 updates=100] update #9904 (epoch 44.4629)	 llh: 5197.99 ppl: 1.51209 err: 0.0
```

##
todo :
1. training got error to fix 

```$xslt
correct action SR(A1) not in the list of Valid Actions:
PR(UNK)
problem in forbidden actions implementation

```
2. gpu support[cnn module build to cuda]
dynet with gpu doesnt helps a lot on batch = 1, need to implement batch size options but doubt that
will helps a lot since computing related to other non matrix operations.[give more detail here] 


3. predict

3.1 predicate identification
    https://github.com/clab/lstm-parser
    
3.2 predict role labels
