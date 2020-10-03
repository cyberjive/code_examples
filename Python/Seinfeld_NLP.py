# -*- coding: utf-8 -*-
"""
Created on Tue Jul 17 11:33:51 2018

@author: james.putterman
"""
#todo: add bigram/trigram analysis, add functions where appropriate
#bring order to madness
#elaine: get out, kramer: giddyup, jerry: ?, george: summer of george?
#%matplotlib inline

import matplotlib
import matplotlib.pyplot as plt
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import wordpunct_tokenize
from nltk import ngrams #for multi-word phrases
from nltk.collocations import BigramCollocationFinder, TrigramCollocationFinder
from nltk.metrics import BigramAssocMeasures, TrigramAssocMeasures
from wordcloud import WordCloud as wc
from textblob import TextBlob
from itertools import tee
import collections


#load csv's to dataframes
df_episodes = pd.read_csv('episode_info.csv')
df_script = pd.read_csv('scripts.csv')

#print(df_script)

#take a peek at the dataframes
df_episodes.head()
df_script.tail()

# drop the 'Unnamed: 0' column from each as it corresponds to the index
df_episodes.drop('Unnamed: 0', axis=1, inplace=True)
df_script.drop('Unnamed: 0', axis=1, inplace=True)

#download NLTK stopwords
#nltk.download('stopwords')#not needed after initial run
stop = set(stopwords.words('english'))

#add punctuation to stopwords
stop.update(['.', ',', '"', "'", '?', '!', ':', ';', '(', ')', '[', ']', '{', '}'])

#set pyplot display parameters
#mpl.rcParams['figure.figsize']=(8.0,6.0)    #(6.0,4.0)
plt.rcParams['font.size']=10                #10 
plt.rcParams['savefig.dpi']=100             #72 
plt.rcParams['figure.subplot.bottom']=.1 

#df_dialogue_1 = df_script.loc[0:1307, 'Dialogue']#kludge slice by index

#pull the dialogue by season out and place it in a list object
def DialogueBySeason(snum):
    '''
    Takes the season number provided and extracts the 
    related dialogue from the dataframe
    Note: expects df_script to exist
    
    Args: snum - season number as integer
    
    Returns: Unorderd list of dialogue words for the provided season
    that are not in stopwords and are alphabetic chars
    '''
    #create a new df with the provided arg
    df = df_script.loc[df_script['Season']==snum]
    #pull just the dialogue
    df = df['Dialogue']
    s = ''
    #separate the pandas series and cast to a string
    s = df.str.cat(sep = ' ')
    #cast the string to a list
    s_list = [i.lower() for i in wordpunct_tokenize(s) if i.lower() not in stop
              and i.isalpha()]
    return s_list
    

#df_dialogue = DialogueBySeason(5)    

#transform the series to a string and pass to TextBlob
#frist season
#blob_1 = df_dialogue_1.to_string()
#blob_1 = TextBlob(blob_1)
#
##second season
#blob_2 = df_dialogue_2.to_string()
#blob_2 = TextBlob(blob_2)

#calculate the frequency of words in the text
def MostCommon(slist):
    '''
    Takes a list and returns the frequency distribution
    of the top 30 words
    
    Args: slist - list of strings
    '''
    #create a new nltk frequency object
    fd = nltk.FreqDist(slist)
    #popualte with the top 30
    mostCommon = fd.most_common(30)
    return mostCommon

    
freq5 = MostCommon(df_dialogue)

def PlotFrequency(freq):
    '''
    Plots a frequency list via pyplot
    
    Args: freq - a frequency list
    '''
    #horizontal axis
    plt.barh(range(len(freq)), [val[1] for val in freq], align='center')
    #vertical axis
    plt.yticks(range(len(freq)), [val[0] for val in freq])
    plt.show()

    
PlotFrequency(freq5)

#creat a WordCloud
#create the wordcloud object from the corpus
wordcloud_1 = wc(
                          background_color='white',
                          stopwords=stop,
                          max_words=200,
                          max_font_size=40, 
                          random_state=42
                         ).generate(str(df_script['Dialogue']))

#print the object
print(wordcloud_1)

#set up the canvas and plot the actual cloud
fig = plt.figure(1)
plt.imshow(wordcloud_1)
plt.axis('off')
plt.show()
fig.savefig("word1.png", dpi=900)

#word cloud for S02
wordcloud_2 = wc(
                          background_color='white',
                          stopwords=stop,
                          max_words=200,
                          max_font_size=40, 
                          random_state=42
                         ).generate(str(df_script['Dialogue'][1308:4384]))

#print the object
print(wordcloud_2)

#set up the canvas and plot the actual cloud
fig = plt.figure(1)
plt.imshow(wordcloud_2)
plt.axis('off')
plt.show()
fig.savefig('word1.png', dpi=900)


#play around with some bigrams
#bigram finder - 10 bigrams with the highest pairing likelihood
finder = BigramCollocationFinder.from_words(s5_list)
finder.nbest(BigramAssocMeasures.likelihood_ratio, 20)

finder2 = TrigramCollocationFinder.from_words(s4_list)
finder2.nbest(TrigramAssocMeasures.likelihood_ratio, 20)

#phrases = s1_list
n = 3
bigrams = ngrams(mostCommon_2, n)
for gram in bigrams:
    print(gram)

#print(df_episodes)
#print(df_script)
