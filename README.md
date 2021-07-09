# Vendrami_etal._Nacella_CGP
Code availability for analysis of Nacella CGP

Within this repository there is the code used to perform the analyses of the Nacella CGP work from Vendrami et al. that is currently under review. 

Please do not hesitate to contact me at david.vendrami@edu.unife.it for clarifications that I will be very happy to provide promptly.

The file names should be self explanatory, but here a quick overview:
BayPass.r contains the code for running the scan for ourlier loci implemented in BayPass

DrifterRothera.m is a file provided by Michael Meredith. It reads the drifter data from the raw format and exports to matlab, at which point the manual editing and plotting can be done. I will re-direct you to Michael for any questions regarding this file.

Fst.r is the code to calculate Fst measures,

Gen_div.r is the code to calculate nucleotide diversity,

LD.r is the code to do this insane thing of calculating LD for all possible pairs of loci, plus generating summary statistics,

PCA.r is used to carry out PCAs,

Relatedness_and_Z0scores.txt describe how to get PI_HAT and Z scores using plink,

sNMF.r is a script to carry out a genetic structure analysis using sparse non-negative matrix factorization implemented in the R package LEA,

Workflow_bioinformatics.txt describes the entire workflow to go from the raw sequencing reads to clean and filtered plink files which are used as input for the majority of the analyses,

the four SLIM_simulation text files describe how to run the SLiM simulations using the .slim files present in the four SLiM folders as input.
