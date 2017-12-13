function [p]= compositeFeaturesRanking (class1,class2,a1,a2,C)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [p]= compositeFeaturesRanking (class1,class2,a1,a2,C)
% Features are treated individually and are ranked according
% to the already computed class separability cost (matrix C) and the
% cross-correlation measure.
%
% INPUT ARGUMENTS:
%   class1:     data of the first class, one pattern per column.
%   class2:     data of the second class, one pattern per column.
%   a1,a2:      weight factors associated with the class separability cost
%               and correlation measure respectively.
%   C:          Feature ranking matrix returned by ScalarFeatureSelectionRanking.m
%
% OUTPUT ARGUMENTS:
%   p:           vector containing the new feature ranking (vector of feature ids).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[M,N]=size(class1);

sc=[class1 class2];
p(1)=C(1,2); % p holds the new ranking.
C(1,:)=[];
iter=2;
while ~isempty(C)
    rho=[]; % the following nested for loop computes the correlation, rho(j),
    % of the j-th remaining feature with the features in p (already ranked).
    % It also computes the new cost.
    for j=1:size(C,1)
        rho(j)=0;
        for k=1:size(p,1)
            rho(j)=rho(j)+abs(sum(sc(p(k),:) .* sc(C(j,2),:))/sqrt(sum(sc(p(k),:).^2)*sum(sc(C(j,2),:).^2)));
        end
        rho(j)=a1*C(j,1)-(a2/(iter-1))*rho(j); % new cost
    end
    [vali,ind]=max(rho); % this line selects the feature which maximizes the new cost
    p=[p;[C(ind,2)]]; % the selected feature is added to the end of the p vector
    C(ind,:)=[]; % the feature is removed from the C matrix, because it has been
    % included in the p vector
    iter=iter+1; % proceed with the next feature
end
