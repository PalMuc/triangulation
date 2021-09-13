#by Sebastian Hoehna

#trace.size()
#pp_Porifera
#pp_Ctenophora
#pp_Cnidaria
#pp_Xenacoelomorpha
#pp_Hemichordata
#pp_Echinodermata
#pp_Lophotrochozoa
#pp_Ecdysozoa
#pp_metazoans
#pp_metazoans_ingroup
#pp_Ctenophora_Sister
#pp_Porifera_Sister
#pp_Deuterostome
#pp_Nephrozoa
#pp_Xenambulacraria


library(ggplot2)
library(gridExtra)
library(egg)

compute.BF <- function( pp1, pp2, n.samples ) {

    # modify pp1 and pp2 so that we exclude the boundaries
    pp1 <- ifelse( pp1 == 1.0, pp1-(1/n.samples), ifelse( pp1 == 0, pp1+(1/n.samples), pp1 ) )
    pp2 <- ifelse( pp2 == 1.0, pp2-(1/n.samples), ifelse( pp2 == 0, pp2+(1/n.samples), pp2 ) )
    # brute force BF
    BF <- pp1 / pp2
    ln.bf <- log( BF )

    return (ln.bf)

}

compute.prior <- function( focal.clade.size, total.n.species ) {
    ln_total_prior <- 0
    if ( (total.n.species-focal.clade.size+1) > 2 ) {
        for (i in 3:(total.n.species-focal.clade.size+1) ) {
            ln_total_prior <- ln_total_prior - log(2*i-3)
        }
    }
    if ( focal.clade.size > 2 ) {
        for (i in 3:focal.clade.size ) {
            ln_total_prior <- ln_total_prior - log(2*i-3)
        }
    }
    return (ln_total_prior)
}



METHODS  = c( "Homogroups","Orthogroups")
I_VALUES = c( "1.5", "2", "2.5", "4", "6" )
E_VALUES = c( "1e-2", "1e-5", "1e-9", "1e-12")
N_RUNS   = 4
NUM_SPECIES_THIS_DATASET = 47

pp <- as.data.frame( list(method=c(),i_val=c(),e_val=c(),rep=c(),n_samples=c()) )

method                 = c()
i_val                  = c()
e_val                  = c()
rep                    = c()
n_samples              = c()
pp_Porifera            = c()
pp_Ctenophora          = c()
pp_Cnidaria            = c()
pp_Xenacoelomorpha     = c()
pp_Hemichordata        = c()
pp_Echinodermata       = c()
pp_Lophotrochozoa      = c()
pp_Ecdysozoa           = c()
pp_metazoans           = c()
pp_metazoans_ingroup   = c()
pp_Ctenophora_Sister   = c()
pp_Porifera_Sister     = c()
pp_Deuterostome        = c()
pp_Nephrozoa           = c()
pp_Xenambulacraria     = c()
bf_Porifera            = c()
bf_Xenacoelomorpha     = c()
bf_Deutorostome        = c()

for ( m in METHODS ) {

    for ( iv in I_VALUES ) {

        for ( ev in E_VALUES ) {

            for ( r in 1:N_RUNS ) {

                filename <- paste0("47sp_metazoan_hypothesis/",m,"_",ev,"_",iv,"_run_",r,".txt")

                if ( file.exists(filename) == FALSE ) cat(filename,"does not exist.\n")

                this.pp = read.csv(filename, header=FALSE)[,1]

                method                 = append(method,m)
                i_val                  = append(i_val,iv)
                e_val                  = append(e_val,ev)
                rep                    = append(rep,r)
                n_samples              = append(n_samples, this.pp[1])
                pp_Porifera            = append(pp_Porifera, this.pp[2])
                pp_Ctenophora          = append(pp_Ctenophora, this.pp[3])
                pp_Cnidaria            = append(pp_Cnidaria, this.pp[4])
                pp_Xenacoelomorpha     = append(pp_Xenacoelomorpha, this.pp[5])
                pp_Hemichordata        = append(pp_Hemichordata, this.pp[6])
                pp_Echinodermata       = append(pp_Echinodermata, this.pp[7])
                pp_Lophotrochozoa      = append(pp_Lophotrochozoa, this.pp[8])
                pp_Ecdysozoa           = append(pp_Ecdysozoa, this.pp[9])
                pp_metazoans           = append(pp_metazoans, this.pp[10])
                pp_metazoans_ingroup   = append(pp_metazoans_ingroup, this.pp[11])
                pp_Ctenophora_Sister   = append(pp_Ctenophora_Sister, this.pp[12])
                pp_Porifera_Sister     = append(pp_Porifera_Sister, this.pp[13])
                pp_Deuterostome        = append(pp_Deuterostome, this.pp[14])
                pp_Nephrozoa           = append(pp_Nephrozoa, this.pp[15])
                pp_Xenambulacraria     = append(pp_Xenambulacraria, this.pp[16])
                bf_Porifera            = append(bf_Porifera,compute.BF(this.pp[13],this.pp[12],this.pp[1])+compute.prior(33,NUM_SPECIES_THIS_DATASET)-compute.prior(35,NUM_SPECIES_THIS_DATASET))
                bf_Xenacoelomorpha     = append(bf_Xenacoelomorpha,compute.BF(this.pp[15],this.pp[16],this.pp[1])+compute.prior(10,NUM_SPECIES_THIS_DATASET)-compute.prior(22,NUM_SPECIES_THIS_DATASET))
                bf_Deutorostome        = append(bf_Deutorostome,compute.BF(this.pp[14],1-this.pp[14],this.pp[1])+compute.prior(11,NUM_SPECIES_THIS_DATASET)-compute.prior(11,NUM_SPECIES_THIS_DATASET))

            }

        }

    }

}

