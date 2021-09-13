#!/bin/bash

#USAGE:
#1) Use the correct combination of species
#2) this_file.sh in_file.nexus out_file (ex:Opi-ortho-neAb#)

############################ 1) species combination for pruned file #########################

#If you don't want the species to be included in the dataset uncoment it.

#XENO_
#sed -i '/^MEST/d' $1
#sed -i '/^NEWE/d' $1
#sed -i '/^PSVA/d' $1
#sed -i '/^SYRO/d' $1
sed -i '/^XEBO/d' $1

#ICHT_
sed -i '/^CAOW/d' $1
sed -i '/^SPAR/d' $1

#ECHI_
sed -i '/^AUMO/d' $1
sed -i '/^OPFA/d' $1

#OUTG_
sed -i '/^CRNE/d' $1
sed -i '/^MAOR/d' $1
sed -i '/^SACE/d' $1
sed -i '/^SCPO/d' $1
sed -i '/^ALMA/d' $1
sed -i '/^SPPU/d' $1

#long_branch
sed -i '/^CAEL/d' $1
sed -i '/^PRPA/d' $1
sed -i '/^SCMA/d' $1

################################ 2) convert to new pruned nexus format file ###################

#nexus format of 1/0 to DNA/protein readable
sed -i 's/1/a/g' $1
sed -i 's/0/g/g' $1

#nexus readable format to fasta
squizz -c FASTA $1 > $2
#back to 1/0 format
sed -i 's/[a]/1/g' $2
sed -i 's/[g]/0/g' $2

#create header file
grep '>' $2 | tr -s '\n' ' ' | sed 's/>//g' > header_new.txt

#make long/linear fasta
awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $2 > out_long.fasta
tr "\t" "\n" < out_long.fasta >  $2


sed -i 's/0/0,/g' $2
sed -i 's/1/1,/g' $2

#make matrix for species of interest
VAR=$(cat header_new.txt)
for i in $VAR; do grep -A 1 "$i" $2 | tail -n 1 ;done > file_for_awk

bash /home/kjurave/Scripts/awk.sh file_for_awk > table.$2
sed -i 's/,/ /g' table.$2

#bash script for matrix to  fasta and perl for fasta to nexus interlived formating
bash /home/kjurave/Scripts/copy_code.sh table.$2 > Summary.table.$2
perl /home/kjurave/Scripts/Sequence-manipulation/Fasta2Nexus.pl table.$2.fasta table.$2.nexus

head table.$2.nexus
########################### 3) clean folder #########################################

rm table.$2 pasted_list_no_header_Sum.txt pasted_list_no_header_Sum_no_singeltons.txt out_long.fasta header_pasted_list_Sum_no_singeltons_columns_to_lines.txt header_new.txt file_for_awk $2 table.$2.fasta
