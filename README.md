
# Triangulation resolves controversial nodes in the animal tree of life #

We analyzed 47 genome-based proteomes with known tools and custom codes to test hypotheses of animal relationships, specifically focussing on the relationships of the two non-bilaterian lineages sponges (Porifera) and comb jellies (Ctenophora) (e.g., Simion et al. 2017), and a bilaterian lineage, the Xenacoelomorpha (e.g., Kapli and Telford 2020).
Here we investigate the phylogenetic signal in two independent data types, genome gene content and morphology, and use data triangulation (Munafò and Davey Smith 2018) to test patterns of phylogenetic congruence with amino-acid derived phylogenetic hypotheses. 
Using Bayes factors (Kass and Raftery 1995), we show that the different types of data strongly support sponges as the sister of all other animals – the Porifera-sister hypothesis – and Xenoacoelomorpha as sister to the other Bilateria – the Nephrozoa hypothesis. 
We provide a consistent phylogenetic framework to reconstruct the earliest stages of animal evolution by resolving these controversial nodes. 
This study illustrates the utility of multiple sources of phylogenetic information to address recalcitrant phylogenomic hypotheses.  

This repository includes all the codes used to analyze the data for the various phylogenies.

The results obtained in the different steps can be found for the morphology analysis in [Morphology/Morphology_files.zip](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Morphology/Morphology_files.zip) and provided upon request for the genome gene content (file is too big for the repository, it has ~3 T size uncompressed). 


All the steps are listed and described below.

### General workflow: ###

1. Extract proteins from genome based predictions for species of interest.
2. Check for similarity all vs. all.
3. Cluster the proteins into groups (homologous and orthologous).
4. Extract ortho- and homogroups.
5. Convert into matrices of absence and presence.
6. Generate phylogeny.
7. (Statistical investigation)

![Alt text](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Additional%20information/Figure2.jpg)

### Programs used: ###

Make sure to install the following tools:

