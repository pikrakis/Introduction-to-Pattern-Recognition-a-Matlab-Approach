function [px]=knn_density_estimate(X,knn,xleftlimit,xrightlimit,xstep)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [px]=knn_density_estimate(X,knn,xleftlimit,xrightlimit,xstep)
% k-nn-based approximation of a pdf at a given data range.
%
% INPUT ARGUMENTS:
%   X:              1xN vector, whose i-th element corresponds to the i-th
%                   data point.
%   knn:            number of nearest neghibors.
%   xleftlimit:     smallest value of x for which the pdf will be
%                   estimated.
%   xrightlimit:    largest value of x for which the pdf will be estimated.
%   xstep:          this is the step with which the range [xleftlimit,
%                   xrightlimit] will be sampled.
%
% OUTPUT ARGUMENTS:
%   px:             a vector, each element of which contains the estimate
%                   of p(x) for each sample of x in the range [xleftlimit,
%                   xrightlimit] (xstep has been used for sampling).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
if l>1
    px=[];
    fprintf('Feature set has more than one dimensions ');
    return;
end

k=1;
x=xleftlimit;
while x<xrightlimit+xstep/2
    eucl=[];
    for i=1:N
        eucl(i)=sqrt(sum((x-X(:,i)).^2));
    end
    eucl=sort(eucl,'ascend');
    ro=eucl(knn);
    V=2*ro;
    px(k)=knn/(N*V);
    k=k+1;
    x=x+xstep;
end
