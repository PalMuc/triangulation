#!/bin/bash

#SBATCH --job-name=OrthiFinder
#SBATCH --output=output.orthofinder.%j.%N.log
#SBATCH --error=error.orthofinder.%j.%N.log
#SBATCH --ntasks=16
#SBATCH --mem=50G
#SBATCH --mail-user ksenia.juravel@lmu.de
#SBATCH --mail-type=ALL
#SBATCH --qos=high


Comment and uncomment species of interest to generate the Aco and Xen datasets
#sed -i 's/56:/#56:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/#52:/52:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/#53:/53:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/#54:/54:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/#55:/55:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/66:/#66:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/35:/#35:/g' /home/kjurave/less_outgroups_47_species/OrthoFinder/Results_Sep26/WorkingDirectory/SpeciesIDs.txt;

#sed -i 's/#61:/61:/g' /home/kjurave/less_outgroups_47_species/OrthoFinder/Results_Sep26/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/#62:/62:/g' /home/kjurave/less_outgroups_47_species/OrthoFinder/Results_Sep26/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/#60:/60:/g' /home/kjurave/less_outgroups_47_species/OrthoFinder/Results_Sep26/WorkingDirectory/SpeciesIDs.txt;

#sed -i 's/#35:/35:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;
#sed -i 's/#36:/36:/g' /home/kjurave/less_outgroups_47_species/A_srtaregy/1/Results_Sep26/WorkingDirectory/OrthoFinder/Results_Sep29_3/WorkingDirectory/SpeciesIDs.txt;

#-b prev
#-f new

python2 /home/kjurave/Softwers/OrthoFinder_source/orthofinder/orthofinder.py -b $1 -f $2 -t 16 -a 16;
