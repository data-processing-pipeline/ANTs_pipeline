%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%  Process MRI data using ANTs on MD Anderson Sever dqshtc  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% May 31, 2019 @ by TL

clear all;



%ANTsDir = '/PATH/';                % directory containing the data folder and other files.  you need to change the directory accordingly
%DataDir = '/PATH/T1_raw';                % directory containing the imaging subject folders.  you need to change the directory accordingly

%ANTsDir = '/pine/scr/t/e/tengfei/UKB_40k_ANTs/';                
ANTsDir = '/work/users/s/u/sunzehui/ANTS_UKBPhase6/';                
%DataDir = '/pine/scr/t/e/tengfei/UKB_40k_ANTs/T1/';               
DataDir = '/work/users/s/u/sunzehui/ANTS_UKBPhase6/T1/';               


subNames = dir(DataDir);        % 'FS_TestData': name of directory containing the imaging data files.  you need to change the directory accordingly
subNames = {subNames.name}';
subNames = subNames(3:end); % first two are sup-directory and current one

nn = size(subNames,1);

codeDir=fullfile(ANTsDir,'code');
mkdir(codeDir);
delete('code/*.*');

fid0 = fopen(sprintf('%s/ANTs_batAll.sh',codeDir),'w');
fprintf(fid0,'#!/bin/bash\n');

ANTS_Template_DIR=sprintf('%s/Template_30',ANTsDir);

N=3;
K=ceil(nn/N);

for kk=1:K
    batNames = sprintf('%s/ANTS_bat1_%i.pbs',codeDir,kk);
    fid = fopen(batNames,'w'); 
    fprintf(fid,'#!/bin/bash\n');
    fprintf(fid,'#SBATCH --ntasks=3\n');
    fprintf(fid,'#SBATCH --time=23:59:59\n');
    fprintf(fid,'#SBATCH --mem=12000\n');
    fprintf(fid,'#SBATCH --wrap=ANTs_%i\n',kk);
    fprintf(fid,'export ANTSPATH=/nas/longleaf/apps/ants/2.3.1/src/build/bin/ \n');
    fprintf(fid,'export ANTSPATH1=%s/Scripts/ \n',ANTsDir);
    fprintf(fid,'export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=3 \n');
    fprintf(fid,'export inputPath=%s\n',ANTsDir);
    flag=0;
  for ii=min(kk*N,nn)+((kk-1)*N+1)-(((kk-1)*N+1):min(kk*N,nn))
    output0=sprintf('%s/%s/labeloutput',DataDir,subNames{ii});
    if ~exist(output0)
       mkdir(output0);
    end
    if length(dir(fullfile(output0,'*_Labels.nii.gz')))>0
       continue;
    end
    flag=1;
    fprintf(fid,'bash ${ANTSPATH1}/antsJointLabelFusion.sh -d 3 -c 2 -j 3 -x or \\\n');  
    %fprintf(fid,'bash ${ANTSPATH1}/antsJointLabelFusion.sh -d 3 -c 0 -x or \\\n');  
    fprintf(fid,'-o %s/%s/labeloutput/%s_ \\\n',DataDir,subNames{ii},subNames{ii});
    fprintf(fid,'-t %s/%s/Output/antsExtractedBrain0N4.nii.gz \\\n',DataDir,subNames{ii});
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-1_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-1_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-2_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-2_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-3_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-3_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-4_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-4_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-5_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-5_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-6_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-6_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-7_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-7_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-8_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-8_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-9_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-9_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-10_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-10_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-11_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-11_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-12_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-12_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-13_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-13_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-14_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-14_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-15_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-15_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-16_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-16_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-17_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-17_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-18_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-18_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-19_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-19_DKT31_CMA_labels.nii.gz \\\n');
    fprintf(fid,'-g ${inputPath}/oasis_label/brain/OASIS-TRT-20-20_brain.nii.gz -l ${inputPath}/oasis_label/label/OASIS-TRT-20-20_DKT31_CMA_labels.nii.gz \n');
    fprintf(fid,'rm %s/%s/labeloutput/%s_Intensity.nii.gz \n',DataDir,subNames{ii},subNames{ii});

  end
    fclose(fid);
    if flag
       fprintf(fid0,'sbatch ./ANTS_bat1_%i.pbs\n',kk);
    end
end

fclose(fid0);

clear all;
