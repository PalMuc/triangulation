#!/bin/bash

# by: Ksenia Juravel
# Usage: $1 the matrice for changes, add redirect to utput and change species for replacment in [[ XXXX ]]
  
#while read -r line; do if [[ $line =~ ^MEST ]] || [[ $line =~ ^NEWE ]] || [[ $line =~ ^PSVA ]] || [[ $line =~ ^SYRO ]] ; then echo "$line" | sed 's/0/?/g'; else echo "$line"; fi ; done < $1
#while read -r line; do if [[ $line =~ ^OPFA ]] || [[ $line =~ ^AUMO ]]  ; then echo "$line" | sed 's/0/?/g'; else echo "$line"; fi ; done < $1
while read -r line; do if [[ $line =~ ^XEBO ]] ; then echo "$line" | sed 's/0/?/g'; else echo "$line"; fi ; done < $1