[OrthoFinder](https://github.com/davidemms/OrthoFinder), [MCL](https://micans.org/mcl/), [DIAMOND](https://github.com/bbuchfink/diamond), [revBayes](https://revbayes.github.io/) and [homomcl](https://github.com/willpett/homomcl).
 

### Codes in this repository: ###

(In folder Code)

OrthoFinder_for_MCL_after_DIAMOND.sh - Used to re-run OrthoFinder with different I- and E-values.

Nexus2Fasta.pl - Before pruning convert nexus format matrix back to fasta format data type.

Nexus_Pruning.sh - Used to prune out the species from the matrix.

does_specie_have_gene.py - Used to convert MCL output into fasta format data.

stat_from_bpcomp_tracecomp.sh - Used to check convergence for the 4 chains for all possible combinations to find the best parameters. 

short_names_convert.sh - Used to translate from 4 letters short names of species to the formal names.

gene_content_original.Rev - code for revBayes adopted from [willpett](https://github.com/willpett/metazoa-gene-content). 


### How to re-run the analyses in this study: ###

Create a folder with the complete set of proteomes for the species of interest. Moreover, follow the following steps:

**Orthogroups**

Run OrthoFinder with DIAMOND using different E-values.

Alternatively, run OrthoFinder once and just re-run DIAMOND on previously generated results for different E-values.

Use the pre-calculated results for MCL step using different I values.

To automate this step use the code similarly to the one in (adoption to your computer and settings of the system required) [code for multiple OrthoFinder](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/OrthoFinder_for_MCL_after_DIAMOND.sh).

After generating the orthogroups file (Orthogroups.tsv, from OrthoFinder output) format it to fit the revBayes formatting in NEXUS using:

1. tsv --> mcl output format
2. mcl --> matrix of absence and presence
3. matrix --> fasta format
4. fasta --> NEXUS

(Or any other way to transfer the obtained results from tsv format to NEXUS).

5. Ensure to extract positions shared by less than two species (singletons extract).

6. Use the final output as input to the [revBayse analyses](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/mcmc_gene_content_original.Rev).

Optional - 7. Extract convergence statistics for the phylogenies.

Optional - 8. Calculate Bayes factor from MCMC samples, using the codes ([Morphology](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/metazoan_hypothesis_test_Luis.Rev), [Genome gene content](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/metazoan_hypothesis_test.Rev)), plot with [R script](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/plot_BF_2.R).  

Optionally: To convert short format names of Species to full scientific names use [Names_convert.sh](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/Names_convert.sh).


**Homogroups**

For the homologs prediction after DIAMOND analysis step (BLAST all vs. all),[extract length](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/Get_seq_length.sh) of the proteins for each species and run [homomcl](https://github.com/willpett/homomcl) to create abc format file. 

If you wish to have the final matrix use MCL.

If you want to analyze the different behaviors of the clusters use [clmprotocols](https://micans.org/mcl/man/clmprotocols.html).

Repeat steps 1-7 from Orthogroups prediction with the output from MCL.


**Outgroup sampling**

In this part, the study was performed using the default parameters of all tools.

Repeat Homogroups and orthogroups prediction as described above but reduce the outgroups species, use

i) The complete taxon sampling (Opisthokonta); 

ii) Ichthyosporea + Choanoflagellates + Metazoa (= Holozoa; dataset prefix Hol ), and

iii) Choanoflagellates + Metazoa (= Choanozoa; dataset prefix Cho) 

Repeat the steps of Orthogroups and Homogroups with the new taxa combination proteomes. 


**Long-Branch Attraction (LBA)**

We tested the effect of reducing specific taxa in two possible methods: first analyzing the data after reducing the taxa from start to end and second by reducing the data from an already pre-analyzed matrix. The last can significantly reduce the complexity of the analyzes. 

This part of the study was performed using the default parameters of all tools.

Repeat Homogroups and orthogroups prediction as described above but without the long-branched species

*Caenorhabditis elegans*, *Pristionchus pacificus*, and *Schistosoma mansoni*.

Also, combine this taxon sampling with Outgroup sampling section taxa sampling to create the ingroup test datasets - see [Additional information](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Additional%20information/Genome%20gene%20content%20datasets%20protocol.pdf).

Repeat the steps of Orthogroups and Homogroups with the new taxa combination proteomes. 


**Pruned**

For datasets creation using the pruning method, use the initial 47 species dataset NEXUS and the script [Nexus_Pruning.sh](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Code/Nexus_Pruning.sh).






### The data structure for the genome gene content ###

See file: [ _"Genome gene content datasets protocol"_ ](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Genome%20gene%20content%20datasets%20protocol.pdf)

### The output of this analysis ###

To recreate the initial species dataset download all the files in this repository folder [Species_Files](https://github.com/KseniaJuravel/triangulation-juravel-2021/tree/main/Species_Files) ending with *.fasta.xz.

All NEXUS files are in [Morphology_NEXUS.zip](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Morphology/Morphology_NEXUS.zip.xz) for the Morphology data and [Run_2.zip.xz](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/NEXUS/Run_2.zip.xz) for the genome gene content second iteration (and in  [Run_1.zip.xz](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/NEXUS/Run_1.zip.xz) for the first iteration).


Complete data can be found for the morphology analyses in [Morphology_files.zip](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Morphology/Morphology_files.zip) and provided upon request for the genome gene content (file is too big for repository ~3 T folder uncompressed).



### Supplementary tables: ###

(In folder Tables)

[Table S1](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Tables/Supplementary%20Table%201%20-%20Species%20data.csv): Information about all the data of species used in this research. 

[Table S2](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Tables/Supplementary%20Table%202%20-%20Run%201%20-%20Convergence%20statistics%20-%20Convergence%20statistics.csv): The summary of all datasets settings and results for run 1.

[Table S3](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Supplementary%20Table%203%20Run%202%20Results%20-%20Stats..csv): The summary of all datasets settings and results for run 2, a summary of all the details and the most probable tree for each of the 190 datasets tested, count of the support for each of the unique topologies observed by the individual posterior trees. 

 Section 3.1 - Row 4 to Row 73 Correspond to datasets in Supplementary Table 4.
 Section 3.2 - Row 74 to Row 193 Correspond to data for different E- and I- values tested (datasets for TPCT in Supplementary Figure 5)
 Section 3.3 - Row 194 to Row 405, Column C and Column AU Correspond to all statistical calculations in Supplementary Figure 4. 

[Table S4](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Tables/Supplementary%20Table%204%20-%20Supp.%20Table%204.pdf): Naming convention description for the long branch attraction tests for ingroups and outgroup-reduced datasets for long branches. 

[Table S5](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Tables/Supplementary%20Table%205%20BF%20Results%20-%20Results.csv): The Bayes factor (BF) calculation results.


### Glossary in this study: ###

_Homogroups_ - A set including homologous proteins that are predicted to be inherited from a common ancestor, all the proteins or parts, can include partial genes, orthologs, xenologs and paralogs. Contain any subset of the species, but no single species homogroups (proteins need to be shared by at least two species).

_Orthogroups_ - A set of orthologous proteins that are predicted to be inherited from a common ancestor and separated by a speciation event, can also include in-paralogs and partial genes. Contain any subset of the species, but no single species homogroups (proteins need to be shared by at least two species).

_Nchar_ - The number of positions in the final alignment (a matrix of alignment from 0 [absence] and 1 [presence]). Each character (column, if a matrix is species vs. chars) represents an orthogroup or homogroup (as defined previously) compared along with all the species. 

_Total Posterior Consensus Tree (TPCTree)_ - a majority rule consensus tree of all posterior trees from all converged chains of different Bayesian analyses. Two different TPCTrees were estimated: 1) based on an equal number of taxa independent from the methodology of parameters (TPCTree-all) and 2) based on homogroups or orthogroups methodology (TPCTree-partial). 

