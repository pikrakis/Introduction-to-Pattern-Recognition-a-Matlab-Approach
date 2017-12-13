% Example 4.8.3
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% Load the datasets of the two classes
class_1=load('testClass1.dat')';
class_2=load('testClass2.dat')';

% 1. Normalize and rank features in FDR descending order
[class_1,class_2]=normalizeStd(class_1,class_2);
[TFisher]=ScalarFeatureSelectionRanking(class_1,class_2,'Fisher');
[pFisher]= compositeFeaturesRanking(class_1,class_2,0.2,0.8,TFisher);

% 2. Select the fourteen highest ranked features
NumOfFeats=14;
inds=sort(pFisher,'ascend');

% Use function exhaustiveSearch and the J3 criterion to determine the best combination of two features
[cLbest,Jmax]=exhaustiveSearch(class_1(inds,:),class_2(inds,:),'ScatterMatrices',2);

% Print the results
fprintf('\n Exhaustive Search -> Best of two: ');
fprintf('(%d) ',inds(cLbest));

% 3. Work similarly for the suboptimal searching techniques, i.e., Sequential
% Forward Selection, Sequential Backward Selection and the Floating Search
% method

[cLbestSFS,JSFS]=SequentialForwardSelection(class_1(inds,:),class_2(inds,:),'ScatterMatrices',2);
fprintf('\n Sequential Forward Selection -> Best of two: ');
fprintf('(%d) ',inds(cLbestSFS));

[cLbestSBS,JSBS]=SequentialBackwardSelection(class_1(inds,:),class_2(inds,:),'ScatterMatrices',2);
fprintf('\n Sequential Backward Selection -> Best of two: ');
fprintf('(%d) ',inds(cLbestSBS));

[cLbestSFFS,JSFFS]=SequentialForwardFloatingSelection(class_1(inds,:),class_2(inds,:),'ScatterMatrices',2);
fprintf('\n Floating Search Method -> Best of two: ');
fprintf('(%d) ',inds(cLbestSFFS));
fprintf('\n');
