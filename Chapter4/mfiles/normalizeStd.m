function [class1_n,class2_n]=normalizeStd(class1,class2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [class1_n,class2_n]=normalizeStd(class1,class2)
% Data normalization to zero mean and standard deviation 1,
% separately for each feature.
%
% INPUT ARGUMENTS:
%   class1:  dataset for class1, one pattern per column.
%   class2:  dataset for class2, one pattern per column.
%
% OUTPUT ARGUMENTS:
%   class1_n:   normalized data for class1.
%   class2_n:   normalized data for class2.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[numFeat1,nPC1]=size(class1);
[numFeat2,nPC2]=size(class2);
if numFeat1~=numFeat2
    class1_n=class1;
    class2_n=class2;
    fprintf('\n ERROR: number of features is different between classes\n');
    fprintf(' NOTIFICATION: normalization has been skipped\n');
    return;
else
    numFeat=numFeat1;
end

superClass=[class1 class2];

for j=1:numFeat
    meanOfFeature=mean(superClass(j,:));
    stdOfFeature=std(superClass(j,:));
    superClass(j,:)=(superClass(j,:)-meanOfFeature)/stdOfFeature;
end

class1_n=superClass(:,1:nPC1);
class2_n=superClass(:,1+nPC1:nPC1+nPC2);
