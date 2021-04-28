library(LEA)
# Use .ped plink files as input
ped2geno(input.file=choose.files()) #Macro
ped2geno(input.file=choose.files()) #Meso99
ped2geno(input.file=choose.files()) #Meso20
obj.snmf.M = snmf(input.file=choose.files(), K = c(1,2,3,4,5), project = "new",repetitions=5,CPU=1,entropy=TRUE,ploidy=2)
obj.snmf.m99 = snmf(input.file=choose.files(), K = c(1,2,3,4,5,6), project = "new",repetitions=5,CPU=1,entropy=TRUE,ploidy=2)
obj.snmf.m20 = snmf(input.file=choose.files(), K = c(1,2,3,4,5,6), project = "new",repetitions=5,CPU=1,entropy=TRUE,ploidy=2)

# Load project:
# obj.snmf.M = load.snmfProject("C:/Users/localadmin/Desktop/Post-Doc/Antarctic_gastropodes/Nacella/RADseq/Very_Final_Files/DP5/Data/Macro/Nacella_DP5_Macro.snmfProject")
# obj.snmf.m99 = load.snmfProject("C:/Users/localadmin/Desktop/Post-Doc/Antarctic_gastropodes/Nacella/RADseq/Very_Final_Files/DP5/Data/Micro/1999/Nacella_DP5_Meso99.snmfProject")
# obj.snmf.m20 = load.snmfProject("C:/Users/localadmin/Desktop/Post-Doc/Antarctic_gastropodes/Nacella/RADseq/Very_Final_Files/DP5/Data/Micro/2015/Nacella_DP5_Meso20.snmfProject")
# obj.snmf.T = load.snmfProject("C:/Users/localadmin/Desktop/Post-Doc/Antarctic_gastropodes/Nacella/RADseq/Very_Final_Files/DP5/Data/Micro/Temporal/Nacella_DP5_Temporal.snmfProject")
# obj.snmf.All = load.snmfProject("C:/Users/localadmin/Desktop/Post-Doc/Antarctic_gastropodes/Nacella/RADseq/Very_Final_Files/DP5/Data/All_data/Nacella_DP5_All.snmfProject")
# obj.snmf.All99     All_data/Nacella_DP5_All1999.snmfProject")

# Plot sNMF
# Macro
bestM3 = which.min(cross.entropy(obj.snmf.M, K = 3))
qmatrix = Q(obj.snmf.M, K = 3,run=bestM3)
bla<-t(qmatrix)
blaM<-bla
blaM[,1:10]<-bla[,40:49]
blaM[,11:20]<-bla[,20:29]
blaM[,21:30]<-bla[,1:10]
blaM[,31:39]<-bla[,11:19]
blaM[,40:49]<-bla[,30:39]
tiff("sNMF_Macro_K3.tiff",width=13, height=4.5, units= 'in', res=600, pointsize=1/600)
barplot(blaM, col = c("#984ea3","#ff7f00","#377eb8"), border = NA, space = 0,xlab = "Populations", ylab = "Admixture coefficients")
abline(v=c(0,10,20,30,39,49))
segments(0,0,49,0)
segments(0,0.998,49,0.998)
mtext("RG",side=1,line=0.3,at=44)
mtext("GA",side=1,line=0.3,at=34.5)
mtext("DO",side=1,line=0.3,at=25)
mtext("SN",side=1,line=0.3,at=15)
mtext("SI",side=1,line=0.3,at=5)
dev.off()

# Meso99
# Follow same procedure as above using obj.snmf.m99 and K=2

# Meso20
# Follow same procedure as above using obj.snmf.m20 and K=1