_Granulation_ - defined by the inflation parameter (I) in the MCL algorithm. It affects the cluster size, i.e., it defines the number of the predicted clusters for homogroups and orthogroups. The size of this parameter creates a scale, where small I values indicate fine-grained clustering, and large values a very coarse grained clustering. Increasing the I value leads to further splitting of the largest clusters, therefore smaller clusters.

_Singleton_ - gene family which is coded as present in only a single species.

_Naming convention in this work_ - The initial dataset was Opisthokonta (Opi) and contained data from genomes of 47 species. It was further divided into two subsets: a dataset with only Acoelomorpha (Aco, 44 species) and a dataset with *Xenoturbella bocki* alone (Xen, 41 species). Also, two additional datasets were created for the main Opi dataset and subsets (Aco and Xen), in which Fungi were excluded as outgroups Holozoa (Hol); and Choanozoa (Cho) where only species of the Choanoflagellates were included as outgroups. These are indicated with the three letters abbreviation of the outgroup sampling prefix and the suffix “dis” to distinguish from the next described dataset. Further, the subsets also excluded certain long-branched taxa in the ingroup and identified by the two letters suffix “ne” in the name of the dataset. The methodology type used for taxon reduction is indicated in the naming convention by “Ab'', for ab initio and “P” for pruning (see Supp. Table 5). For more details see Supp. Figure in [Additional information](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Additional%20information/All_graph.p.pdf) and [Genome gene content datasets protocol](https://github.com/KseniaJuravel/triangulation-juravel-2021/blob/main/Additional%20information/Genome%20gene%20content%20datasets%20protocol.pdf).

### The data structure in the deposited folders: ###

All morphology-related files can be found in [Morphology/](https://github.com/KseniaJuravel/triangulation-juravel-2021/tree/main/Morphology)

Three hundred forty-seven directories of genome gene content data (~3 T, compressed 645 GB - too large to be stored here) can be provided upon request.


### Who do I talk to? ###

* Repo owner or admin
