%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%  Process MRI data using ANTs on MD Anderson Sever dqshtc  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% May 31, 2016 @ by CH

clear all;
%ANTsDir = '/pine/scr/t/e/tengfei/UKB_40k_ANTs/';                
ANTsDir = '/work/users/s/u/sunzehui/ANTS_UKBPhase6/';                

codeDir=fullfile(ANTsDir,'code');
mkdir(codeDir);
delete('code/*.*');

fid0 = fopen(sprintf('%s/All.sh',codeDir),'w');
fprintf(fid0,'#!/bin/bash\n');

mkdir('csv_Cort')
%process subject ids 600*,601*,602*
extent1=3:3;
extent2=0:9;
extent3=0:9;
for i1=extent1
for i2=extent2
for i3=extent3
    batNames = sprintf('%s/bat_%i_%i_%i.pbs',codeDir,i1,i2,i3);
    fid = fopen(batNames,'w'); 
    fprintf(fid,'#!/bin/bash\n');
    fprintf(fid,'#SBATCH --ntasks=1\n');
    fprintf(fid,'#SBATCH --time=3:59:59\n');
    fprintf(fid,'#SBATCH --mem=4000\n');
    fprintf(fid,'#SBATCH --wrap=Extract_%i_%i_%i\n',i1,i2,i3);
	fprintf(fid,'export FSLDIR=/nas/longleaf/apps/fsl/5.0.10/fsl/\n');
	fprintf(fid,'source ${FSLDIR}/etc/fslconf/fsl.sh\n');
	fprintf(fid,'export ANTSPATH=/nas/longleaf/apps/ants/2.3.1/src/build/bin/ \n');
	fprintf(fid,'export PATH=${FSLDIR}/bin:${ANTSPATH}:${PATH}\n');
	fprintf(fid,'module load python/2.7.12\n');
	fprintf(fid,'cd %s\n',ANTsDir);
	fprintf(fid,'SUB=(`ls antsCorticalThickness/%i%i%i*`)\n',i1,i2,i3);
    fprintf(fid,'SUB1=(`ls csv_Cort/%i%i%i*ROI.csv|xargs -n 1 basename| xargs -d_ -i  echo {}`)\n',i1,i2,i3);
    fprintf(fid,'for i in ${SUB[@]}\n');
	fprintf(fid,'do\n');
	fprintf(fid,'temp=(`echo $i | xargs -d/ -i  echo {}`)\n');
	fprintf(fid,'temp1=(`echo ${temp[1]} | xargs -d. -i  echo {}`)\n');
	fprintf(fid,'temp2=(`echo ${temp1[0]} | xargs -d_ -i  echo {}`)\n');
	fprintf(fid,'temp3=(`echo ${SUB1[@]}|grep ${temp2[0]}`)\n');%%%
	fprintf(fid,'temp4=${#temp3[@]}\n');%%%
	fprintf(fid,'if [ $temp4 -le 0 ]; then\n');%%%
	%fprintf(fid,'if ! echo ${SUB1[@]}|grep ${temp2[1]}; then\n');
	fprintf(fid,'echo $i\n');
	fprintf(fid,'python Surf.py ${i} Labels/${temp[1]} csv_Cort\n');
	fprintf(fid,'fi\n');
	fprintf(fid,'done\n');
    fclose(fid);
	
	fprintf(fid0,'sbatch ./bat_%i_%i_%i.pbs\n',i1,i2,i3);
end
end
end
fclose(fid0);
clear all;
