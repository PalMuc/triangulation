#!/bin/bash

for dataset in $1
do
    WORKING_D=$(pwd)
    file_place=$(pwd | awk -F'/' '{print $4"_"$6}')
    ds=$(basename -- "$dataset")
    extension="${ds##*.}"
    ds="${ds%.*}"
    script_name=OrthoFinder
    bash_script_name="${file_place}_${ds}.sh"


echo ${ds}


echo "#!/bin/bash
#SBATCH --job-name=${file_place}_MCL_values_Ortho
#SBATCH --output=output_${ds}_${file_place}_MCL_values_E-values_OrthF.log
#SBATCH --error=error_${ds}_${file_place}_MCL_values_E-values_OrtoF.log
#SBATCH --ntasks=12
#SBATCH --mem=80G
#SBATCH --mail-user ksenia.juravel@lmu.de
#SBATCH --mail-type=ALL
#SBATCH --qos=normal


#/home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -b /home/kjurave/BLAST_all/Phylogeny_all/Final_dataset ;
#/home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -f $1 -S diamond -t 40;


#mkdir $1;
#for i in *.fa;do for j in *.dmnd;do echo \$i;echo \$j; filename=\$i; VAR=\${filename//[^0-9]/}; filename2=\$j; VAR2=\${filename2//[^0-9]/};diamond blastp -d \$j -q \$i -o $1/Blast\$VAR.\$VAR2.txt -p 28 -f 6 -e $1;done;done;
#cd $1/;
#for f in *.txt; do i="\${f%.txt}"; mv -i -- "\$f" "\${i//./_}.txt"; done;
#cd ..;

#awk -F' ' '{print \$1" "\$2}' SequenceIDs.txt > SequenceIDs_copy.txt;
#mv SequenceIDs.txt original_SequenceIDs.txt;
#mv SequenceIDs_copy.txt SequenceIDs.txt;

#mkdir $1;
#cp SpeciesIDs.txt $1/;
#cp SequenceIDs.txt $1/;
#cp *.dmnd $1/;
#cp *.fa $1/;
#cd $1/;
#for i in *.fa;do for j in *.dmnd;do echo $i;echo $j; filename=$i; VAR=${filename//[^0-9]/}; filename2=$j; VAR2=${filename2//[^0-9]/};diamond blastp -d $j -q $i -o $1/Blast$VAR.$VAR2.txt -p 10 -f 6 -e $1 --strand both;done;done;
#for f in *.txt; do i="${f%.txt}"; mv -i -- "$f" "${i//./_}.txt"; done;
#cd ..;
#cd $WORKING_D/;
#cp SpeciesIDs.txt $1/;
#cp SequenceIDs.txt $1/;
#cp *.fa $1/;
#cd $1/;
#awk -F' ' '{print \$1"_"\$2"_"\$4"_"\$5"_"\$6}' SequenceIDs.txt | sed 's/___//g' | sed 's/__//g' > tmp;
#mv tmp SequenceIDs.txt;
python2 /home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -I 1.5 -b $2 -a 12 -n evalue.$1.mcl_1_5;
#cp OrthoFinder/*.csv OrthoFinder/Orthologues_evalue.$1.mcl_1_5_*/;
#cat Orthogroups.csv | sed 's/OG[0-9][0-9][0-9][0-9][0-9][0-9][0-9]//g' | tr -s '\t' ' '| tr -s ', ' '        ' > ortho.$1.MCL1.5;
#sed -e '1,1d' < ortho.$1.MCL1.5 > ../ortho.$1.MCL1.5.mcl;

python2 /home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -I 2.5 -b $2 -a 12 -n evalue.$1.mcl_2_5;
#cp OrthoFinder/*.csv OrthoFinder/evalue.$1.mcl_2_5_*/;
#cat Orthogroups.csv | sed 's/OG[0-9][0-9][0-9][0-9][0-9][0-9][0-9]//g' | tr -s '\t' ' '| tr -s ', ' '        ' > ortho.$1.MCL2.5;
#sed -e '1,1d' < ortho.$1.MCL2.5 > ../ortho.$1.MCL2.5.mcl;

python2 /home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -I 2 -b $2 -a 12 -n evalue.$1.mcl_2;
#cp OrthoFinder/*.csv OrthoFinder/Orthologues_evalue.$1.mcl_2_*/;
#cat Orthogroups.csv | sed 's/OG[0-9][0-9][0-9][0-9][0-9][0-9][0-9]//g' | tr -s '\t' ' '| tr -s ', ' '        ' > ortho.$1.MCL2;
#sed -e '1,1d' < ortho.$1.MCL2 > ../ortho.$1.MCL2.mcl;

python2 /home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -I 4 -b $2 -a 12 -n evalue.$1.mcl_4;
#cp OrthoFinder/*.csv OrthoFinder/Orthologues_evalue.$1.mcl_4_*/;
#cat Orthogroups.csv | sed 's/OG[0-9][0-9][0-9][0-9][0-9][0-9][0-9]//g' | tr -s '\t' ' '| tr -s ', ' '        ' > ortho.$1.MCL4; 
#sed -e '1,1d' < ortho.$1.MCL4 > ../ortho.$1.MCL4.mcl;

python2 /home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -I 6 -b $2 -a 12 -n evalue.$1.mcl_6;
#cp OrthoFinder/*.csv OrthoFinder/Orthologues_evalue.$1.mcl_6_*/;
#cat Orthogroups.csv | sed 's/OG[0-9][0-9][0-9][0-9][0-9][0-9][0-9]//g' | tr -s '\t' ' '| tr -s ', ' '        ' > ortho.$1.MCL6; 
#sed -e '1,1d' < ortho.$1.MCL6 > ../ortho.$1.MCL6.mcl;

for i in $3/Orthogroups/Orthogroups.tsv; do cat $i | sed 's/OG[0-9][0-9][0-9][0-9][0-9][0-9][0-9]//g' | tr -s '\t' ' '| tr -s ', ' '        ' > $i.mcl;done
for i in $3/Orthogroups/Orthogroups.tsv.mcl;do sed -i '1,1d' $i; done
for i in $3/Orthogroups/Orthogroups.tsv.mcl; do python /home/kjurave/Scripts/does_specie_have_gene.py -i $i -o $i.out;done >> python_output
for i in $3/Orthogroups/Orthogroups.tsv.mcl.out; do bash /home/kjurave/Scripts/code_for_BLASTP_clusters.sh $i;done >> ${file_place}_${ds}_Singletons


cd ..;
cd ..;

" > ${bash_script_name}


        sbatch -p lemmium ${bash_script_name}

done
