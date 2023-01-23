################################################################################
#
# R-script: Checking convergence
#
#
# authors: Sebastian Hoehna
#
################################################################################

library(convenience)

N_REPS = 4

# Get arguments
args = commandArgs(trailingOnly=TRUE)

DATASET = args[1]


OUTPUT_DIR = "output"
FIGS_DIR = "figures"


## Create figures directory
dir.create(FIGS_DIR, showWarnings=FALSE)


check_conv <- checkConvergence( list_files = c(paste0(OUTPUT_DIR, "/", DATASET,"_run_",1:N_REPS,".log"), paste0(OUTPUT_DIR, "/", DATASET,"_run_",1:N_REPS,".trees") ), control=makeControl(burnin = 0.25) )


saveRDS(check_conv, paste0(OUTPUT_DIR, "/", DATASET,"_conv.rds"))
#check_conv <- readRDS(paste0(OUTPUT_DIR, "/", DATASET,"_conv.rds"))

pdf( paste0(FIGS_DIR,"/convergence_",DATASET,".pdf"), height=8, width=8 )
    par(mfrow=c(2,2))

    plotEssContinuous(check_conv)
    plotKS(check_conv)
    plotEssSplits(check_conv)
    plotDiffSplits(check_conv)
dev.off()
