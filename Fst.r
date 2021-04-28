# It uses genlight objects, so you can load the raw plink files.
library(StAMPP)
library(adegenet)

macro<-read.PLINK(choose.files(),n.cores=1)
meso99<-read.PLINK(choose.files(),n.cores=1)
meso20<-read.PLINK(choose.files(),n.cores=1)
all_s<-read.PLINK(choose.files(),n.cores=1)

Mfst<-stamppFst(macro,nboots=10000)
m99fst<-stamppFst(meso99,nboots=10000)
m20fst<-stamppFst(meso20,nboots=10000)
All<-stamppFst(all_s,nboots=10000)

