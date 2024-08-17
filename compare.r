cd /pine/scr/t/e/tengfei/UKB_40k_ANTs;module load r/3.6.0;R
data3=read.csv('../UKB_40k_ANTs/Vol_ROI.csv')
data2=read.csv('../UKB_40k_ANTs1/Vol_ROI.csv')#[,-37]
data3=data3[,colnames(data2)]
Cor0=rep(NA,103)
for(i in 3:103)
{
print(103-i)
indd=((!is.na(data2[,i]))&(!is.na(data3[,i])))
Cor0[i]=cor(data2[indd,i],data3[indd,i])
}
plot(data2[,82],data3[,82],xlab='ANTs-2.2.0',ylab='ANTs-2.3.1',pch=20,col='blue',cex.lab=1.3,cex.axis=1.3)
plot(c(data2[,23],data3[,23]),xlab='Subjects',ylab='left vessel volume',pch=20,col='blue',cex.lab=1.3,cex.axis=1.3)
plot(data2[,3],data3[,3],xlab='ANTs-2.2.0',ylab='ANTs-2.3.1',pch=20,col='blue',cex.lab=1.3,cex.axis=1.3)
plot(c(data2[,3],data3[,3]),xlab='Subjects',ylab='Whole brain volume',pch=20,col='blue',cex.lab=1.3,cex.axis=1.3)
#61,66