function pe=NN_evaluation(net,X,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  pe=NN_evaluation(net,X,y)
% Returns the classification error produced, when a specific
% neural network is applied on a given data set.
%
% INPUT ARGUMENTS:
%  net:     the neural network as a MATLAB object.
%  X:       lxN matrix whose columns are the vectors of the data set.
%  y:       N-dimensional vector containing the class labels for the data vectors.
%
% OUTPUT ARGUMENTS
%  pe:      the classification error produced when net is applied on X.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y1=sim(net,X);
pe=sum(y.*y1<0)/length(y);