'''
cd /pine/scr/h/t/htzhu/UNB_ants
module load fsl
module load ants/2.3.1
module load python/2.7.12
SUB=(`ls antsCorticalThickness/1*`)
for i in ${SUB[@]}
do
echo $i
temp=(`echo $i | xargs -d/ -i  echo {}`)
python Surf.py ${i} Labels/${temp[1]} csv_Cort
done
'''
import nibabel as nb
import numpy as np
import sys
import os
import pandas as pd
subject=sys.argv[1]
ROI=sys.argv[2]
out=sys.argv[3]#subject='antsCorticalThickness/1100097.nii.gz';out='csv_Cort';ROI='Labels/1100097.nii.gz'
pattern=str.split(str.split(subject,'/')[-1],'.nii.gz')[0]
mask0=str.split(subject,'.nii.gz')[0]+'_mask.nii.gz'
os.system('fslmaths '+subject+' -bin '+mask0)
#os.system('LabelGeometryMeasures 3 '+mask0+" '' "+out+'/'+pattern+'.csv')
os.system('ImageMath 3 '+out+'/'+pattern+'_1.csv '+' ROIStatistics label1.txt '+mask0+' '+subject)
os.system('fslstats '+subject+' -M >> '+out+'/'+pattern+'_2.csv ')
os.system('fslmaths '+subject+' -bin -mul '+ROI+' '+out+'/'+pattern+'.nii.gz')
os.system('rm '+mask0)
os.system('LabelGeometryMeasures 3 '+ROI+' '+subject+' '+out+'/'+pattern+'_ROISurf.csv')
os.system('ImageMath 3 '+out+'/'+pattern+'_ROICort.csv '+' ROIStatistics label.txt '+' '+out+'/'+pattern+'.nii.gz '+subject)
os.system('rm '+out+'/'+pattern+'.nii.gz ')
df = pd.read_csv(out+'/'+pattern+'_ROISurf.csv')
df1 = pd.read_csv(out+'/'+pattern+'_ROICort.csv')
ind0=np.asarray(df['Label'])
df2 = df1.loc[ind0-1,['ROINumber','Mean','Mass','ClusterSize']]
df2=df2.rename(columns={'ROINumber':'Label'});
df3=df.merge(df2,left_on='Label',right_on='Label')
export_csv = df3.to_csv (out+'/'+pattern+'_ROI.csv', index = None, header=True) 
os.system('rm '+out+'/'+pattern+'_ROISurf.csv')
os.system('rm '+out+'/'+pattern+'_ROICort.csv')

