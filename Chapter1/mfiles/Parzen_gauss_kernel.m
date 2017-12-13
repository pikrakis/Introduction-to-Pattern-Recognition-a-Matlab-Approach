function [px]=Parzen_gauss_kernel(X,h,xleftlimit,xrightlimit)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [px]=Parzen_gauss_kernel(X,h,xleftlimit,xrightlimit)
% Parzen approximation of a one-dimensional pdf using a Gaussian kernel.
%
% INPUT ARGUMENTS:
%   X:              an 1xN vector, whose i-th element corresponds to the
%                   i-th data point.
%   h:              this is the step with which the x-range is sampled and
%                   also defines the volume of the Gaussian kernel.
%   xleftlimit:     smallest value of x for which the pdf will be
%                   estimated.
%   xrightlimit:    largest value of x for which the pdf will be estimated.
%
% OUTPUT ARGUMENTS:
%   px:             a vector, each element of which contains the estimate
%                   of p(x) for each x in the range [xleftlimit,
%                   xrightlimit]. The step for x is equal to h.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
xstep=h;
k=1;
x=xleftlimit;
while x<xrightlimit+xstep/2
    px(k)=0;
    for i=1:N
        xi=X(:,i);
        px(k)=px(k)+exp(-(x-xi)'*(x-xi)/(2*h^2));
    end
    px(k)=px(k)*(1/N)*(1/(((2*pi)^(l/2))*(h^l)));
    k=k+1;
    x=x+xstep;
end

