% Example 4.6.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

clear('all');
close;

% 1. Load files cirrhoticLiver.dat and fattyLiver.dat
class1=load('cirrhoticLiver.dat')';
class2=load('fattyLiver.dat')';
feature_names={'Mean','Std','Skewness','Kurtosis'};

% 2. Calculate each feature’s FDR
[NumOfFeatures,N]=size(class1);
for i=1:NumOfFeatures
    FDR_value(i)=Fisher(class1(i,:),class2(i,:));
end

% 3. Sort features in descending FDR value
[FDR_value,feature_rank]=sort(FDR_value,'descend');
FDR_value', feature_names(feature_rank)'