% Example 4.8.4
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Read the training data and normalize the feature values.
c1_train=load('trainingClass1.dat')';
c2_train=load('trainingClass2.dat')';

% Normalize dataset
superClass=[c1_train c2_train];
for i=1:size(superClass,1)
    m(i)=mean(superClass(i,:)); % mean value of feature
    s(i)=std (superClass(i,:)); % std of feature
    superClass(i,:)=(superClass(i,:)-m(i))/s(i);
end
c1_train=superClass(:,1:size(c1_train,2));
c2_train=superClass(:,size(c1_train,2)+1:size(superClass,2));

% 2. Rank the features using the normalized training dataset. We have adopted
% the scalar feature ranking technique which employs Fisher’s Discrimination Ratio
% in conjunction with a feature correlation measure. The ranking results are returned in variable p.
[T]=ScalarFeatureSelectionRanking(c1_train,c2_train,'Fisher');
[p]= compositeFeaturesRanking (c1_train,c2_train,0.2,0.8,T);

% 3. In order to reduce the dimensionality of the feature space, work with the 7 highest ranked features
inds=sort(p(1:7),'ascend');
c1_train=c1_train(inds,:);
c2_train=c2_train(inds,:);

% 4. Choose the best feature combination consisting of three features (out of the previously selected seven), using the exhaustive search method.
[cLbest,Jmax]= exhaustiveSearch(c1_train,c2_train,'ScatterMatrices',[3]);

% 5. Form the resulting training dataset (using the best feature combination), along with the corresponding class labels.
trainSet=[c1_train c2_train];
trainSet=trainSet(cLbest,:);
trainLabels=[ones(1,size(c1_train,2)) 2*ones(1,size(c2_train,2))];

% 6. Load the test dataset and normalize using the mean and std (computed over the training dataset)
% Form the vector of the corresponding test labels.
c1_test=load('testClass1.dat')';
c2_test=load('testClass2.dat')';
for i=1:size(c1_test,1)
    c1_test(i,:)=(c1_test(i,:)-m(i))/s(i);
    c2_test(i,:)=(c2_test(i,:)-m(i))/s(i);
end
c1_test=c1_test(inds,:);
c2_test=c2_test(inds,:);
testSet=[c1_test c2_test];
testSet=testSet(cLbest,:);
testLabels=[ones(1,size(c1_test,2)) 2*ones(1,size(c2_test,2))];

% 7. Plot the test dataset by means of function plotData
% Provide names for the features
featureNames={'mean','stand dev','skewness','kurtosis',...
    'Contrast 0','Contrast 90','Contrast 45','Contrast 135',...
    'Correlation 0','Correlation 90','Correlation 45','Correlation 135',...
    'Energy 0','Energy 90','Energy 45','Energy 135',...
    'Homogeneity 0','Homogeneity 90','Homogeneity 45','Homogeneity 135'};
fNames=featureNames(inds);
fNames=fNames(cLbest);
plotData(c1_test(cLbest,:),c2_test(cLbest,:),1:3,fNames);

% 8. Classify the feature vectors of the test data using the k-NN classifier
[classified]=k_nn_classifier(trainSet,trainLabels,3,testSet);
[classif_error]=compute_error(testLabels,classified)

% Leave-one-out (LOO) method
% (a) Load all training data, normalize them and create class labels.
c1_train=load('trainingClass1.dat')';
c1=c1_train;
Labels1=ones(1,size(c1,2));
c2_train=load('trainingClass2.dat')';
c2=c2_train;
Labels2=2*ones(1,size(c2,2));
[c1,c2]=normalizeStd(c1,c2);
AllDataset=[c1 c2];
Labels=[Labels1 Labels2];

% (b) Keep features of the best feature combination (determined previously) and discard all the rest.
AllDataset=AllDataset(inds,:);
AllDataset=AllDataset(cLbest,:);

% (c) Apply the Leave One Out method on the k-NN classifier (k = 3) and compute the error.
[M,N]=size(AllDataset);
for i=1:N
    dec(i)=k_nn_classifier([AllDataset(:,1:i-1) AllDataset(:,i+1:N)], [Labels(1,1:i-1) Labels(1,i+1:N)],3,AllDataset(:,i));
end
LOO_error=sum((dec~=Labels))/N
