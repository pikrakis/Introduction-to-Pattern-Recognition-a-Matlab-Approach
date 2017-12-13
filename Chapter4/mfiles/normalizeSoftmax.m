function [class1_n,class2_n]=normalizeSoftmax(class1,class2,r)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [class1_n,class2_n]=normalizeSoftmax(class1,class2,r)
% Softmax normalization. It limits data in the range [0 1].
%
% INPUT ARGUMENTS:
%   class1:     data of the first class, one pattern per column.
%   class2:     data of the second class, one pattern per column.
%   r:          factor r, along with the standard deviation, affect the
%               range of values of data that correspond to the linear
%               section (e.g., r=0.5).
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
end

[class1,class2]=normalizeStd(class1,class2);
superClass=[class1 class2];

superClass=(1.0/r)*superClass;
superClass=1.0 ./(1.0+exp(-superClass));

class1_n=superClass(:,1:nPC1);
class2_n=superClass(:,1+nPC1:nPC1+nPC2);
