function plotData(c1,c2,fc,featureNames)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   plotData(c1,c2,fc,featureNames)
% Plots the data of two classes in the same figure. If a single feature
% is used, the histogram of the feature is generated for each one of the
% two classes. If two or three features are used, this function employs
% MATLAB's "plot" or "plot3" respectively.
%
% INPUT ARGUMENTS:
%   c1:             data of the first class, one pattern per column.
%   c2:             data of the second class, one pattern per column.
%   fc:             feature combination, i.e., vector of row numbers.
%   featureNames:   names of features.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c1=c1';c2=c2';
fd = length(fc);
switch fd
    case 1
        nbins = round(numel([c1;c2])/2);
        h1 = hist(c1,nbins);
        h2 = hist(c2,nbins);
        bins1 = linspace(min(c1),max(c1),nbins);
        bins2 = linspace(min(c2),max(c2),nbins);
        bar(bins1,h1,1,'FaceColor',[0.2 0.2 0.2]);hold on;
        bar(bins2,h2,1,'FaceColor',[0.7 0.7 0.7]);
        hold off;
        xlabel(['Feature: ' featureNames{fc}],'FontSize',14);
        grid on;
        
    case 2
        plot(c1(:,1),c1(:,2),'ks',c2(:,1),c2(:,2),'k+');
        xlabel(['Feature: ' featureNames{fc(1)}],'FontSize',14);
        ylabel(['Feature: ' featureNames{fc(2)}],'FontSize',14);
        grid on;
    case 3
        plot3(c1(:,fc(1)),c1(:,fc(2)),c1(:,fc(3)),'ks',c2(:,fc(1)),c2(:,fc(2)),c2(:,fc(3)),'k+');
        xlabel(['Feature: ' featureNames{fc(1)}],'FontSize',14);
        ylabel(['Feature: ' featureNames{fc(2)}],'FontSize',14);
        zlabel(['Feature: ' featureNames{fc(3)}],'FontSize',14);
        grid on;
    otherwise
        return
end
