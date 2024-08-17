cd /pine/scr/t/e/tengfei/UKB_40k_ANTs/csv_Cort;module load r/3.6.0;R
Vol0=read.csv('../vol.csv')
rownames(Vol0)=Vol0[,1];Vol0=Vol0[,-1]
l=dim(Vol0)[1]
temp=read.table(paste0(rownames(Vol0)[1],'_ROI.csv'),sep=',',head=T)
NAME=as.character(temp[,1])
Vol=cbind(Vol0,matrix(NA,l,length(NAME)))
colnames(Vol)=c(colnames(Vol0),as.character(temp$Label))
for(i in 1:l)
{
print(l-i)
temp=paste0(rownames(Vol0)[i],'_ROI.csv')
if(file.exists(temp)){
Vol[i,as.character(read.table(temp,sep=',',head=T)$Label)]=read.table(temp,sep=',',head=T)$VolumeInVoxels}
}
write.csv(Vol,file='../Vol_ROI.csv',row.names=T,quote=F)