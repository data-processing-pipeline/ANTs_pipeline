%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%  Process MRI data using ANTs on MD Anderson Sever dqshtc  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% May 31, 2016 @ by CH

clear all;


%ANTsDir = '/PATH/';                % directory containing the data folder, template folder, script files.  you need to change the directory accordingly
%DataDir = '/PATH/T1_raw';   % directory containing the image sujects.  you need to change the directory accordingly


  
%ANTsDir = '/scratch/tli3/HCP/';               
%DataDir = '/scratch/tli3/HCP/T1_raw';  


DataDir = '/work/users/s/u/sunzehui/ANTS_UKBPhase6/T1/';
ANTsDir = '/work/users/s/u/sunzehui/ANTS_UKBPhase6/';                



subNames = dir(DataDir);        
subNames = {subNames.name}';
subNames = subNames(3:end); 

nn = size(subNames,1);

codeDir=fullfile(ANTsDir,'code');
mkdir(codeDir);
delete('code/*.*');

fid0 = fopen(sprintf('%s/ANTs_batAll.sh',codeDir),'w');
fprintf(fid0,'#!/bin/bash\n');

ANTS_Template_DIR=sprintf('%s/Template_30',ANTsDir);

donesubid='';
if exist('csv')==7
    donesubj=dir('csv');
    donesubj={donesubj.name};
    donesubj=donesubj(3:end);
    donesubid=cellfun(@(x)strsplit(x,'.csv'),donesubj,'UniformOutput',0);
    donesubid=cellfun(@(x)x{1},donesubid,'UniformOutput',0);
end
disp(donesubid)

for ii=1:nn
    if sum(strcmp(subNames{ii},donesubid))~=0
        continue;
     end
    batNames = sprintf('%s/ANTS_bat%i.pbs',codeDir,ii);
    fid = fopen(batNames,'w'); 
	fprintf(fid,'#!/bin/bash\n');
    fprintf(fid,'#SBATCH --ntasks=3\n');
    fprintf(fid,'#SBATCH --time=23:59:59\n');
    fprintf(fid,'#SBATCH --mem=24000\n');
    fprintf(fid,'#SBATCH --wrap=ANTs_%i\n',ii);
    fprintf(fid,'export ANTSPATH=/nas/longleaf/apps/ants/2.3.1/src/build/bin/ \n');
    fprintf(fid,'export ANTSPATH1=%s/Scripts/ \n',ANTsDir);
    fprintf(fid,'export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=3 \n');
	fprintf(fid,'gzip %s/%s/T1.nii \n',DataDir,subNames{ii});
	fprintf(fid,'mv %s/%s/T1.nii.gz %s/%s/T1_0.nii.gz \n',DataDir,subNames{ii},DataDir,subNames{ii});
	fprintf(fid,'${ANTSPATH}/ResampleImageBySpacing 3 %s/%s/T1_0.nii.gz %s/%s/T1.nii.gz 1 1 1 0 0 1\n',DataDir,subNames{ii},DataDir,subNames{ii});
    fprintf(fid,'bash ${ANTSPATH1}antsCorticalThickness.sh -d 3 -n 3 -w 0.25 \\\n');  
    fprintf(fid,'-a %s/%s/T1.nii.gz \\\n',DataDir,subNames{ii});
    fprintf(fid,'-o %s/%s/Output/ants \\\n',DataDir,subNames{ii});
    fprintf(fid,'-e %s/T_template0.nii.gz \\\n',ANTS_Template_DIR);
    fprintf(fid,'-t %s/T_template0_BrainCerebellum.nii.gz \\\n',ANTS_Template_DIR);
    fprintf(fid,'-m %s/T_template0_BrainCerebellumProbabilityMask.nii.gz \\\n',ANTS_Template_DIR);
    fprintf(fid,'-f %s/T_template0_BrainCerebellumExtractionMask.nii.gz \\\n',ANTS_Template_DIR);
    fprintf(fid,'-p %s/priors%%d.nii.gz \n',ANTS_Template_DIR);
    fclose(fid);
    fprintf(fid0,'sbatch ./ANTS_bat%i.pbs\n',ii);
end

fclose(fid0);

clear all;
