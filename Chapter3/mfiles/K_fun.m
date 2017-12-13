function [z]=K_fun(x,y,choice,para)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [z]=K_fun(x,y,choice,para)
% Computes the value of a kernel function for two vectors.
%
% INPUT ARGUMENTS:
%   x,y:    two l-dimensional column vectors.
%   choice: the type of kernel function to be used ('pol' for (x'*y+c)^n,
%           'exp' for exp(-(x-y)'*(x-y)/(2*sigma^2)))
%   para:   a two-dimensional vector containing the parameters for the
%           kernel function: (a) for polynomials it is
%           (x'*y+para(1))^para(2) and (b) for exponentials it is
%           exp(-(x-y)'*(x-y)/(2*para(1)^2)).
%
% OUTPUT ARGUMENTS:
%   z:      the value of the kernel function.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(choice=='pol')
    z=(x'*y+para(1))^para(2);
else
    z=exp(-(x-y)'*(x-y)/(2*para(1)^2));
end