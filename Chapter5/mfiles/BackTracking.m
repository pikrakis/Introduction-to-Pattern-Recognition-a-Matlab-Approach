function [BestPath]=BackTracking(Pred,startNodek,startNodel,genPlot,P,T)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [BestPath]=BackTracking(Pred,startNodek,startNodel,genPlot,P,T)
% Performs backtracking on a matrix of node predecessors and returns the
% extracted best path starting from node (startNodek,startNodel). 
% The best path can be optionally plotted.
%
% INPUT ARGUMENTS:
%   Pred:       matrix of node predecessors. The real part of Pred(i,j) is the row
%               index of the predecessor of node (i,j). The imaginary part of Pred(i,j) is
%               the column index of the predecessor of node (i,j).
%   startNodek: row index of node from which backtracking starts.
%   startNodel: column index of node from which backtracking starts.
%   genPlot:    if set to 1, a plot of the best path is generated.
%   P:          reference sequence (horizontal axis). Needed for axis
%               labeling.
%   T:          test sequence (vertical axis). Neede for axis labeling.
%
% OUTPUT ARGUMENTS:
%   BestPath:   backtracking path, i.e., vector of nodes. Each node is represented 
%               as a complex number where the real part stands for the row 
%               index of the node and the imaginary part stands for the 
%               column index of the node.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Perform Backtracking
Node=startNodek+sqrt(-1)*startNodel;
BestPath=[Node];
while (Pred(real(Node),imag(Node))~=0)
    Node=Pred(real(Node),imag(Node));
    BestPath=[Node;BestPath];
end

%Plot the grid and best path

if genPlot==1
    clf
    hold
    axis([-0.5 length(P)+0.5 -0.5 length(T)+0.5]);
    for i=1:length(T)
        for j=1:length(P)
            plot(j,i,'r.');
        end
    end
    for i=1:length(T)
        if ~ischar(T(i))
            text(0,i, num2str(T(i)));
        else
            text(0,i, T(i));
        end
    end
    for i=1:length(P)
        if ~ischar(P(i))
            text(i,0, num2str(P(i)));
        else
            text(i,0, P(i));
        end
    end
    plot(imag(BestPath),real(BestPath),'g','LineWidth',2);
    plot(imag(BestPath),real(BestPath),'g*','LineWidth',2);
    axis off
    hold off
end

