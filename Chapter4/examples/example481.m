% Example 4.8.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Load files cirrhoticLiver.dat and fattyLiver.dat
class1=load('cirrhoticLiver.dat')';
class2=load('fattyLiver.dat')';

% Normalize and rank the features using the FDR criterion 
[class1,class2]=normalizeStd(class1,class2);
[T]=ScalarFeatureSelectionRanking(class1,class2,'Fisher');

% 2. Rank the features using the features’ cross-correlation
featureNames = {'mean','st. dev.','skewness','kurtosis'};
a1=0.2;a2=0.8;
[p]= compositeFeaturesRanking (class1,class2,a1,a2,T);

% Print out the results 
fprintf('\n Scalar Feature Ranking \n');
for i=1:size(T,1)
    fprintf('(%10s) \n',featureNames{T(i,2)});
end
fprintf('\n Scalar Feature Ranking with correlation \n');
for i=1:size(p,1)
    fprintf('(%10s) \n',featureNames{p(i)});
end