pp <- as.data.frame( list(method                 = method,
                          i_val                  = i_val,
                          e_val                  = e_val,
                          rep                    = as.factor(rep),
                          n_samples              = n_samples,
                          pp_Porifera            = pp_Porifera,
                          pp_Ctenophora          = pp_Ctenophora,
                          pp_Cnidaria            = pp_Cnidaria,
                          pp_Xenacoelomorpha     = pp_Xenacoelomorpha,
                          pp_Hemichordata        = pp_Hemichordata,
                          pp_Echinodermata       = pp_Echinodermata,
                          pp_Lophotrochozoa      = pp_Lophotrochozoa,
                          pp_Ecdysozoa           = pp_Ecdysozoa,
                          pp_metazoans           = pp_metazoans,
                          pp_metazoans_ingroup   = pp_metazoans_ingroup,
                          pp_Ctenophora_Sister   = pp_Ctenophora_Sister,
                          pp_Porifera_Sister     = pp_Porifera_Sister,
                          pp_Deuterostome        = pp_Deuterostome,
                          pp_Nephrozoa           = pp_Nephrozoa,
                          pp_Xenambulacraria     = pp_Xenambulacraria,
                          bf_Porifera            = bf_Porifera,
                          bf_Xenacoelomorpha     = bf_Xenacoelomorpha,
                          bf_Deutorostome        = bf_Deutorostome ) )


write.csv(pp, "Results.csv")

HYPOTHESIS = c("bf_Porifera", "bf_Xenacoelomorpha", "bf_Deutorostome")

for ( m in METHODS ) {

    for ( h in HYPOTHESIS ) {

        plot_list  <- list()
        plot_index <- 1

        for ( iv in I_VALUES ) {

            indices <- pp[["method"]] == m & pp[["i_val"]] == iv
            this.df <- pp[indices,]

            MAX_BF = ceiling( max( abs( pp[[h]] ) ) )

            p <- ggplot(this.df, aes_string(x="e_val", y=h, fill="rep")) +
                 ggtitle(paste0("I = ",iv)) +
                 ylim(-MAX_BF,MAX_BF) +
                 geom_bar(stat="identity", position=position_dodge()) +
                 scale_fill_brewer(type="seq", palette="Greens")

            if ( iv == I_VALUES[1] ) {
                p <- p + theme(legend.position="none",
                               panel.background = element_blank(),
                               panel.border = element_rect(colour = "black", fill=NA, size=1),
                               plot.title = element_text(hjust = 0.5))
            } else {
                p <- p + theme(legend.position="none",
                               panel.background = element_blank(),
                               panel.border = element_rect(colour = "black", fill=NA, size=1),
                               axis.ticks.y = element_blank(),
                               axis.text.y = element_blank(),
                               axis.title.y = element_blank(),
                               plot.title = element_text(hjust = 0.5))
            }
            p <- p +
                 geom_hline(yintercept=0,  linetype="solid", color = "black", size=0.25) +
                 geom_hline(yintercept=log(3.2),  linetype="dotted", color = "red", size=0.25) +
                 geom_hline(yintercept=-log(3.2), linetype="dotted", color = "red", size=0.25) +
                 geom_hline(yintercept=log(10),  linetype="dashed", color = "red", size=0.25) +
                 geom_hline(yintercept=-log(10), linetype="dashed", color = "red", size=0.25) +
                 geom_hline(yintercept=log(100),  linetype="solid", color = "red", size=0.25) +
                 geom_hline(yintercept=-log(100), linetype="solid", color = "red", size=0.25)

            plot_list[[plot_index]] <- p
            plot_index <- plot_index + 1


        }
        all.plots = ggarrange(plots=plot_list, nrow = 1)

        ggsave( paste0("BF_",m,"_",h,".pdf"), plot=all.plots, width=15, height=3 )

    }

}



cat("Finished!\n")
