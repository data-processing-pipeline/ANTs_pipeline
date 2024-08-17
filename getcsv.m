
clear all;
Finalmove=1; %if you have completed both step 1 and step 2, set this to 1; if you only finish step 1, set this to 0.


ANTsDir = '/work/users/s/u/sunzehui/ANTS_UKBPhase6/';  %%%%%%%%%%%%%%%%%%%%               
DataDir = '/work/users/s/u/sunzehui/ANTS_UKBPhase6/T1/';               


subNames = dir(DataDir);        % 'FS_TestData': name of directory containing the %imaging data files.  you need to change the directory accordingly
subNames = {subNames.name}';
subNames = subNames(3:end); % first two are sup-directory and current one

nn = size(subNames,1);

outdir=fullfile(ANTsDir,'csv');
outdir1=fullfile(ANTsDir,'QC');
outdir2=fullfile(ANTsDir,'antsBrainNormalizedToTemplate');
outdir3=fullfile(ANTsDir,'antsSubjectToTemplateLogJacobian');
outdir4=fullfile(ANTsDir,'antsSubjectToTemplate1Warp');
outdir5=fullfile(ANTsDir,'antsTemplateToSubject0Warp');
outdir6=fullfile(ANTsDir,'antsCorticalThickness');
outdir7=fullfile(ANTsDir,'antsCorticalThicknessNormalizedToTemplate');
outdir8=fullfile(ANTsDir,'antsExtractedBrain0N4');
outdir9=fullfile(ANTsDir,'Labels');
outdir10=fullfile(ANTsDir,'antsBrainSegmentation');





if ~exist(outdir)
  mkdir(outdir);
end
if ~exist(outdir1)
  mkdir(outdir1);
end
if ~exist(outdir2)
  mkdir(outdir2);
end
if ~exist(outdir3)
  mkdir(outdir3);
end
if ~exist(outdir4)
  mkdir(outdir4);
end
if ~exist(outdir5)
  mkdir(outdir5);
end
if ~exist(outdir6)
  mkdir(outdir6);
end
if ~exist(outdir7)
  mkdir(outdir7);
end
if ~exist(outdir8)
  mkdir(outdir8);
end
if ~exist(outdir9)
  mkdir(outdir9);
end
if ~exist(outdir10)
  mkdir(outdir10);
end

outdir11=fullfile(outdir1,'corticalthickness')
outdir12=fullfile(outdir1,'brainsegmentation')
mkdir(outdir11);
mkdir(outdir12);
donesubj=dir('csv');
donesubj={donesubj.name};
donesubj=donesubj(3:end);
donesubid=cellfun(@(x)strsplit(x,'.csv'),donesubj,'UniformOutput',0);
donesubid=cellfun(@(x)x{1},donesubid,'UniformOutput',0);


for ii=1:nn%8657
 if mod(ii,100)==0
 disp(nn-ii)
 end
 % if sum(strcmp(subNames{ii},donesubid))~=0
        % continue;
 % end
 filename=subNames{ii};
 if Finalmove==0
	 origpos=fullfile(DataDir,filename,'Output','antsbrainvols.csv');
	 destpos=fullfile(outdir,strcat(filename,'.csv'));
	 if exist(origpos)
	   copyfile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsBrainSegmentationTiledMosaic.png');
	 destpos=fullfile(outdir12,strcat(filename,'.png'));
	 if exist(origpos)
	   copyfile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsCorticalThicknessTiledMosaic.png');
	 destpos=fullfile(outdir11,strcat(filename,'.png'));
	 if exist(origpos)
	  copyfile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
 end
 if Finalmove==1
	 origpos=fullfile(DataDir,filename,'Output','antsBrainNormalizedToTemplate.nii.gz');
	 destpos=fullfile(outdir2,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	  movefile(origpos,destpos);
	 else
	  disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsSubjectToTemplateLogJacobian.nii.gz');
	 destpos=fullfile(outdir3,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsSubjectToTemplate1Warp.nii.gz');
	 destpos=fullfile(outdir4,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsTemplateToSubject0Warp.nii.gz');
	 destpos=fullfile(outdir5,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsCorticalThickness.nii.gz');
	 destpos=fullfile(outdir6,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsCorticalThicknessNormalizedToTemplate.nii.gz');
	 destpos=fullfile(outdir7,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsExtractedBrain0N4.nii.gz');
	 destpos=fullfile(outdir8,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'labeloutput',strcat(filename,'_Labels.nii.gz'));
	 destpos=fullfile(outdir9,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
	 origpos=fullfile(DataDir,filename,'Output','antsBrainSegmentation.nii.gz');
	 destpos=fullfile(outdir10,strcat(filename,'.nii.gz'));
	 if exist(origpos)
	   movefile(origpos,destpos);
	 else
	   disp(DataDir);disp(destpos);
	 end
 end
end
