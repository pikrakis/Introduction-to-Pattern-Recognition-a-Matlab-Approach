function [J3]=ScatterMatrices(class1,class2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [J3]=ScatterMatrices(class1,class2)
% Computes the J3 distance measure from the within-class and mixture
% scatter matrices.
%
% INPUT ARGUMENTS:
%   class1:     data of the first class, one pattern per column.
%   class2:     data of the second class, one pattern per column.
%
% OUTPUT ARGUMENTS:
%   J3:         J3 distance measure
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class1=class1'; class2=class2';
z1=cov(class1,1);
z2=cov(class2,1);
NofPattInClass1=size(class1,1);
NofPattInClass2=size(class2,1);
N=NofPattInClass1+NofPattInClass2;
Sw=((NofPattInClass1/N)*z1+(NofPattInClass2/N)*z2);
classboth=[class1;class2];
Sm=cov(classboth,1);
J3=trace(inv(Sw)*Sm)/size(class1,2);
