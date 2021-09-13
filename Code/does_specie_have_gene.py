#By Nadège Guiglielmoni
#======================================================================#
#							HOW TO USE
#======================================================================#

# python -i pathtoinputfile	-o	pathtooutputfile

#======================================================================#
#							DESCRIPTION
#======================================================================#
# The goal of this tool is to take a file where each line corresponds to
# a gene; for each gene, all its homologous genes in various species are
# indicates in the following manner :
# spec1|homolog1genA spec2|homolog1genA spec2|homolog2genA ...
# The output has species names as colomns and genes as rows
# For each combination of species and genes, if an homologous gene has 
# been found for this specie, the value 1, and 0 otherwise
# The output looks like this :
# #	spec1	spec2	spec3	spec4	spec5	spec6	spec7	spec8	...
# gene1	0	1	0	0	0	1	1	0
# gene2	1	1	0	1	0	0	0	0

#======================================================================#
#							ARGUMENTS
#======================================================================#

import argparse
import sys

#======================================================================#
#							ARGUMENTS
#======================================================================#

def parse_args():
	""" 
	Gets the arguments from the command line.
	"""
	
	parser = argparse.ArgumentParser()
	parser.add_argument('-i', '--infile', required=True,
				help="""input : one line per gene, and in each line spec|homologous genes, all of them separated by a space""")
	parser.add_argument('-o', '--outfile', required=True, 
				help="""output""")
	return parser.parse_args()

#======================================================================#
#							IN/OUT
#======================================================================#

#----------------------------------------------------------------------#
#				Write output
#----------------------------------------------------------------------#
# WRITE_BOOL_GENES()
# input :
#	bool_gene : dictionnary where the keys are the genes and the values 
#				are a list, in the same order as the spec_list
#	outname : path to output file
def write_bool_genes(bool_gene, spec_list, outname) :
	"""
	Write the table with 0/1 for each combination of genes and species
	"""
	
	outfile = open(outname, "w")
	
	#------------- Write first line with species names ----------------#
	outfile.write("#")
	
	for spec in spec_list :
		outfile.write("\t{0}".format(spec))
	
	#------------- Write the booleans ---------------------------------#
	outfile.write("\n")
	for gene in bool_gene.keys() :
		outfile.write("gene{0}".format(gene))
		
		for spec_bool in bool_gene[gene] :
			outfile.write("\t{0}".format(spec_bool))
		outfile.write("\n")
		
	outfile.close()

#======================================================================#
#							FUNCTIONS
#======================================================================#

#----------------------------------------------------------------------#
#				Get list of species
#----------------------------------------------------------------------#

# GET_LIST_SPECIES()
# takes a list of species|homologous_gene and extract all the  species 
# in the list
# input :
# 	inlist : list of spec|homogene obtained from the input file
# output :
# 	spec_list : list of all the unique species found in the list 
def get_list_species(inlist) :
	spec_list = []
	
	for i in range(0, len(inlist)) : 
		
		#separate all the spec|homologgene from each other
		line = inlist[i].strip().split()
		
		for homolog in line : 
			
			#split the specie name from the homologous gene name
			spec_name = homolog.split("|")
			
			#check that the specie name and the homologous gene name 
			#have been separated properly; otherwise throws an error
			if len(spec_name) < 2 :
				print("Wrong format in the line {0} : {1}".format(i+1, homolog))
				sys.exit()
				
			#add the specie name to spec_list if it is not in already
			else :
				spec_name = spec_name[0]
				if spec_name not in spec_list :
					spec_list.append(spec_name)
					
	return sorted(spec_list)

#----------------------------------------------------------------------#
#				Test for an homolog of the gene for each specie
#----------------------------------------------------------------------#

#TEST_SPECIE_FOR_GENE()
# takes a list of species|homologous_gene indicates for each gene 
# whether the specie has an homolog for this gene (1) or not (0)
# input :
# 	inlist : list of spec|homogene obtained from the input file
#	spec_list : list of all the unique species found in the list 
# output : 
#	bool_gene : dictionnary where the keys are the genes and the values 
#				are a list, in the same order as the spec_list
def test_specie_for_gene(inlist, spec_list) :
	bool_gene = {}
	
	#go through all the genes and test whether each specie has this gene
	#or not
	for i in range(0, len(inlist)) :
		
		#create a list of 0 which is the length of list of species
		bool_gene[(i+1)] = [0]*len(spec_list)

		line = inlist[i].strip().split()
		
		#for each combination of spec|homologousgene
		for homolog in line : 
			
			#split over | to get the first field aka the species
			spec_name = homolog.split("|")[0]
			
			#put 1 to the specie field for this gene
			bool_gene[(i+1)][spec_list.index(spec_name)] = 1
	
	return bool_gene
	
#======================================================================#
#							MAIN
#======================================================================#

def main():

	#--------------------------- Get arguments ------------------------#
	args = parse_args()
	infile = args.infile
	outfile	= args.outfile 

	print('\n' + '-' * 40 + '\nBeginning of program\n')
	
	#--------------------------- Open input ---------------------------#
	
	f = open(infile, "r")
	
	my_inlist = f.readlines()
	
	f.close()
	
	#--------------------------- Get species --------------------------#
	
	print('\n' + '-' * 40 + '\nGetting list of species\n')
	
	my_speclist = get_list_species(my_inlist)
	
	print("\nThere is {0} species in the input file.\n".format(len(my_speclist)))
	
	#--------------------------- Compute booleans ---------------------#
	
	print('\n' + '-' * 40 + '\nComputing genes and species\n')
	
	my_boolgene = test_specie_for_gene(my_inlist, my_speclist)

	#--------------------------- Write output -------------------------#
	
	print('\n' + '-' * 40 + '\nWriting output\n')
	
	write_bool_genes(my_boolgene, my_speclist, outfile)

	return 0


if __name__ == '__main__':
	main()
