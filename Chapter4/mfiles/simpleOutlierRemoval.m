function [outls,index,datOut]=simpleOutlierRemoval(dat,ttimes)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [outls,Index,dat]=simpleOutlierRemoval(dat,ttimes)
% Detects and removes outliers from a normally distributed dataset by
% means of a thresholding technique. The threshold depends on
% the median value and standard deviation of the dataset.
%
% INPUT ARGUMENTS:
%   dat:        holds the normally distributed data.
%   ttimes:     controls the threshold.
%
% OUTPUT ARGUMENTS:
%   outls:      outliers that have been detected.
%   Index:      indices of the outliers in the input dat matrix.
%   datOut:     dataset after outliers have been removed.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=median(dat);
sd=std(dat);
index=find(dat>m+(ttimes*sd) | dat<m-ttimes*sd);
outls=dat(index);
datOut=dat;
datOut(index)=[];

