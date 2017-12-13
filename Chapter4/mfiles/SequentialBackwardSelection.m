function [cLBest,maxJ]=SequentialBackwardSelection(class1,class2,CostFunction,NumFeatComb)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [cLBest,maxJ]=SequentialBackwardSelection(class1,class2,CostFunction,NumFeatComb);
% Feature vector selection by means of the Sequential Backward Selection
% technique, given the desired number of features in the best combination.
%
% INPUT ARGUMENTS:
%   class1:         matrix of data for the first class, one pattern per column.
%   class2:         matrix of data for the second class, one pattern per column.
%   CostFunction:   class separability measure.
%   NumFeatComb:    desired number of features in best combination.
%
% OUTPUT ARGUMENTS:
%   cLbest:         selected feature subset as a vector of row indices.
%   maxJ:           class separabilty measure.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NofFeatures=size(class1,1);
eval(['[maxJ]=' CostFunction '(class1,class2);']);
cLBest=1:NofFeatures;
k=NofFeatures;
while k>NumFeatComb
    maxJ=0;
    sofar=[];
    c1=class1(cLBest,:);
    c2=class2(cLBest,:);
    cL=nchoosek(1:k,k-1);
    for i=1:size(cL,1);
        eval(['[J]=' CostFunction '(c1(cL(i,:),:),c2(cL(i,:),:));']);
        if J>maxJ
            maxJ=J;
            sofar=cL(i,:);
        end
    end
    cLBest=cLBest(sofar);
    k=k-1;
end
