function [cLbest,Jmax]=exhaustiveSearch(class1,class2,CostFunction,NumFeatComb)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [cLbest,Jmax]=exhaustiveSearch(class1,class2,CostFunction)
% Exhaustive search for the best feature combination consisting of
% NumFeatComb features, using the adopted class separability measure.
%
% INPUT ARGUMENTS:
%   class1:         data of the first class, one pattern per column.
%   class2:         data of the second class, one pattern per column.
%   CostFunction:   possible choices are: 'divergence', 'divergenceBhata',
%                   and 'ScatterMatrices'
%   NumFeatComb:    number of features of best feature combination.
%
% OUTPUT ARGUMENTS:
%   cLbest:         best feature combination. Row vector of feature ids.
%   Jmax:           value of the adopted separability measure for the
%                   best feature combination.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NofFeatures=size(class1,1);
Jmax=0;
cLbest=[];

cL=nchoosek(1:NofFeatures,NumFeatComb);
noOfCombinations=size(cL,1);
for combs=1:noOfCombinations
    eval(['[J]=' CostFunction '(class1(cL(combs,:),:),class2(cL(combs,:),:));']);
    if J>Jmax
        Jmax=J;
        cLbest=cL(combs,:);
    end
end
