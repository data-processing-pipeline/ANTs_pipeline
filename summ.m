function [M] = summ(fold)
names=dir(fold);
names={names.name};
names=names(3:end);
l=length(names);
M=[];
rowname={'ID','PearsonCorr','BVol','GVol','WVol','ThicknessSum'};
fid=fopen('vol.csv','w');
fprintf(fid,'%s,',rowname{1:(end-1)});
fprintf(fid,'%s\n',rowname{end});
name0=cellfun(@(x)x{1},cellfun(@(x)strsplit(x,'.csv'),names,'UniformOutput',0),'UniformOutput',0);
for i=1:l
    disp(i)
    M(i,:)=csvread(fullfile(fold,names{i}),1,0);
    fprintf(fid,'%s,%f,%d,%d,%d,%d\n',name0{i},M(i,1),M(i,2),M(i,3),M(i,4),M(i,5));
end
fclose(fid) %#ok<PRTCAL>
%summ(fold)