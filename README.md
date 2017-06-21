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

##
todo :
1. training got error to fix 

```$xslt
correct action SR(A1) not in the list of Valid Actions:
PR(UNK)
problem in forbidden actions implementation

```
2.  gradient explosion
```
current hack make gradient nan
**dev (iter=4025 epoch=18.0725)        llh=0 ppl: 1 err: 1 las: 75.1 semF1: 75.65 macro:75.39 [1762 sents in 51216.1 ms]
[epoch=18 eta=0.0409836 clips=77 updates=100] update #4026 (epoch 18.0769)       llh: 4501.52 ppl: 1.51299 err: 0.0891362
[epoch=18 eta=0.0409836 clips=86 updates=100] update #4027 (epoch 18.0814)       llh: 5841.3 ppl: 1.53908 err: 0.10172
[epoch=18 eta=0.0409836 clips=89 updates=100] update #4028 (epoch 18.0859)       llh: 5955.3 ppl: 1.58737 err: 0.103197
[epoch=18 eta=0.0409836 clips=88 updates=100] update #4029 (epoch 18.0904)       llh: 5891.7 ppl: 1.54167 err: 0.0959518
[epoch=18 eta=0.0409836 clips=88 updates=100] update #4030 (epoch 18.0949)       llh: 5588.3 ppl: 1.54219 err: 0.0983721
[epoch=18 eta=0.0409836 clips=89 updates=100] update #4031 (epoch 18.0994)       llh: 5093.78 ppl: 1.54176 err: 0.0980792
[epoch=18 eta=0.0409836 clips=85 updates=100] update #4032 (epoch 18.1039)       llh: 5826.4 ppl: 1.54301 err: 0.0961066
[epoch=18 eta=0.0409836 clips=88 updates=100] update #4033 (epoch 18.1084)       llh: 5297.95 ppl: 1.55089 err: 0.100472
[epoch=18 eta=0.0409836 clips=83 updates=100] update #4034 (epoch 18.1129)       llh: 5509.8 ppl: 1.55862 err: 0.101248
[epoch=18 eta=0.0409836 clips=89 updates=100] update #4035 (epoch 18.1173)       llh: 5945.88 ppl: 1.55051 err: 0.0982518
[epoch=18 eta=0.0409836 clips=89 updates=100] update #4036 (epoch 18.1218)       llh: 5277.17 ppl: 1.52641 err: 0.0945664
[epoch=18 eta=0.0409836 clips=83 updates=100] update #4037 (epoch 18.1263)       llh: 6026.03 ppl: 1.56471 err: 0.102749
[epoch=18 eta=0.0409836 clips=83 updates=100] update #4038 (epoch 18.1308)       llh: 5271.08 ppl: 1.54794 err: 0.0989721
[epoch=18 eta=0.0409836 clips=92 updates=100] update #4039 (epoch 18.1353)       llh: 5786.81 ppl: 1.5438 err: 0.0983791
[epoch=18 eta=0.0409836 clips=86 updates=100] update #4040 (epoch 18.1398)       llh: 5604.69 ppl: 1.54776 err: 0.104045
[epoch=18 eta=0.0409836 clips=86 updates=100] update #4041 (epoch 18.1443)       llh: 5725.68 ppl: 1.56422 err: 0.103766
[epoch=18 eta=0.0409836 clips=84 updates=100] update #4042 (epoch 18.1488)       llh: 5636.35 ppl: 1.54116 err: 0.0940066
[epoch=18 eta=0.0409836 clips=88 updates=100] update #4043 (epoch 18.1533)       llh: 5724.11 ppl: 1.58254 err: 0.105373
[epoch=18 eta=0.0409836 clips=85 updates=100] update #4044 (epoch 18.1577)       llh: 5202.94 ppl: 1.52103 err: 0.0973722
[epoch=18 eta=0.0409836 clips=84 updates=100] update #4045 (epoch 18.1622)       llh: 5881.26 ppl: 1.54797 err: 0.0978455
Magnitude of gradient is bad: nan
Aborted (core dumped)


```
3. gpu support[cnn module build to cuda]
last version of cnn doesnt support gpu running code. 
now try to refactor code to the current version of dynet for gpu support.


4. predict
