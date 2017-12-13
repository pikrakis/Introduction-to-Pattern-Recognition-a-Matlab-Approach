function [w,iter,mis_clas]=perce_online(X,y,w_ini,rho)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [w,iter,mis_clas]=perce_online(X,y,w_ini,rho)
% Separates the vectors of two classes contained in a data
% set X with a hyperplane, which is iteratively adjusted via the online 
% perceptron learning rule. Note that the parameter vector is updated after
% the presentation of each data vector.
%
% NOTE: In this implementation, the learning rate is chosen to be constant.
%
% INPUT ARGUMENTS:
%  X:       lxN dimensional matrix whose columns are the data vectors to
%           be classfied.
%  y:       N-dimensional vector whose i-th  component contains the label
%           of the class where the i-th data vector belongs (+1 or -1).
%  w_ini:   l-dimensional vector which is the initial estimate of the
%           parameter vector that corresponds to the separating hyperplane.
%  rho:     the learning rate parameter for the perceptron algorithm.
%
% OUTPUT ARGUMENTS:
%  w:       the final estimate of the parameter vector.
%  iter:    the number of iterations required for the convergence of the
%           algorithm.
%  mis_clas: number of misclassified data vectors.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
max_iter=10000000; % Maximum allowable number of iterations

w=w_ini;        % Initilaization of the parameter vector
iter=0;         % Iteration counter

mis_clas=N;     % Number of misclassfied vectors

while(mis_clas>0)&&(iter<max_iter)
    mis_clas=0;
    
    for i=1:N
        if((X(:,i)'*w)*y(i)<0)
            mis_clas=mis_clas+1;
            w=w+rho*y(i)*X(:,i);  % Updating the parameter vector
        end
        iter=iter+1;
    end
    
    if(iter==1)
        mis_clas
    end
end