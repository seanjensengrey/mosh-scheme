#!/bin/bash

# Text file => markov-input.txt
#mecab -Owakati < ./data.txt > markov-input.txt

mecab -Owakati < ~/higepon/diary.txt > markov-input.txt

# Make dictionary
../../mosh markov.ss markov-input.txt
