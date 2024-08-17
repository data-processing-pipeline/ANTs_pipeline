%cd /proj/htzhu/ukb/image/raw;module load matlab;matlab -nojvm
%
Home00='/proj/htzhu/ukb/image/raw/'; 
out='/proj/tengfei/ukb/image_processed/ANTs/UKB_40k_ANTs/T1';% change to your own directory
%Home=sprintf('%s/T1/',Home00); 
Home=sprintf('%s/T1_40k/',Home00); 
cd(Home)
subj=dlmread('/proj/tengfei/ukb/image_processed/ANTs/UKB3_csv/undone.txt');
subj=mat2cell(num2str(subj),ones(length(subj),1));
SUB=cellfun(@(x)sprintf('%s_20252_2_0.zip',num2str(x)),subj,'UniformOutput',0)
l=length(SUB);
Miss={};
for i=1:l %5442160
	%for i=8366:l
	outtemp=fullfile(out,subj{i});
	if exist(sprintf('%s/T1.nii.gz',outtemp))
		disp(subj{i})
		continue;
	end
	system(sprintf('mkdir -p %s',outtemp))
	system(sprintf('unzip %s/%s -d %s/',Home,SUB{i},outtemp));
	if exist(sprintf('%s/T1/T1.nii.gz',outtemp))
		system(sprintf('cp %s/T1/T1.nii.gz %s/',outtemp,outtemp));
		else
		Miss=[Miss,subj{i}]
	end
	rmdir(sprintf('%s/T1',outtemp),'s')
end
