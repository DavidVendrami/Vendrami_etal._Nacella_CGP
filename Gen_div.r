source("SAMBAR_v1.00.txt")
getpackages()
importdata(inputprefix="Nacella_DP5_All", sumstatsfile=FALSE , depthfile=FALSE,geofile=NULL, nchroms=NULL,
colourvector=c('blue','darkgreen','darkred','orange','darkorchid4','#654321','deepskyblue','greenyellow','indianred1','#009595','grey20','grey50','grey80','black')) # 14 random colors. You are required to load 1 color per pop and
# the default reaches up to 13.

########################################################################
# Your data are stored in the objects 'mygenlight', 'snps' and 'inds'. #
########################################################################

filterdata(indmiss=0.99,snpmiss=0.999,chromosomes=FALSE,min_mac=2,dohefilter=TRUE,min_spacing=1,nchroms=NULL,TsTvfilter=NULL)
# The previous command does not filter any data, but it is necessary to run anyway, as it calculaets a bunch of stats that are used in later functions.

# To get genetic diversity measures, you need to provide 'nrsite', which is the total length of the sequences from which we called SNPs (both mono- and poly- morphic positions).
# Here we are with the exact number. So, we considered only catalog loci that were found in at least 80% of samples.
# This is because of the NS distribution. If you look at it you can see the bump of, conservatively speaking, good loci.
# 80% is the threshold. Their total length is: 71002913bp.

calcdiversity(nrsites=71002913)
boxplot(inds$genomepi~inds$pop)
boxplot(inds$genomehe~inds$pop)










