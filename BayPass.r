####################################
##### BayPass analysis #############
####################################

### Create input files

# Transfer relevant .ped .map files (micro 1999 + micro 2015) to server to create .frq.strat files (divide pops by Sweepstake vs non sweepstake)
# Create .clust files
cut -d ' ' -f1,2 Nacella_DP5_Temporal_noRG99.ped > micro99.clust
cut -d ' ' -f1,2 Nacella_DP5_Temporal.ped > micro15.clust

R
data<-read.table("micro99.clust",h=F)
data[,3]<-data[,1]
write.table(data,"micro99.clust",quote=F,col.names=F,row.names=F)

data<-read.table("micro15.clust",h=F)
data[,3]<-data[,1]
write.table(data,"micro15.clust",quote=F,col.names=F,row.names=F)

# Create .frq.clust files
plink --file Nacella_DP5_Temporal --freq --aec --within micro15.clust --out Nacella_DP5_Temporal
plink --file Nacella_DP5_Temporal_noRG99 --freq --aec --within micro99.clust --out Nacella_DP5_Temporal_noRG99

# Switch back to R
# Import .frq.strat file generated by plink
data<-read.table("Nacella_DP5_Temporal_noRG99.frq.strat",h=T)
# Create an empty matrix with rows=snps and cols=2*npops
mat<-matrix( ,nrow=rows,ncol=cols)
# Create a matrix with MAC and one with NCHROBS, and one with MAC2
inp<-matrix(data$MAC, nrow=rows,ncol=cols,byrow=T)
chr<-matrix(data$NCHROBS, nrow=rows,ncol=cols,byrow=T)
inp2<-chr-inp
# Create Baypass input
for (i in 1:cols){
mat[,i+(i-1)]<-inp[,i]
} 
for (i in 1:cols){
mat[,(i*2)]<-inp2[,i]
}
# write it out
write.table(mat,"YOUR_OUTPUT.geno",quote=F,col.names=F,row.names=F)
# Repeat for other input

### Back to bash and run BayPass
~/bin/baypass_2.1/sources/g_baypass -npop 2 -gfile YOUR_OUTPUT.geno -nthreads 8 -outprefix YOUR_OUTPUT_PREFIX &
~/bin/baypass_2.1/sources/g_baypass -npop 2 -gfile YOUR_OUTPUT.geno -nthreads 8 -outprefix YOUR_OUTPUT_PREFIX &

# Back to R; analyse BayPAss results as of manual
require(corrplot) ; require(ape)
source("baypass_utils.R")

omega=as.matrix(read.table("YOUR_OUTPUT_PREFIX_mat_omega.out"))
pop.names=c("sweep","nonSweep")
dimnames(omega)=list(pop.names,pop.names)
cor.mat=cov2cor(omega)
corrplot(cor.mat,method="color",mar=c(2,1,2,2)+0.1,
main=expression("Correlation map based on"~hat(Omega)))
bta14.tree=as.phylo(hclust(as.dist(1-cor.mat**2)))
plot(bta14.tree,type="p",
main=expression("Hier. clust. tree based on"~hat(Omega)~"("*d[ij]*"=1-"*rho[ij]*")"))
anacore.snp.res=read.table("YOUR_OUTPUT_PREFIX_summary_pi_xtx.out",h=T)
plot(anacore.snp.res$M_XtX) # effct sizes
plot(anacore.snp.res$log10(1/pval)) # p-values








