################################################################################
#
# R-script: Plotting trees
#
#
# authors: Sebastian Hoehna
#
################################################################################

library(ggtree)
library(RevGadgets)

N_REPS = 4

# Get arguments
args = commandArgs(trailingOnly=TRUE)

DATASET = args[1]


OUTPUT_DIR = "output"
FIGS_DIR = "figures"


## Create figures directory
dir.create(FIGS_DIR, showWarnings=FALSE)

my_outgroup = "Saccharomyces_cerevisiae"



for (rep in 1:N_REPS) {

  tree  <- readTrees(paths = paste0(OUTPUT_DIR,"/",DATASET,"_full_names_run_",rep,".map.tre"))
  tree_rooted <- rerootPhylo(tree = tree, outgroup = my_outgroup)

  # create the plot of the rooted tree
  plot <- plotTree(tree = tree_rooted,
                   # label nodes the with posterior probabilities
                   node_labels = "posterior",
                   # offset the node labels from the nodes
                   node_labels_offset = 0.0005,
                   # make tree lines more narrow
                   line_width = 0.75,
                   tip_labels_italics = FALSE,
                   tip_labels_color = "black",
                   tip_labels_size = 0,
                   tip_labels_offset = 0) +
          geom_tiplab(align=TRUE, linetype='dashed', linesize=.3, size=2.5)

  ggsave(plot, file=paste0(FIGS_DIR,"/",DATASET,"_full_names_run_",rep,".map.pdf"))

}


tree  <- readTrees(paths = paste0(OUTPUT_DIR,"/",DATASET,"_full_names.map.tre"))
tree_rooted <- rerootPhylo(tree = tree, outgroup = my_outgroup)

# create the plot of the rooted tree
plot <- plotTree(tree = tree_rooted,
                 # label nodes the with posterior probabilities
                 node_labels = "posterior",
                 # offset the node labels from the nodes
                 node_labels_offset = 0.0005,
                 # make tree lines more narrow
                 line_width = 0.75,
                 tip_labels = TRUE,
                 tip_labels_italics = FALSE,
                 tip_labels_formatted = FALSE,
                 tip_labels_remove_underscore = TRUE,
                 tip_labels_color = "black",
                 tip_labels_size = 0,
                 tip_labels_offset = 0) +
        geom_tiplab(align=TRUE, linetype='dashed', linesize=.3, size=2.5)

ggsave(plot, file=paste0(FIGS_DIR,"/",DATASET,"_full_names.map.pdf"))
