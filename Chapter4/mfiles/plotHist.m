function plotHist(c1,c2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   plotHist(c1,c2)
%   Plots the histograms of c1 and c2, which are both one-dimensional classes.
%
% INPUT ARGUMENTS:
%   c1:     columun vector of data for the first class.
%   c2:     column vector of data for the second class.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbins = round(numel([c1;c2])/5);
h1 = hist(c1,nbins); h2 = hist(c2,nbins);
bins1 = linspace(min(c1),max(c1),nbins);
bins2 = linspace(min(c2),max(c2),nbins);
bar(bins1,h1,2,'FaceColor',[0.2 0.2 0.2]);
hold on;
bar(bins2,h2,2,'FaceColor',[0.7 0.7 0.7]);
hold off;
grid on;
