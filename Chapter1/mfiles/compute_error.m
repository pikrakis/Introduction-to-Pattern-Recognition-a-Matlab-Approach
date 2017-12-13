function [clas_error]=compute_error(y,y_est)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [clas_error]=compute_error(y,t_est)
% Computes the error of a classifier based on a data set (also used in
% Chapter 4).
%
% INPUT ARGUMENTS:
%   y:      N-dimensional vector containing the class labels of the N
%           vectors of a data set.
%   y_est:  N-dimensional vector containing the labels of the classes to
%           which each one of the vectors of X has been assigned according
%           to a classification rule.
%
% OUTPUT ARGUMENTS:
%   clas_error: the classification error.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[q,N]=size(y); % N = number of vectors
c=max(y);      % Determine the number of classes
clas_error=0;  % Count the misclassified vectors
for i=1:N
    if(y(i)~=y_est(i))
        clas_error=clas_error+1;
    end
end

% Compute the classification error
clas_error=clas_error/N;
