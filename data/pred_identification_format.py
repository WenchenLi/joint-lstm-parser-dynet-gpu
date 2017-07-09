#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
this script used to prepare the correct data format from conll2009
to train predicate identification part.
The transformed input for training:
<s> trouble~NN be~VBZ ,~, she~PRP have~VBZ lose~VBN it~PRP just~RB as~RB quickly~RB .~. </s> ||| <s> _ _ _ _ _ PRED _ _ _ _ _ </s>
"""

SENTENCE_START_SYM="<s>"
SENTENCE_END_SYM="</s>"
LEMMA_POS_SEPERATOR_SYM="~"
X_AND_Y_SEPERATOR="|||"
CHINESE_PTB_PUNCTUATION= "PU"

def transform_conll(conll_data_path,output_data_path,tag_for_punctuation=CHINESE_PTB_PUNCTUATION):
    with open(output_data_path,'w') as outfile:
        with open(conll_data_path) as infile:
            while True:
                sentence_to_be_written = []
                bufsize = 65536
                lines = infile.readlines(bufsize)
                if not lines:
                    break
                sentence = []#first for lemma, second for pos tag, thrid for PRED(USE Y as indicator)
                for line in lines:
                    if line == "\n":#new sentence
                        # print "".join(sentence)
                        x = []
                        y = []
                        assert len(sentence)%3 == 0, "sentence len should be multiplier of 3 "
                        for i in xrange(0,len(sentence)-1,3):

                            if sentence[i+1] != tag_for_punctuation:
                                x.append(sentence[i].strip()+LEMMA_POS_SEPERATOR_SYM+sentence[i+1].strip())
                            else:
                                x.append(sentence[i].strip() + LEMMA_POS_SEPERATOR_SYM + sentence[i].strip())
                            # print "".join(x), "".join(y)
                            y.append(sentence[i+2])

                        sentence_to_be_written.append(SENTENCE_START_SYM + " " + " ".join(x) + " " + SENTENCE_END_SYM + \
                                                      " " + X_AND_Y_SEPERATOR +  " " + \
                                                      SENTENCE_START_SYM + " " + " ".join(y) + " " + SENTENCE_END_SYM)

                        sentence = []
                    else:
                        sl = line.split('\t')
                        l_t_p = (sl[2],sl[4],sl[12]) #lemma, tag, is_PRED
                        sentence.extend(l_t_p) # extend is the fastest compared to append and extend list

                for s in sentence_to_be_written:
                    outfile.writelines(s+"\n")

if __name__ == "__main__":
    conll_data_path = '/home/wenchen/gpu/joint-lstm-parser-dynet-gpu/data/conll2009/CoNLL2009-ST-Chinese/CoNLL2009-ST-Chinese-train.txt'
    out_data_path= '/home/wenchen/gpu/joint-lstm-parser-dynet-gpu/data/conll2009/CoNLL2009-ST-Chinese/train_pred_identification_data.txt'
    transform_conll(conll_data_path,out_data_path)


