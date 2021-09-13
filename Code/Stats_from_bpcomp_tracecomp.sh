#!/bin/bash

for dataset in $1
do

    ds=$(basename -- "$dataset")
    extension="${ds##*.}"
    ds="${ds%.*}"
    script_name=$1
    bash_script_name="${script_name}_${ds}.sh"

echo "#!/bin/bash
#SBATCH --job-name=${ds}
#SBATCH --output=slurm_${ds}.log
#SBATCH --error=slurm_${ds}.err
#SBATCH --ntasks=2
#SBATCH --mem=2G
#SBATCH --qos=high
#
#SBATCH --mail-user=ksenia.juravel@lmu.de
#SBATCH --mail-type=ALL


for i in ../output/${ds}*.trees; do awk -F'\t' '{print \$2}' \$i | sed '1,1d'  > \$i.tree;echo \$i.tree;done
#change tree file format to fit in Phylobase
mkdir ${ds}
cd ${ds}/
pwd
bpcomp ../../output/${ds}_run_1.trees.tree ../../output/${ds}_run_2.trees.tree ../../output/${ds}_run_3.trees.tree ../../output/${ds}_run_4.trees.tree;
tracecomp  ../../output/${ds}_run_1.log ../../output/${ds}_run_2.log ../../output/${ds}_run_4.log ../../output/${ds}_run_3.log;
cat tracecomp.contdiff
cat bpcomp.con.tre;
#convergance for all 4 runs

#convergance for all possible tree combinations
mkdir 1_2
cd 1_2
pwd
bpcomp  ../../../output/${ds}_run_1.trees.tree  ../../../output/${ds}_run_2.trees.tree 
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp ../../../output/${ds}_run_1.log ../../../output/${ds}_run_2.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/
fi

mkdir 1_3
cd 1_3
pwd
bpcomp  ../../../output/${ds}_run_1.trees.tree  ../../../output/${ds}_run_3.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp ../../../output/${ds}_run_1.log ../../../output/${ds}_run_3.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/
fi

mkdir 1_4
cd 1_4
pwd
bpcomp  ../../../output/${ds}_run_1.trees.tree  ../../../output/${ds}_run_4.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp ../../../output/${ds}_run_1.log ../../../output/${ds}_run_4.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi  


mkdir 2_3
cd 2_3
pwd
bpcomp  ../../../output/${ds}_run_2.trees.tree  ../../../output/${ds}_run_3.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp ../../../output/${ds}_run_2.log ../../../output/${ds}_run_3.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi

mkdir 2_4
cd 2_4
pwd
bpcomp  ../../../output/${ds}_run_2.trees.tree  ../../../output/${ds}_run_4.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp  ../../../output/${ds}_run_2.log  ../../../output/${ds}_run_4.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi


mkdir 3_4
cd 3_4
pwd
bpcomp  ../../../output/${ds}_run_3.trees.tree  ../../../output/${ds}_run_4.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp ../../../output/${ds}_run_4.log ../../../output/${ds}_run_3.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi


mkdir 1_2_3
cd 1_2_3
pwd
bpcomp  ../../../output/${ds}_run_1.trees.tree  ../../../output/${ds}_run_2.trees.tree   ../../../output/${ds}_run_3.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp ../../../output/${ds}_run_1.log ../../../output/${ds}_run_2.log ../../../output/${ds}_run_3.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi

mkdir 1_2_4
cd 1_2_4
pwd
bpcomp  ../../../output/${ds}_run_1.trees.tree  ../../../output/${ds}_run_2.trees.tree   ../../../output/${ds}_run_4.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp  ../../../output/${ds}_run_1.log  ../../../output/${ds}_run_2.log  ../../../output/${ds}_run_4.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi


mkdir 1_3_4
cd 1_3_4
pwd
bpcomp  ../../../output/${ds}_run_1.trees.tree  ../../../output/${ds}_run_3.trees.tree  ../../../output/${ds}_run_4.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp  ../../../output/${ds}_run_1.log  ../../../output/${ds}_run_3.log  ../../../output/${ds}_run_4.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi

mkdir 2_3_4
cd 2_3_4
pwd
bpcomp  ../../../output/${ds}_run_2.trees.tree  ../../../output/${ds}_run_3.trees.tree  ../../../output/${ds}_run_4.trees.tree
VAL=`grep 'maxdiff' bpcomp.bpdiff | awk -F':' '{print \$2}'`
if [ \$VAL<0.3 ] || [ \$VAL=0.3 ]; then
tracecomp  ../../../output/${ds}_run_2.log  ../../../output/${ds}_run_3.log  ../../../output/${ds}_run_4.log;
cat tracecomp.contdiff;
cat bpcomp.con.tre;
cd ..
else
cd ..
rm -r ${ds}/;
fi


cd ..
rm ../output/${ds}*.trees.tree
" > ${bash_script_name}


        sbatch -p lemmium ${bash_script_name}

done
