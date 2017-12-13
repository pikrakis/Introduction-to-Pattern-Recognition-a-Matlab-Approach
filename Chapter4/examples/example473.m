% Example 4.7.3
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Load files “cirrhoticLiver.dat” and “fattyLiver.dat” 
class1=load('cirrhoticLiver.dat')';
class2=load('fattyLiver.dat')';

% Normalize features 
[class1,class2]=normalizeStd(class1,class2);

% 2. Evaluate J3 for the three-feature combination [1, 2, 3], where 1 stands for the mean, 2 for std, and so on
[J]=ScatterMatrices(class1([1 2 3],:),class2([1 2 3],:))

% Work similarly to evaluate the J3 for the remaining three-feature combinations,
% i.e., [1, 2, 4], [1, 3, 4], [2, 3, 4]. Remove the comments as appropriate.
%  [J]=ScatterMatrices(class1([1 2 4],:),class2([1 2 4],:));
%  [J]=ScatterMatrices(class1([1 3 4],:),class2([1 3 4],:));
%  [J]=ScatterMatrices(class1([2 3 4],:),class2([2 3 4],:));

% 3. Plot the results of the feature combination [1, 2, 3]. Use function plotData

featureNames = {'mean','standart dev','skewness','kurtosis'};
plotData(class1,class2,[1 2 3],featureNames);

