function plot_data(X,y,m,h)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   plot_data(X,y,m,h)
% Plotting utility, capable of visualizing 2-dimensional datasets that
% consist of, at most, 7 classes. It plots with different colors: (a) the 
% vectors of a data set that belong to different classes and (b) the mean 
% vectors of the classes, provided that the data are 2-dimensional and the 
% total number of classes is at most 7.
%
% INPUT ARGUMENTS:
%   X:  lxN matrix, whose columns are the data vectors to be plotted.
%   y:  N-dimensional vector whose i-th component is the class label
%       of the i-th data vector.
%   m:  lxc matrix, whose j-th column corresponds to the
%       mean vector of the j-th class.
%   h:  the handle of the figure on which the data will be plotted.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[l,N]=size(X); % N=no. of data vectors, l=dimensionality
[l,c]=size(m); % c=no. of classes

if(l~=2) || (c>7)
    fprintf('NO PLOT CAN BE GENERATED\n')
    return
else
    pale=['r.'; 'g.'; 'b.'; 'y.'; 'm.'; 'c.';'co'];
    figure(h)
    % Plot of the data vectors
    hold on
    for i=1:N
        plot(X(1,i),X(2,i),pale(y(i),:))
        hold on
    end
    
    % Plot of the class centroids
    for j=1:c
        plot(m(1,j),m(2,j),'k+')
        hold on
    end
end

