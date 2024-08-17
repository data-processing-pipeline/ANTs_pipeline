%cd /proj/htzhu/ukb/image/raw;module load matlab;matlab -nojvm
%
PATTERN={'3*.zip'};         % to change this pattern
%PATTERN={'22*.zip','601*.zip','602*.zip'};         % to change this pattern
Home00='/overflow/htzhu/UKB_T1_phase6/'; 
out00='/work/users/s/u/sunzehui/ANTS_UKBPhase6/';% change to your own directory
Home=sprintf('%s/data/',Home00);  % change to your own data source; 
cd(Home)
out=sprintf('%s/T1/',out00); 
system(sprintf('mkdir %s',out));
for ii=1:length(PATTERN)
	SUBtemp=dir(sprintf('%s/%s',Home,PATTERN{ii}));
	SUBtemp={SUBtemp.name}';
	if ii==1
		SUB=SUBtemp;
	else
		SUB=[SUB;SUBtemp];
	end
		
end
subj=cellfun(@(x)strsplit(x,'_'),SUB,'UniformOutput',0);
subj=cellfun(@(x)x{1},subj,'UniformOutput',0);
l=length(SUB);
Miss={};
for i=1:l %5442160
	%for i=8366:l
	outtemp=fullfile(out,subj{i});
	if exist(sprintf('%s/T1.nii.gz',outtemp))
		disp(subj{i})
		continue;
	end
	system(sprintf('unzip %s/%s -d %s/',Home,SUB{i},outtemp));
	if exist(sprintf('%s/T1/T1.nii.gz',outtemp))
		system(sprintf('cp %s/T1/T1.nii.gz %s/',outtemp,outtemp));
		else
		Miss=[Miss,subj{i}]
	end
	rmdir(sprintf('%s/T1',outtemp),'s')
end
