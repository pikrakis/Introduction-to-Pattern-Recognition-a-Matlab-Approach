% Example 4.8.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Load files breastMicrocalcifications.dat and breastNormalTissue.dat
class1=load('breastMicrocalcifications.dat')';
class2=load('breastNormalTissue.dat')';

% Normalize features so that all of them have zero mean and unit variance
[class1,class2]=normalizeStd(class1,class2);

% Select the best combination of features using the J3 criterion
costFunction='ScatterMatrices';
[cLbest,Jmax]=exhaustiveSearch(class1,class2, costFunction,[3])

% 2. Form the classes c1 and c2 using the best feature combination
c1 = class1(cLbest,:);
c2 = class2(cLbest,:);

% Plot the data using the plotData function
featureNames = {'mean','st. dev.','skewness','kurtosis'};
plotData(c1,c2,cLbest,featureNames);
