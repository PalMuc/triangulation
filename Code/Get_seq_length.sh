#!/bin/bash

## From: https://github.com/stephenturner/oneliners#awk--sed-for-bioinformatics

sed -i 's/ .*//g' $1;
cat $1 | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' >> length_all_sp;
