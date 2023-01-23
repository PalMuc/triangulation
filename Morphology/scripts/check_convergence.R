################################################################################
#
# R-script: Checking convergence
#
#
# authors: Sebastian Hoehna
#
################################################################################

library(convenience)

N_REPS = 2

# Get arguments
args = commandArgs(trailingOnly=TRUE)

TAXON_SET                = args[1]
CODING                   = args[2]
BRANCH_LENGTH_HYPERPRIOR = args[3]
SPLIT_BY_STATES          = args[4]
NUM_PROFILE_MIXTURES     = args[5]
NUM_ASRV_CATS_BINARY     = args[6]
NUM_ASRV_CATS_TRINARY    = args[7]
BINARY_CODING            = args[8]
TRINARY_CODING           = args[9]


OUTPUT_DIR = "output"
FIGS_DIR = "figures"


## Create figures directory
dir.create(FIGS_DIR, showWarnings=FALSE)

OUTPUT_FILENAME = paste0(TAXON_SET, "-", CODING, "_ASVR_bin_", NUM_ASRV_CATS_BINARY, "_ASVR_tri_", NUM_ASRV_CATS_TRINARY, "_mix_", NUM_PROFILE_MIXTURES, "_CODE_bin_", BINARY_CODING, "_CODE_tri_", TRINARY_CODING, ifelse( BRANCH_LENGTH_HYPERPRIOR, "_hyperprior", "_prior" ), ifelse( SPLIT_BY_STATES, "_partitioned", "_combined" ) )

check_conv <- checkConvergence( list_files = c(paste0(OUTPUT_DIR, "/", OUTPUT_FILENAME,"_run_",1:N_REPS,".log"), paste0(OUTPUT_DIR, "/", OUTPUT_FILENAME,"_run_",1:N_REPS,".trees") ), control=makeControl(burnin = 0.25) )


saveRDS(check_conv, paste0(OUTPUT_DIR, "/", OUTPUT_FILENAME,"_conv.rds"))
#check_conv <- readRDS(paste0(OUTPUT_DIR, "/", OUTPUT_FILENAME,"_conv.rds"))

pdf( paste0(FIGS_DIR,"/convergence_",OUTPUT_FILENAME,".pdf"), height=8, width=8 )
    par(mfrow=c(2,2))

    plotEssContinuous(check_conv)
    plotKS(check_conv)
    plotEssSplits(check_conv)
    plotDiffSplits(check_conv)
dev.off()
