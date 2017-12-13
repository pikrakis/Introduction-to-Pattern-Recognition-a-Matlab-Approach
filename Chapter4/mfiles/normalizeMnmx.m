function [class1_n,class2_n]=normalizeMnmx(class1,class2,par1,par2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [class1_n,class2_n]=normalizeMnmx(class1,class2,par1,par2)
% MinMax normalization to [par1 par2], e.g., [-1 1].
%
% INPUT ARGUMENTS:
%   class1:     dataset for class1, one pattern per column.
%   class2:     dataset for class2, one pattern per column.
%   par1:       desired minimum value.
%   par2:       desired maximum value.
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
    fprintf('\n ERROR: number of features differs between classes\n');
    fprintf(' NOTIFICATION: normalization has been skipped\n');
    return;
else
    numFeat=numFeat1;
end

superClass=[class1 class2];

for j=1:numFeat
    theMin=min(superClass(j,:));
    theMax=max(superClass(j,:));
    superClass(j,:)=par1+((par2-par1)*(superClass(j,:)-theMin))/(theMax-theMin);
end

class1_n=superClass(:,1:nPC1);
class2_n=superClass(:,1+nPC1:nPC1+nPC2);
